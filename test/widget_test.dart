import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jppecas_app/main.dart';

void main() {
  testWidgets('App loads produtos screen', (WidgetTester tester) async {
    await tester.pumpWidget(const JPApp());
    expect(find.text('JP Peças'), findsOneWidget);
  });
}
