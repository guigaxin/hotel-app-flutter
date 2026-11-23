import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_app/main.dart';

void main() {
  testWidgets('Renderiza tela inicial e lista o hospede padrao', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaPrincipal()));

    expect(find.text('Controle de Hóspedes'), findsOneWidget);
    expect(find.text('Marina'), findsOneWidget);
  });
}