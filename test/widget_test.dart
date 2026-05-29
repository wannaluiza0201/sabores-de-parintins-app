import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sabores_parintins_app/app.dart';

void main() {
  testWidgets('App renderiza com título "Sabores de Parintins"', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.text('Sabores de Parintins'), findsWidgets);
  });
}
