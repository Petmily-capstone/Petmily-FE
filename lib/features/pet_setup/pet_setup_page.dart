import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/pet_provider.dart';
import 'widgets/pet_setup_widgets.dart';

/// 펫 등록 7단계 위저드.
///
/// 종 → 이름 → 생년월일 → 성별 → 품종/크기 → 중성화 → 체중 순으로 입력받는다.
class PetSetupPage extends ConsumerStatefulWidget {
  const PetSetupPage({super.key});

  @override
  ConsumerState<PetSetupPage> createState() => _PetSetupPageState();
}

class _PetSetupPageState extends ConsumerState<PetSetupPage> {
  static const _totalSteps = 7;

  int _step = 0;
  bool _saving = false;

  // 수집 값
  PetSpecies? _species;
  final _name = TextEditingController();
  DateTime? _birthDate;
  PetGender? _gender;
  final _breed = TextEditingController();
  DogSize? _size;
  bool? _neutered;
  final _weight = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _breed.dispose();
    _weight.dispose();
    super.dispose();
  }

  bool get _isLast => _step == _totalSteps - 1;

  /// 현재 단계 입력이 유효해 '다음'을 누를 수 있는지.
  bool get _canProceed => switch (_step) {
        0 => _species != null,
        1 => _name.text.trim().isNotEmpty,
        2 => _birthDate != null,
        3 => _gender != null,
        4 => true, // 품종/크기는 선택
        5 => _neutered != null,
        6 => true, // 체중은 선택
        _ => false,
      };

  void _back() {
    if (_step == 0) {
      context.pop();
    } else {
      setState(() => _step--);
    }
  }

  Future<void> _next() async {
    if (!_canProceed) return;
    if (!_isLast) {
      setState(() => _step++);
      return;
    }
    await _save();
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 1, now.month, now.day),
      firstDate: DateTime(now.year - 30),
      lastDate: now,
      helpText: '생년월일 선택',
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final pet = Pet(
      id: '',
      name: _name.text.trim(),
      species: _species!,
      breed: _breed.text.trim().isEmpty ? null : _breed.text.trim(),
      gender: _gender,
      birthDate: _birthDate,
      size: _species == PetSpecies.dog ? _size : null,
      neutered: _neutered,
      weightKg: double.tryParse(_weight.text.trim()),
    );
    try {
      final created = await ref.read(petProvider.notifier).addPet(pet);
      await ref.read(petProvider.notifier).selectPet(created.id);
      if (mounted) context.go(Routes.home);
    } catch (_) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장에 실패했어요. 다시 시도해 주세요.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _WizardHeader(
              step: _step,
              total: _totalSteps,
              onBack: _back,
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: SingleChildScrollView(
                  key: ValueKey(_step),
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: _buildStep(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: PrimaryButton(
                label: _isLast ? '완료' : '다음',
                loading: _saving,
                onPressed: _canProceed && !_saving ? _next : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return WizardStep(
          title: '어떤 반려동물인가요?',
          child: Row(
            children: [
              for (final s in PetSpecies.values) ...[
                Expanded(
                  child: SpeciesCard(
                    species: s,
                    selected: _species == s,
                    onTap: () => setState(() => _species = s),
                  ),
                ),
                if (s != PetSpecies.values.last)
                  const SizedBox(width: AppSpacing.md),
              ],
            ],
          ),
        );
      case 1:
        return WizardStep(
          title: '반려동물 이름은 뭔가요?',
          child: WizardTextField(
            controller: _name,
            hint: '예: 초코',
            autofocus: true,
            onChanged: (_) => setState(() {}),
          ),
        );
      case 2:
        return WizardStep(
          title: '생년월일을 입력해주세요',
          child: WizardDateField(date: _birthDate, onTap: _pickBirthDate),
        );
      case 3:
        return WizardStep(
          title: '성별을 선택해주세요',
          child: Row(
            children: [
              for (final g in PetGender.values) ...[
                Expanded(
                  child: ChoiceCard(
                    label: g.label,
                    icon: g == PetGender.male ? Icons.male : Icons.female,
                    selected: _gender == g,
                    onTap: () => setState(() => _gender = g),
                  ),
                ),
                if (g != PetGender.values.last)
                  const SizedBox(width: AppSpacing.md),
              ],
            ],
          ),
        );
      case 4:
        return WizardStep(
          title: '품종을 선택해주세요',
          subtitle: '직접 입력할 수 있어요.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WizardTextField(
                controller: _breed,
                hint: _species == PetSpecies.cat ? '예: 코리안숏헤어' : '예: 푸들',
                onChanged: (_) => setState(() {}),
              ),
              if (_species == PetSpecies.dog) ...[
                const SizedBox(height: AppSpacing.xl),
                Text('크기', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    for (final size in DogSize.values) ...[
                      Expanded(
                        child: ChoiceCard(
                          label: size.label,
                          selected: _size == size,
                          onTap: () => setState(() => _size = size),
                          compact: true,
                        ),
                      ),
                      if (size != DogSize.values.last)
                        const SizedBox(width: AppSpacing.sm),
                    ],
                  ],
                ),
              ],
            ],
          ),
        );
      case 5:
        return WizardStep(
          title: '중성화 수술을 했나요?',
          child: Row(
            children: [
              Expanded(
                child: ChoiceCard(
                  label: '했어요',
                  icon: Icons.check_circle_outline,
                  selected: _neutered == true,
                  onTap: () => setState(() => _neutered = true),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ChoiceCard(
                  label: '안 했어요',
                  icon: Icons.remove_circle_outline,
                  selected: _neutered == false,
                  onTap: () => setState(() => _neutered = false),
                ),
              ),
            ],
          ),
        );
      case 6:
        return WizardStep(
          title: '체중을 알려주세요',
          subtitle: '나중에 마이페이지에서 바꿀 수 있어요.',
          child: WizardTextField(
            controller: _weight,
            hint: '4.2',
            suffix: 'kg',
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

/// 상단 진행 헤더(뒤로가기 + N/7 + 진행 바).
class _WizardHeader extends StatelessWidget {
  const _WizardHeader({
    required this.step,
    required this.total,
    required this.onBack,
  });

  final int step;
  final int total;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm, AppSpacing.sm, AppSpacing.xl, AppSpacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                color: AppColors.textStrong,
              ),
              Text('펫 등록 · ${step + 1} / $total',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBody)),
              const Spacer(),
              Text('${((step + 1) / total * 100).round()}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: AppProgressBar(value: (step + 1) / total),
          ),
        ],
      ),
    );
  }
}
