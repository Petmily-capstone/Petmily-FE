import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/formatters.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/diagnosis_provider.dart';
import '../../state/pet_provider.dart';

/// AI 증상 진단 화면. 증상 입력 → 진단 요청 → 결과/이력 표시.
class DiagnosisPage extends ConsumerStatefulWidget {
  const DiagnosisPage({super.key});

  @override
  ConsumerState<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends ConsumerState<DiagnosisPage> {
  final _symptom = TextEditingController();
  String? _loadedPetId;

  @override
  void dispose() {
    _symptom.dispose();
    super.dispose();
  }

  void _ensureHistory(Pet pet) {
    if (_loadedPetId == pet.id) return;
    _loadedPetId = pet.id;
    // 프레임 이후에 로드(빌드 중 상태 변경 방지).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(diagnosisProvider.notifier).loadHistory(pet.id);
    });
  }

  /// 최신 결과 카드와 중복되지 않도록 이력에서 최신 항목을 제외.
  List<Diagnosis> _pastHistory(DiagnosisState diag) {
    final latestId = diag.latest?.id;
    return diag.history.where((d) => d.id != latestId).toList();
  }

  Future<void> _submit(Pet pet) async {
    final text = _symptom.text.trim();
    if (text.isEmpty) return;
    FocusScope.of(context).unfocus();
    await ref.read(diagnosisProvider.notifier).request(
          petId: pet.id,
          symptomText: text,
        );
    _symptom.clear();
  }

  @override
  Widget build(BuildContext context) {
    final pet = ref.watch(activePetProvider);
    final diag = ref.watch(diagnosisProvider);

    if (pet == null) {
      return const Scaffold(
        body: Center(
          child: Text('반려동물을 먼저 등록해 주세요.',
              style: TextStyle(color: AppColors.textMuted)),
        ),
      );
    }
    _ensureHistory(pet);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const GradientHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI 증상 진단',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: AppSpacing.xs),
                Text('증상을 입력하면 AI가 상태를 살펴봐요.',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${pet.name}의 증상',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: _symptom,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: '예: 어제부터 기침을 하고 밥을 잘 안 먹어요.',
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.md),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // TODO: 진단 사진 업로드 연동.
                      ScaleTap(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('사진 첨부는 준비 중이에요.')),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            border: Border.all(
                              color: AppColors.border,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_outlined,
                                  size: 18, color: AppColors.textMuted),
                              SizedBox(width: AppSpacing.sm),
                              Text('사진 첨부 (선택)',
                                  style:
                                      TextStyle(color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      PrimaryButton(
                        label: 'AI 진단 받기',
                        loading: diag.isSubmitting,
                        onPressed: diag.isSubmitting ? null : () => _submit(pet),
                      ),
                    ],
                  ),
                ),
                if (diag.latest != null) ...[
                  const SizedBox(height: AppSpacing.xl),
                  _ResultCard(diagnosis: diag.latest!),
                ],
                if (_pastHistory(diag).isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xxl),
                  Text('진단 이력',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.md),
                  for (final d in _pastHistory(diag)) ...[
                    _HistoryTile(diagnosis: d),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

AppBadgeColor _severityColor(DiagnosisSeverity s) => switch (s) {
      DiagnosisSeverity.low => AppBadgeColor.green,
      DiagnosisSeverity.medium => AppBadgeColor.yellow,
      DiagnosisSeverity.high => AppBadgeColor.red,
    };

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.diagnosis});
  final Diagnosis diagnosis;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.primary, size: 20),
              const SizedBox(width: AppSpacing.sm),
              const Text('진단 결과',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              AppBadge(
                label: diagnosis.severity.label,
                color: _severityColor(diagnosis.severity),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(diagnosis.resultTitle,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(diagnosis.resultSummary,
              style: Theme.of(context).textTheme.bodyMedium),
          if (diagnosis.recommendations.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            const Text('권장 사항',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
            const SizedBox(height: AppSpacing.sm),
            for (final rec in diagnosis.recommendations)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ',
                        style: TextStyle(color: AppColors.primary)),
                    Expanded(
                      child: Text(rec,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.diagnosis});
  final Diagnosis diagnosis;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(diagnosis.resultTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(Formatters.dateDot(diagnosis.createdAt),
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          AppBadge(
            label: diagnosis.severity.label,
            color: _severityColor(diagnosis.severity),
          ),
        ],
      ),
    );
  }
}
