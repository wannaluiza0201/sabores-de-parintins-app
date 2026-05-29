import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/auth_events.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../services/auth_api_service.dart';
import '../services/google_sign_in_service.dart';
import '../services/secure_storage_service.dart';

// ============================================================
// AuthState — estado consumido pela UI
// ============================================================

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  final AuthStatus status;
  final AuthUser? user;
  final String? errorMessage;

  const AuthState.initial() : this(status: AuthStatus.initial);
  const AuthState.loading() : this(status: AuthStatus.loading);
  const AuthState.authenticated(AuthUser user)
      : this(status: AuthStatus.authenticated, user: user);
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);
  const AuthState.error(String message)
      : this(status: AuthStatus.error, errorMessage: message);
}

// ============================================================
// Repository provider
// ============================================================

/// Singleton do repository. SecureStorageService é instanciado aqui
/// E também dentro do AuthInterceptor — ambos compartilham a mesma
/// FlutterSecureStorage (que é stateless), então duplicar o wrapper é OK.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    google: GoogleSignInService(),
    api: AuthApiService(ref.watch(dioProvider)),
    storage: SecureStorageService(),
  );
});

// ============================================================
// AuthState provider — NotifierProvider (Riverpod 3)
// ============================================================

/// CONCEITO — Notifier vs AsyncNotifier:
/// - `Notifier<T>` é síncrono: o `state` é um valor concreto que você
///   controla (aqui `AuthState`, que TEM um campo status interno).
/// - `AsyncNotifier<T>` empacota tudo num `AsyncValue<T>` (loading/data/
///   error) — útil quando o build inicial é um Future.
///
/// Escolhi Notifier porque já modelamos o status manualmente. Adicionar
/// AsyncValue por cima seria redundante.
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Escuta o stream do interceptor — se chegar 401 em qualquer
    // request, o estado vira unauthenticated automaticamente.
    final sub = AuthEvents.unauthorized.listen((_) {
      state = const AuthState.unauthenticated();
    });
    ref.onDispose(sub.cancel);
    return const AuthState.initial();
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  /// Disparado pelo LoginButton. UI mostra spinner enquanto `status =
  /// loading`. Cancelamento pelo usuário NÃO vira erro — volta pra
  /// unauthenticated.
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      final user = await _repo.signInWithGoogle();
      state = AuthState.authenticated(user);
    } on AuthCancelledException {
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(_friendlyError(e));
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    await _repo.signOut();
    state = const AuthState.unauthenticated();
  }

  /// Chamado uma vez no boot do app. Lê token salvo e valida.
  Future<void> restore() async {
    state = const AuthState.loading();
    final user = await _repo.restoreSession();
    state = user == null
        ? const AuthState.unauthenticated()
        : AuthState.authenticated(user);
  }

  String _friendlyError(Object e) {
    final s = e.toString();
    if (s.contains('SocketException') || s.contains('Network')) {
      return 'Sem conexão. Verifique a internet e tente de novo.';
    }
    if (s.contains('PlatformException')) {
      return 'Google Play Services indisponível ou desatualizado.';
    }
    return 'Não foi possível entrar. Tente de novo.';
  }
}

final authStateProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

// ============================================================
// Derivados — açúcar pra widgets que não precisam de tudo
// ============================================================

/// `AuthUser?` direto, pra widgets que só usam o usuário.
final currentUserProvider = Provider<AuthUser?>((ref) {
  return ref.watch(authStateProvider).user;
});

/// `bool` simples — útil pra `if (isLoggedIn) ... else ...`.
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).status == AuthStatus.authenticated;
});
