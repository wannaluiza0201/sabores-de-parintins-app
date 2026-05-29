import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Status normalizado da permissão de localização.
///
/// Mapeamos os 3 estados do permission_handler + um adicional
/// (`serviceDisabled` = usuário tem permissão mas desligou o GPS no celular).
/// Manter um enum próprio isola a UI dos detalhes dos plugins.
enum LocationPermissionStatus { granted, denied, deniedForever, serviceDisabled }

/// Wrapper sobre geolocator + permission_handler.
///
/// POR QUE SEPARAR DA UI: testabilidade. Em testes de widget você pode
/// substituir essa classe por um mock; a tela não precisa saber qual
/// plugin foi usado. Também concentra a lógica de timeout/erros num
/// lugar só — a UI consome um Future tipado.
class LocationService {
  const LocationService();

  /// Consulta SEM disparar o dialog nativo. Útil pra decidir se
  /// mostramos rationale customizado primeiro.
  Future<LocationPermissionStatus> checkPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return LocationPermissionStatus.serviceDisabled;
    }
    final status = await Permission.location.status;
    return _map(status);
  }

  /// Dispara o dialog nativo do sistema operacional.
  /// Se já estiver granted, retorna direto sem mostrar dialog.
  Future<LocationPermissionStatus> requestPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return LocationPermissionStatus.serviceDisabled;
    }
    final status = await Permission.location.request();
    return _map(status);
  }

  /// Pega a posição atual com timeout de 10s. Retorna `null` se:
  /// - permissão não concedida
  /// - GPS desligado
  /// - timeout (sinal fraco em ambiente fechado, por exemplo)
  Future<Position?> getCurrentPosition() async {
    try {
      final permission = await checkPermission();
      if (permission != LocationPermissionStatus.granted) return null;
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } on TimeoutException {
      return null;
    } on LocationServiceDisabledException {
      return null;
    } catch (_) {
      return null;
    }
  }

  LocationPermissionStatus _map(PermissionStatus s) {
    if (s.isGranted || s.isLimited) return LocationPermissionStatus.granted;
    if (s.isPermanentlyDenied) return LocationPermissionStatus.deniedForever;
    return LocationPermissionStatus.denied;
  }
}
