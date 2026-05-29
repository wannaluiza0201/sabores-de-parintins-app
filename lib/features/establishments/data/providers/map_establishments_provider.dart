import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../models/establishment.dart';
import 'establishment_providers.dart';

/// Lista filtrada pra plotagem no mapa: só estabelecimentos com coords
/// válidas. Derivado do `establishmentsProvider` (lista completa da API).
///
/// `latitude/longitude` no model são `double` (não-nullable), então
/// "sem coords" significa **exatamente** lat=0 e lng=0 (default que o
/// backend usa quando o estabelecimento nunca preencheu).
final mapEstablishmentsProvider = Provider<List<Establishment>>((ref) {
  final list = ref.watch(establishmentsProvider).value ?? const [];
  return list
      .where((e) => e.latitude != 0 && e.longitude != 0)
      .toList(growable: false);
});

/// Posição do usuário no celular. `null` enquanto o FAB de localização
/// não foi acionado OU se o usuário negou a permissão.
///
/// `Notifier<Position?>` (Riverpod 3) — `StateProvider` foi removido na
/// v3. O setter é o método `set` da classe.
class UserLocationNotifier extends Notifier<Position?> {
  @override
  Position? build() => null;

  void set(Position? p) => state = p;
}

final userLocationProvider =
    NotifierProvider<UserLocationNotifier, Position?>(
      UserLocationNotifier.new,
    );
