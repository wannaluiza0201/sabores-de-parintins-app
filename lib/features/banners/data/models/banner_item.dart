import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_item.freezed.dart';
part 'banner_item.g.dart';

/// Banner promocional retornado por `GET /api/v1/banners`.
///
/// Nome `BannerItem` (não `Banner`) porque `Banner` colidiria com o
/// widget `Banner` do Material/widgets (aquele do canto "DEBUG").
@freezed
abstract class BannerItem with _$BannerItem {
  const factory BannerItem({
    required int id,
    required String title,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'link_url') String? linkUrl,
  }) = _BannerItem;

  factory BannerItem.fromJson(Map<String, dynamic> json) =>
      _$BannerItemFromJson(json);
}
