import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/banner_item.dart';

/// Cache local de banners — JSON + timestamp em flutter_secure_storage.
///
/// Por que SecureStorage e não Hive: o projeto já depende de
/// secure_storage (auth + locale). Hive está no pubspec mas nunca foi
/// inicializado (sem `Hive.initFlutter()`), e adicionar isso só pra
/// guardar uma lista pequena seria desproporcional. Banners não são
/// segredo, mas o overhead do encrypted storage é trivial.
class BannersCacheService {
  BannersCacheService()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock,
          ),
        );

  final FlutterSecureStorage _storage;

  static const _kData = 'banners_data';
  static const _kCachedAt = 'banners_cached_at';

  /// Retorna a tupla (banners, cachedAt) ou null se não há cache válido
  /// (nunca escrito ou JSON corrompido).
  Future<({List<BannerItem> banners, DateTime cachedAt})?> read() async {
    final raw = await _storage.read(key: _kData);
    final whenRaw = await _storage.read(key: _kCachedAt);
    if (raw == null || whenRaw == null) return null;

    try {
      final list = jsonDecode(raw) as List<dynamic>;
      final banners = list
          .map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
      final cachedAt = DateTime.parse(whenRaw);
      return (banners: banners, cachedAt: cachedAt);
    } catch (_) {
      // Storage corrompido (mudança de schema, JSON parcial, etc.)
      // — apaga e trata como ausente.
      await clear();
      return null;
    }
  }

  Future<void> write(List<BannerItem> banners) async {
    final json = jsonEncode(banners.map((b) => b.toJson()).toList());
    await _storage.write(key: _kData, value: json);
    await _storage.write(
      key: _kCachedAt,
      value: DateTime.now().toIso8601String(),
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: _kData);
    await _storage.delete(key: _kCachedAt);
  }
}
