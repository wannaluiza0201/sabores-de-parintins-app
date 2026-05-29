import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/providers/auth_providers.dart';
import '../../../auth/data/services/secure_storage_service.dart';
import '../repositories/favorites_repository.dart';

/// Notifier do conjunto de IDs favoritados.
///
/// Estado: `Set<int>` de IDs em memória. Persistido no SecureStorage a
/// cada mudança pra sobreviver a cold-start (UX otimista mantém o
/// coração preenchido antes da reconciliação com backend).
///
/// CICLO DE VIDA (em ordem de execução):
/// 1. `build()` retorna `{}` síncrono e dispara `_hydrate` em microtask.
/// 2. `_hydrate` lê IDs do SecureStorage (rápido) e popula o Set.
/// 3. Se o usuário já está autenticado nesse build (ex.: restore() do
///    boot terminou antes), dispara `_reconcile` em paralelo.
/// 4. `ref.listen(authStateProvider)` cobre transições FUTURAS:
///    login → reconcile, logout → clear local.
///
/// RACE conditions: hydrate (storage) é mais rápido que reconcile
/// (rede). Se reconcile retornar primeiro, hydrate NÃO sobrescreve
/// (vê `state.isNotEmpty` e desiste).
class FavoritesNotifier extends Notifier<Set<int>> {
  // Construímos uma instância nova de SecureStorageService — é
  // stateless (envelopa FlutterSecureStorage que é singleton).
  final _storage = SecureStorageService();

  static const _maxPages = 10; // 150 favoritos — safety cap.

  @override
  Set<int> build() {
    // Hidrata do storage em microtask: build() PRECISA retornar síncrono.
    Future.microtask(_hydrateFromStorage);

    // Se o app abriu com sessão restaurada, dispara reconcile já.
    // (O ref.listen abaixo NÃO pega o estado atual — só transições.)
    final initialAuth = ref.read(authStateProvider);
    if (initialAuth.status == AuthStatus.authenticated) {
      Future.microtask(_reconcileFromBackend);
    }

    // Observa transições futuras de auth.
    ref.listen<AuthState>(authStateProvider, (prev, next) {
      final wasAuth = prev?.status == AuthStatus.authenticated;
      final isAuth = next.status == AuthStatus.authenticated;
      if (!wasAuth && isAuth) {
        _reconcileFromBackend();
      } else if (wasAuth && !isAuth) {
        _clearLocal();
      }
    });

    return const <int>{};
  }

  // ============================================================
  // API pública
  // ============================================================

  /// Consulta síncrona — usada pelo FavoriteButton no build.
  bool isFavorited(int establishmentId) => state.contains(establishmentId);

  /// Toggle otimista:
  /// 1. Atualiza Set local + persiste storage IMEDIATAMENTE
  /// 2. Chama API (favorite/unfavorite conforme novo estado)
  /// 3. Se API falhar, REVERTE local + persiste de novo, e relança
  ///    a exception (UI mostra SnackBar)
  Future<void> toggle(int establishmentId, String slug) async {
    final wasFavorited = state.contains(establishmentId);
    // Cópia mutável a partir do state (imutabilidade preservada).
    final optimistic = Set<int>.from(state);
    if (wasFavorited) {
      optimistic.remove(establishmentId);
    } else {
      optimistic.add(establishmentId);
    }
    state = optimistic;
    await _persist();

    try {
      final repo = ref.read(favoritesRepositoryProvider);
      if (wasFavorited) {
        await repo.unfavorite(slug);
      } else {
        await repo.favorite(slug);
      }
    } catch (e) {
      // Reverte: rolling back pra o estado anterior.
      final reverted = Set<int>.from(state);
      if (wasFavorited) {
        reverted.add(establishmentId);
      } else {
        reverted.remove(establishmentId);
      }
      state = reverted;
      await _persist();
      rethrow;
    }
  }

  // ============================================================
  // Internos
  // ============================================================

  Future<void> _hydrateFromStorage() async {
    final ids = await _storage.readFavoritedIds();
    if (ids == null || ids.isEmpty) return;
    // Reconcile pode ter completado primeiro — não sobrescreve.
    if (state.isEmpty) state = ids;
  }

  /// Busca todas as páginas de `/favorites` (até _maxPages) e
  /// substitui o Set. Backend é a fonte da verdade quando logado.
  Future<void> _reconcileFromBackend() async {
    try {
      final repo = ref.read(favoritesRepositoryProvider);
      final all = <int>{};
      var page = 1;
      while (page <= _maxPages) {
        final res = await repo.getFavorites(page: page);
        all.addAll(res.data.map((e) => e.id));
        if (!res.hasMore) break;
        page++;
      }
      state = all;
      await _persist();
    } catch (_) {
      // OFFLINE/erro: mantém o Set hidratado do storage. Próxima
      // abertura ou login tenta reconciliar de novo. Falha silenciosa
      // intencional — UX não bloqueia a Home/Detail/Mapa.
    }
  }

  Future<void> _clearLocal() async {
    state = const <int>{};
    await _storage.deleteFavoritedIds();
  }

  Future<void> _persist() => _storage.saveFavoritedIds(state);
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<int>>(
  FavoritesNotifier.new,
);
