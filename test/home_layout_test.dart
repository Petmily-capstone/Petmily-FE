import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petmily_fe/core/theme/theme.dart';
import 'package:petmily_fe/features/home/home_page.dart';

/// 홈 화면 렌더 스모크 테스트.
///
/// 목 Repository 로딩이 풀린 뒤 주요 섹션이 실제 데이터로 그려지고,
/// 렌더 중 예외가 발생하지 않는지 확인한다.
void main() {
  testWidgets('홈 화면이 목 데이터로 정상 렌더된다', (tester) async {
    // 폰 너비 기준. 높이는 ListView 지연 빌드를 피해 전 섹션이 렌더되도록 크게 잡는다.
    tester.view.physicalSize = const Size(393, 1500);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const HomePage()),
      ),
    );

    // 목 Repository 지연(펫 400ms → 그 뒤 콘텐츠 300ms)이 순차로 풀리도록 프레임을 진행.
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }

    // 로딩 상태가 아니라 실제 데이터가 그려졌는지 확인.
    expect(find.text('초코'), findsOneWidget);
    expect(find.text('Lv.3 건강 지킴이'), findsOneWidget);
    expect(find.text('오늘의 Quick Check'), findsOneWidget);
    expect(find.text('산책/놀이'), findsOneWidget);
    expect(find.text('식사/급수/영양'), findsOneWidget);
    expect(find.text('말티즈 여름 피부 관리법'), findsOneWidget);

    expect(tester.takeException(), isNull);

    // 이미지 로더/애니메이션의 잔여 타이머 정리.
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
  });
}
