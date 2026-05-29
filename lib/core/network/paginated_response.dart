/// Envelope genérico pra respostas paginadas do Laravel (padrão
/// `{data: [...], meta: {current_page, last_page, ...}, links: {...}}`).
///
/// Mantemos só o essencial pro infinite-scroll. Se um dia precisar de
/// per_page/total/first_page_url, basta estender.
class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
  });

  final List<T> data;
  final int currentPage;
  final int lastPage;

  bool get hasMore => currentPage < lastPage;

  /// Constrói a partir do JSON cru do Laravel + uma função que sabe
  /// deserializar cada item da lista (ex: `Establishment.fromJson`).
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dataList = (json['data'] as List<dynamic>)
        .map((e) => fromJsonT(e as Map<String, dynamic>))
        .toList(growable: false);

    final meta = json['meta'] as Map<String, dynamic>?;
    // Defensivo: se a API mudar e meta sumir, assume 1 página única.
    return PaginatedResponse(
      data: dataList,
      currentPage: (meta?['current_page'] as int?) ?? 1,
      lastPage: (meta?['last_page'] as int?) ?? 1,
    );
  }
}
