import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:petmily_fe/app.dart';

void main() {
  testWidgets('앱이 정상적으로 부팅된다', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PetmilyApp()));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('펫밀리'), findsOneWidget);
  });
}
