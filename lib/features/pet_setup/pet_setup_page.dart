import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/pet_provider.dart';

/// 펫 등록 화면. 이름/종/성별/품종/체중을 입력해 반려동물을 추가한다.
class PetSetupPage extends ConsumerStatefulWidget {
  const PetSetupPage({super.key});

  @override
  ConsumerState<PetSetupPage> createState() => _PetSetupPageState();
}

class _PetSetupPageState extends ConsumerState<PetSetupPage> {
  final _name = TextEditingController();
  final _breed = TextEditingController();
  final _weight = TextEditingController();

  PetSpecies _species = PetSpecies.dog;
  PetGender? _gender;
  DateTime? _birthDate;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _breed.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 1, now.month, now.day),
      firstDate: DateTime(now.year - 30),
      lastDate: now,
      helpText: '생일 선택',
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) {
      setState(() => _error = '이름을 입력해 주세요.');
      return;
    }
    setState(() {
      _error = null;
      _saving = true;
    });

    final pet = Pet(
      id: '',
      name: _name.text.trim(),
      species: _species,
      breed: _breed.text.trim().isEmpty ? null : _breed.text.trim(),
      gender: _gender,
      birthDate: _birthDate,
      weightKg: double.tryParse(_weight.text.trim()),
    );

    try {
      await ref.read(petProvider.notifier).addPet(pet);
      if (mounted) context.go(Routes.home);
    } catch (_) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = '저장에 실패했습니다. 다시 시도해 주세요.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.textStrong,
        backgroundColor: AppColors.background,
        title: const Text('반려동물 등록'),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Label('어떤 아이인가요?'),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  for (final s in PetSpecies.values) ...[
                    Expanded(
                      child: _SpeciesCard(
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
              const SizedBox(height: AppSpacing.xl),
              const _Label('이름'),
              const SizedBox(height: AppSpacing.sm),
              _Input(controller: _name, hint: '예: 초코'),
              const SizedBox(height: AppSpacing.xl),
              const _Label('성별'),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  for (final g in PetGender.values) ...[
                    _ChoiceChip(
                      label: g.label,
                      selected: _gender == g,
                      onTap: () => setState(() => _gender = g),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              const _Label('품종 (선택)'),
              const SizedBox(height: AppSpacing.sm),
              _Input(controller: _breed, hint: '예: 푸들'),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _Label('체중 (kg, 선택)'),
                        const SizedBox(height: AppSpacing.sm),
                        _Input(
                          controller: _weight,
                          hint: '4.2',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _Label('생일 (선택)'),
                        const SizedBox(height: AppSpacing.sm),
                        _DateField(
                          date: _birthDate,
                          onTap: _pickBirthDate,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(_error!,
                    style: const TextStyle(
                        color: AppColors.danger, fontSize: 13)),
              ],
              const SizedBox(height: AppSpacing.xxxl),
              PrimaryButton(
                label: '등록 완료',
                loading: _saving,
                onPressed: _saving ? null : _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) =>
      Text(text, style: Theme.of(context).textTheme.titleMedium);
}

class _SpeciesCard extends StatelessWidget {
  const _SpeciesCard({
    required this.species,
    required this.selected,
    required this.onTap,
  });

  final PetSpecies species;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: 1.4,
          ),
        ),
        child: Column(
          children: [
            Icon(
              species == PetSpecies.dog ? Icons.pets : Icons.cruelty_free,
              size: 34,
              color: selected ? Colors.white : AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              species.label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : AppColors.textStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textBody,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.controller,
    this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.date, required this.onTap});
  final DateTime? date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date == null
                  ? '선택'
                  : '${date!.year}.${date!.month.toString().padLeft(2, '0')}.${date!.day.toString().padLeft(2, '0')}',
              style: TextStyle(
                color: date == null ? AppColors.textMuted : AppColors.textStrong,
              ),
            ),
            const Icon(Icons.calendar_today_outlined,
                size: 18, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
