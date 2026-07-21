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

  /// 그룹 내 완료 항목 수.
  int doneCountIn(QuickCheckGroup group) =>
      group.items.where(completed.contains).length;

  /// 그룹 완료 여부(항목 하나라도 체크되면 완료로 간주).
  bool isGroupDone(QuickCheckGroup group) => doneCountIn(group) > 0;

  /// 오늘 완료한 그룹 수(홈의 'N/2 완료').
  int get doneGroupCount =>
      QuickCheckGroup.values.where(isGroupDone).length;

  /// 오늘 완료 항목으로 획득한 총 경험치.
  int get earnedExp => completed.fold(0, (sum, type) => sum + type.exp);
}
