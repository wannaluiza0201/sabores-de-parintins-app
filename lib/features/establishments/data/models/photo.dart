import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';
part 'photo.g.dart';

/// Foto da galeria de um estabelecimento.
/// Resposta de `GET /api/v1/establishments/{slug}/photos`.
@freezed
abstract class Photo with _$Photo {
  const factory Photo({
    required int id,
    required String url,
    String? caption,
    @JsonKey(name: 'sort_order') required int sortOrder,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
