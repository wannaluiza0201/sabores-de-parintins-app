/// Payload de uma push notification, já interpretado para roteamento.
///
/// O backend envia o bloco `data` do FCM em formato:
/// ```json
/// { "type": "establishment", "slug": "boi-bumba-burger" }
/// ```
/// (chave/valor SEMPRE strings — limitação do FCM, não dá pra mandar
/// número ou objeto aninhado sem serializar).
///
/// Esta classe encapsula 2 casos:
/// - `PushPayload.establishment(slug)` → navegar pro detalhe
/// - `PushPayload.home()` → fallback (sem data, type desconhecido, ou
///   payload inválido)
sealed class PushPayload {
  const PushPayload();

  /// Decodifica um `Map<String, dynamic>` (vindo de `RemoteMessage.data`
  /// ou do payload string de uma local notification).
  ///
  /// Nunca lança — qualquer formato inesperado vira `PushPayload.home()`.
  factory PushPayload.fromData(Map<String, dynamic>? data) {
    if (data == null || data.isEmpty) return const PushPayloadHome();
    final type = data['type'];
    if (type is! String) return const PushPayloadHome();

    switch (type) {
      case 'establishment':
        final slug = data['slug'];
        if (slug is String && slug.isNotEmpty) {
          return PushPayloadEstablishment(slug: slug);
        }
        return const PushPayloadHome();
      default:
        return const PushPayloadHome();
    }
  }
}

final class PushPayloadHome extends PushPayload {
  const PushPayloadHome();
}

final class PushPayloadEstablishment extends PushPayload {
  const PushPayloadEstablishment({required this.slug});
  final String slug;
}
