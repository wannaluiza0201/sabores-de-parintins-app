import 'package:freezed_annotation/freezed_annotation.dart';

import 'category.dart';

part 'establishment_mini.freezed.dart';
part 'establishment_mini.g.dart';

/// Versão **mínima** de Establishment usada em payloads embedded — onde
/// o backend só envia os campos essenciais pra identificar/exibir o
/// estabelecimento em outro contexto.
///
/// USO ATUAL:
/// - `GET /me/reviews` → cada review traz um `establishment` mini
/// - Argumento de `ReviewFormSheet.show()` (sheet só usa slug/name/cover)
///
/// Diferente do `Establishment` (lista) que tem 17 campos com vários
/// required — manter modelos separados evita parse error quando o
/// payload é propositalmente reduzido.
@freezed
abstract class EstablishmentMini with _$EstablishmentMini {
  const factory EstablishmentMini({
    required int id,
    required String slug,
    required String name,
    @JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,
    @JsonKey(name: 'primary_category') required Category primaryCategory,
  }) = _EstablishmentMini;

  factory EstablishmentMini.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentMiniFromJson(json);
}
