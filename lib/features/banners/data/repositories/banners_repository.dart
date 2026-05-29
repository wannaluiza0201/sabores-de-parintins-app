import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/banner_item.dart';
import '../services/banners_cache_service.dart';

/// Stale-while-error sobre `GET /api/v1/banners`.
///
/// O servidor cacheia por ~10 min — alinhamos o TTL local pra evitar
/// chamadas redundantes que devolveriam o mesmo conteúdo.
///
/// Política:
/// 1. Cache válido (idade < TTL) → retorna cache, NÃO chama rede.
/// 2. Cache expirado OU ausente → tenta fetch.
///    - Sucesso: salva cache fresco e retorna.
///    - Falha: se existir cache (mesmo expirado), retorna stale; se
///      não há cache, rethrow → a UI cai no fallback (PromoBanner).
class BannersRepository {
  BannersRepository({
    required Dio dio,
    required BannersCacheService cache,
  })  : _dio = dio,
        _cache = cache;

  final Dio _dio;
  final BannersCacheService _cache;

  static const Duration _ttl = Duration(minutes: 10);

  Future<List<BannerItem>> fetchBanners() async {
    final cached = await _cache.read();

    if (cached != null) {
      final age = DateTime.now().difference(cached.cachedAt);
      if (age < _ttl) return cached.banners;
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>('/banners');
      final list = response.data!['data'] as List<dynamic>;
      final banners = list
          .map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
      await _cache.write(banners);
      return banners;
    } on DioException catch (e) {
      debugPrint('[BannersRepository] fetch falhou: ${e.message}');
      if (cached != null) return cached.banners;
      rethrow;
    }
  }
}
