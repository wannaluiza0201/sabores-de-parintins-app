import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/services/secure_storage_service.dart';
import '../config/app_config.dart';
import 'auth_interceptor.dart';

part 'dio_client.g.dart';

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      // Base URL centralizada em AppConfig (gitignored, varia por máquina).
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
      headers: const {'Accept': 'application/json'},
      responseType: ResponseType.json,
    ),
  );

  // AuthInterceptor ANTES do LogInterceptor pra que o Bearer apareça
  // no log da request.
  dio.interceptors.add(AuthInterceptor(SecureStorageService()));

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        responseHeader: false,
        requestBody: false,
        responseBody: true,
      ),
    );
  }

  return dio;
}

/// Cliente HTTP compartilhado durante toda a sessão do app.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) => _createDio();
