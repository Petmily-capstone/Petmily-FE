import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'daily_check.freezed.dart';
part 'daily_check.g.dart';

/// 특정 펫의 하루치 퀵체크 상태.
@freezed
abstract class DailyCheck with _$DailyCheck {
  const DailyCheck._();

  const factory DailyCheck({
    required String petId,
    required DateTime date,
    @Default(<QuickCheckType>[]) List<QuickCheckType> completed,
  }) = _DailyCheck;

  factory DailyCheck.fromJson(Map<String, dynamic> json) =>
      _$DailyCheckFromJson(json);

  bool isDone(QuickCheckType type) => completed.contains(type);

  /// 오늘 완료 항목으로 획득한 총 경험치.
  int get earnedExp =>
      completed.fold(0, (sum, type) => sum + type.exp);
}
