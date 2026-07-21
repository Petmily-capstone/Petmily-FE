import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:petmily_fe/app.dart';

void main() {
  testWidgets('앱이 스플래시로 부팅된다', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PetmilyApp()));
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('펫밀리'), findsOneWidget);
  });
}
