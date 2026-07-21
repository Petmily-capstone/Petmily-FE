import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/models.dart';
import 'repository_providers.dart';

/// 진단 화면 상태.
class DiagnosisState {
  const DiagnosisState({
    this.isSubmitting = false,
    this.latest,
    this.history = const [],
    this.error,
  });

  final bool isSubmitting;

  /// 방금 요청한 진단 결과.
  final Diagnosis? latest;
  final List<Diagnosis> history;
  final String? error;

  DiagnosisState copyWith({
    bool? isSubmitting,
    Diagnosis? latest,
    List<Diagnosis>? history,
    String? error,
  }) {
    return DiagnosisState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      latest: latest ?? this.latest,
      history: history ?? this.history,
      error: error,
    );
  }
}

/// 진단 도메인 유스케이스.
class DiagnosisNotifier extends Notifier<DiagnosisState> {
  @override
  DiagnosisState build() => const DiagnosisState();

  Future<void> loadHistory(String petId) async {
    final history =
        await ref.read(diagnosisRepositoryProvider).fetchHistory(petId);
    state = state.copyWith(history: history);
  }

  /// 증상으로 진단 요청. 성공 시 [DiagnosisState.latest]에 결과를 담는다.
  Future<Diagnosis?> request({
    required String petId,
    required String symptomText,
    String? imagePath,
  }) async {
    state = state.copyWith(isSubmitting: true);
    try {
      final result = await ref.read(diagnosisRepositoryProvider).requestDiagnosis(
            petId: petId,
            symptomText: symptomText,
            imagePath: imagePath,
          );
      state = state.copyWith(
        isSubmitting: false,
        latest: result,
        history: [result, ...state.history],
      );
      return result;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: '진단 요청에 실패했습니다. 다시 시도해 주세요.',
      );
      return null;
    }
  }

  /// 결과 화면을 벗어날 때 최신 결과 초기화.
  void clearLatest() => state = state.copyWith(latest: null);
}

final diagnosisProvider =
    NotifierProvider<DiagnosisNotifier, DiagnosisState>(DiagnosisNotifier.new);
