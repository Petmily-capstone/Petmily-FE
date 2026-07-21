import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:petmily_fe/app.dart';

void main() {
  testWidgets('앱이 스플래시로 부팅되어 온보딩으로 진행된다',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PetmilyApp()));

    // 첫 프레임: 스플래시.
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('펫밀리'), findsOneWidget);

    // 세션 복원(400ms)과 스플래시 노출(1300ms) 타이머를 소진.
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // 미인증 상태이므로 온보딩으로 이동.
    expect(find.text('시작하기'), findsNothing); // 첫 슬라이드에서는 '다음'
    expect(find.text('다음'), findsOneWidget);
  });
}
