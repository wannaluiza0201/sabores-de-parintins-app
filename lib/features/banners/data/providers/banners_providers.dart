import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../models/banner_item.dart';
import '../repositories/banners_repository.dart';
import '../services/banners_cache_service.dart';

part 'banners_providers.g.dart';

@Riverpod(keepAlive: true)
BannersCacheService bannersCacheService(Ref ref) => BannersCacheService();

@Riverpod(keepAlive: true)
BannersRepository bannersRepository(Ref ref) {
  return BannersRepository(
    dio: ref.watch(dioProvider),
    cache: ref.watch(bannersCacheServiceProvider),
  );
}

/// Lista de banners pra Home. AsyncValue na UI:
/// - loading/error → carrossel cai no PromoBanner (fallback).
/// - data vazia → idem.
/// - data populada → renderiza o carrossel.
@riverpod
Future<List<BannerItem>> banners(Ref ref) {
  return ref.watch(bannersRepositoryProvider).fetchBanners();
}
