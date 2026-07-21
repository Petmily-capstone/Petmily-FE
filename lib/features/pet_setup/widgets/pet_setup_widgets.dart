import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/models/models.dart';

/// 위저드 단계 공통 레이아웃(제목 + 부제 + 본문).
class WizardStep extends StatelessWidget {
  const WizardStep({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
        ],
        const SizedBox(height: AppSpacing.xxxl),
        child,
      ],
    );
  }
}

/// 종 선택 카드(강아지/고양이).
class SpeciesCard extends StatelessWidget {
  const SpeciesCard({
    super.key,
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
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
        decoration: _selectableDecoration(selected),
        child: Column(
          children: [
            Text(
              species == PetSpecies.dog ? '🐶' : '🐱',
              style: const TextStyle(fontSize: 44),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              species.label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.primary : AppColors.textStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 일반 선택 카드(성별/중성화/크기 등).
class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.compact = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: compact ? AppSpacing.md : AppSpacing.xl),
        decoration: _selectableDecoration(selected),
        child: Column(
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 28,
                  color: selected ? AppColors.primary : AppColors.textMuted),
              const SizedBox(height: AppSpacing.sm),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: compact ? 13 : 15,
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.primary : AppColors.textStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 위저드 공용 입력 필드.
class WizardTextField extends StatelessWidget {
  const WizardTextField({
    super.key,
    required this.controller,
    this.hint,
    this.suffix,
    this.keyboardType,
    this.autofocus = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hint;
  final String? suffix;
  final TextInputType? keyboardType;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        suffixText: suffix,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
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

/// 생년월일 선택 필드.
class WizardDateField extends StatelessWidget {
  const WizardDateField({super.key, required this.date, required this.onTap});

  final DateTime? date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
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
                  ? '날짜를 선택하세요'
                  : '${date!.year}년 ${date!.month}월 ${date!.day}일',
              style: TextStyle(
                color:
                    date == null ? AppColors.textMuted : AppColors.textStrong,
                fontWeight: date == null ? FontWeight.normal : FontWeight.w600,
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

/// 선택 가능 요소 공통 데코(선택 시 파란 보더/연한 배경).
BoxDecoration _selectableDecoration(bool selected) {
  return BoxDecoration(
    color: selected ? const Color(0xFFEFF6FF) : AppColors.surface,
    borderRadius: BorderRadius.circular(AppRadius.lg),
    border: Border.all(
      color: selected ? AppColors.primary : AppColors.border,
      width: selected ? 1.6 : 1.2,
    ),
  );
}
