import '../models/models.dart';

/// AI 증상 진단 도메인 Repository 인터페이스.
abstract interface class DiagnosisRepository {
  /// 증상 텍스트(+선택 사진)로 진단을 요청한다.
  ///
  /// 서버가 담당할 추론이므로 목에서도 비동기로 처리한다.
  Future<Diagnosis> requestDiagnosis({
    required String petId,
    required String symptomText,
    // TODO: 진단 사진 업로드 연동. 지금은 로컬 경로 자리만 받는다.
    String? imagePath,
  });

  /// 특정 펫의 진단 이력(최신순).
  Future<List<Diagnosis>> fetchHistory(String petId);
}
