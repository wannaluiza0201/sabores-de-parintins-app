import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_user.dart';

/// Wrapper sobre `flutter_secure_storage` — só os 4 keys que usamos.
///
/// Por que SecureStorage e não SharedPreferences:
/// - Android: usa o **Keystore** (chave criptográfica em hardware-backed
///   keystore quando disponível, fallback pra software keystore).
/// - iOS: usa o **Keychain**, escopado por app.
/// SharedPreferences é texto plano — token nunca vai aí.
///
/// `AndroidOptions(encryptedSharedPreferences: true)` é necessário em
/// flutter_secure_storage 9.x pra usar EncryptedSharedPreferences moderno
/// (vs. o backend antigo que tinha problemas em alguns devices).
class SecureStorageService {
  SecureStorageService()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock,
          ),
        );

  final FlutterSecureStorage _storage;

  static const _kToken = 'auth_token';
  static const _kUser = 'auth_user';
  static const _kFavorites = 'favorited_ids';

  Future<void> saveToken(String token) =>
      _storage.write(key: _kToken, value: token);

  Future<String?> readToken() => _storage.read(key: _kToken);

  Future<void> deleteToken() => _storage.delete(key: _kToken);

  Future<void> saveUser(AuthUser user) =>
      _storage.write(key: _kUser, value: user.toJsonString());

  Future<AuthUser?> readUser() async {
    final raw = await _storage.read(key: _kUser);
    if (raw == null || raw.isEmpty) return null;
    try {
      return AuthUser.fromJsonString(raw);
    } catch (_) {
      // Storage corrompido (mudança de schema, etc.) — trata como ausente.
      await deleteUser();
      return null;
    }
  }

  Future<void> deleteUser() => _storage.delete(key: _kUser);

  // ============================================================
  // Favoritos — IDs de Establishments favoritados.
  // Persistidos pra sobreviver a app cold-start (UX otimista mantém
  // o coração preenchido antes da reconciliação com o backend).
  // ============================================================

  Future<void> saveFavoritedIds(Set<int> ids) =>
      _storage.write(key: _kFavorites, value: jsonEncode(ids.toList()));

  Future<Set<int>?> readFavoritedIds() async {
    final raw = await _storage.read(key: _kFavorites);
    if (raw == null || raw.isEmpty) return null;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.cast<int>().toSet();
    } catch (_) {
      // Storage corrompido — trata como ausente e remove.
      await deleteFavoritedIds();
      return null;
    }
  }

  Future<void> deleteFavoritedIds() => _storage.delete(key: _kFavorites);

  /// Apaga token + user + favoritos (logout completo).
  Future<void> clear() async {
    await Future.wait([deleteToken(), deleteUser(), deleteFavoritedIds()]);
  }
}
