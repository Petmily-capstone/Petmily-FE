import 'package:intl/intl.dart';

/// 원화/날짜 등 표시용 포맷 유틸.
///
/// 화면 위젯에서 직접 NumberFormat을 만들지 말고 여기 함수를 사용한다.
abstract final class Formatters {
  static final NumberFormat _won = NumberFormat('#,###');
  static final DateFormat _dateDot = DateFormat('yyyy.MM.dd');
  static final DateFormat _monthDay = DateFormat('M월 d일');

  /// 38000 → "38,000원"
  static String won(num value) => '${_won.format(value)}원';

  /// 38000 → "38,000" (단위 없이)
  static String number(num value) => _won.format(value);

  /// DateTime → "2026.07.21"
  static String dateDot(DateTime date) => _dateDot.format(date);

  /// DateTime → "7월 21일"
  static String monthDay(DateTime date) => _monthDay.format(date);

  /// 오늘 기준 상대 표현: "오늘"/"어제"/"N일 전"
  static String relativeDay(DateTime date, {DateTime? now}) {
    final base = now ?? DateTime.now();
    final d0 = DateTime(base.year, base.month, base.day);
    final d1 = DateTime(date.year, date.month, date.day);
    final diff = d0.difference(d1).inDays;
    if (diff <= 0) return '오늘';
    if (diff == 1) return '어제';
    return '$diff일 전';
  }
}
