import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persiste a preferência de idioma do app.
///
/// Reusa flutter_secure_storage (já no projeto) — não é "segredo", mas
/// evita adicionar nova dependência só pra 1 valor. Não acopla ao
/// SecureStorageService de auth porque idioma é uma preocupação à parte.
///
/// Valor armazenado: código de língua ISO 639-1 (`pt`, `en`, `es`) ou
/// ausente (= usar locale do sistema).
class LocaleStorageService {
  LocaleStorageService()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock,
          ),
        );

  final FlutterSecureStorage _storage;

  static const _key = 'app_locale';

  Future<String?> read() => _storage.read(key: _key);

  Future<void> save(String languageCode) =>
      _storage.write(key: _key, value: languageCode);

  /// Remove a preferência — volta a usar o locale do sistema.
  Future<void> clear() => _storage.delete(key: _key);
}
