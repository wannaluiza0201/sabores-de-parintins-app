import 'package:dio/dio.dart';

import '../models/category.dart';
import '../models/establishment.dart';
import '../models/establishment_detail.dart';
import '../models/photo.dart';

class EstablishmentRepository {
  EstablishmentRepository(this._dio);

  final Dio _dio;

  /// `GET /api/v1/establishments` — lista paginada. A API já ordena
  /// (abertos primeiro + prioridade por horário + seed diário), por isso
  /// a tela não reordena.
  Future<List<Establishment>> fetchEstablishments({
    String? search,
    String? category,
    bool? openNow,
    String? neighborhood,
    int? page,
    int? perPage,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/establishments',
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        'category': ?category,
        if (openNow == true) 'open_now': 1,
        'neighborhood': ?neighborhood,
        'page': ?page,
        'per_page': ?perPage,
      },
    );

    final list = response.data!['data'] as List<dynamic>;
    return list
        .map((e) => Establishment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// `GET /api/v1/categories` — todas as categorias com `establishments_count`.
  Future<List<Category>> fetchCategories() async {
    final response = await _dio.get<Map<String, dynamic>>('/categories');
    final list = response.data!['data'] as List<dynamic>;
    return list
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// `GET /api/v1/establishments/{slug}` — forma rica (contato, features,
  /// horários, etc.). Usado pela tela de detalhe.
  Future<EstablishmentDetail> fetchEstablishmentDetail(String slug) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/establishments/$slug',
    );
    return EstablishmentDetail.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }

  /// `GET /api/v1/establishments/{slug}/photos` — galeria do estabelecimento.
  Future<List<Photo>> fetchEstablishmentPhotos(String slug) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/establishments/$slug/photos',
    );
    final list = response.data!['data'] as List<dynamic>;
    return list.map((e) => Photo.fromJson(e as Map<String, dynamic>)).toList();
  }
}
