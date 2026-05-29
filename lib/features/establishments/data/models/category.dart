import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

/// Categoria gastronômica retornada por `GET /api/v1/categories` e também
/// aninhada dentro de `Establishment` (sem `establishments_count` nesse caso).
@freezed
abstract class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    required String slug,
    // Nome do ícone (Font Awesome / Lucide style): `coffee`, `utensils`,
    // `fish`, `pizza`, `hamburger`, `beer`, `ice-cream`, `bowl`, `store`.
    // Nullable: o backend permite categoria sem ícone (cai no fallback
    // visual `Icons.restaurant_menu`).
    String? icon,
    @JsonKey(name: 'establishments_count') int? establishmentsCount,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
