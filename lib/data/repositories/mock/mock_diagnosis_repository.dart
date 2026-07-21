import '../../models/models.dart';
import '../../mock/mock_data.dart';
import '../diagnosis_repository.dart';

/// 목 진단 구현. 증상 텍스트에 간단한 규칙을 적용해 결과를 흉내 낸다.
class MockDiagnosisRepository implements DiagnosisRepository {
  final List<Diagnosis> _history = MockData.diagnoses();
  int _seq = 100;

  @override
  Future<Diagnosis> requestDiagnosis({
    required String petId,
    required String symptomText,
    String? imagePath,
  }) async {
    // 서버 추론을 흉내 내기 위해 조금 더 긴 지연을 준다.
    await Future.delayed(const Duration(milliseconds: 1200));

    final severity = _inferSeverity(symptomText);
    final diagnosis = Diagnosis(
      id: 'd${_seq++}',
      petId: petId,
      createdAt: DateTime.now(),
      symptomText: symptomText,
      imageUrl: imagePath, // TODO: 업로드 후 원격 URL로 대체.
      resultTitle: _titleFor(severity),
      resultSummary: _summaryFor(severity),
      severity: severity,
      recommendations: _recommendationsFor(severity),
    );
    _history.insert(0, diagnosis);
    return diagnosis;
  }

  @override
  Future<List<Diagnosis>> fetchHistory(String petId) async {
    await Future.delayed(const Duration(milliseconds: 350));
    final items = _history.where((d) => d.petId == petId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  DiagnosisSeverity _inferSeverity(String text) {
    final t = text.toLowerCase();
    const high = ['피', '경련', '호흡곤란', '쓰러', '구토', '발작'];
    const medium = ['설사', '기침', '식욕', '가려움', '토'];
    if (high.any(t.contains)) return DiagnosisSeverity.high;
    if (medium.any(t.contains)) return DiagnosisSeverity.medium;
    return DiagnosisSeverity.low;
  }

  String _titleFor(DiagnosisSeverity s) => switch (s) {
        DiagnosisSeverity.high => '즉시 진료가 필요한 증상 의심',
        DiagnosisSeverity.medium => '경과 관찰이 필요한 증상',
        DiagnosisSeverity.low => '경미한 증상으로 보입니다',
      };

  String _summaryFor(DiagnosisSeverity s) => switch (s) {
        DiagnosisSeverity.high =>
          '위험 신호가 감지되었습니다. 가까운 동물병원에 바로 방문하세요.',
        DiagnosisSeverity.medium =>
          '당장 위급하진 않지만 증상이 지속되면 진료가 필요합니다.',
        DiagnosisSeverity.low =>
          '일시적인 컨디션 저하로 보입니다. 수분과 휴식을 챙겨 주세요.',
      };

  List<String> _recommendationsFor(DiagnosisSeverity s) => switch (s) {
        DiagnosisSeverity.high => [
            '지체 없이 동물병원에 방문하세요.',
            '이동 중 반려동물을 안정시키고 체온을 유지하세요.',
          ],
        DiagnosisSeverity.medium => [
            '식사·배변·활동량을 기록해 두세요.',
            '48시간 내 호전되지 않으면 진료를 받으세요.',
          ],
        DiagnosisSeverity.low => [
            '충분한 수분과 휴식을 제공하세요.',
            '증상 변화를 관찰하고 악화 시 병원을 찾으세요.',
          ],
      };
}
