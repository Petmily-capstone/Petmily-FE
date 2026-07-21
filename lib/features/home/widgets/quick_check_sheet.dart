import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/models/models.dart';
import '../../../state/pet_provider.dart';

/// 오늘의 케어 그룹 체크 바텀시트를 띄운다.
///
/// 항목을 선택하고 '완료'를 누르면 변경분만 [PetNotifier.toggleCheck]로 반영한다.
Future<void> showQuickCheckSheet(
  BuildContext context,
  WidgetRef ref,
  QuickCheckGroup group,
) {
  final check = ref.read(petProvider).value?.todayCheck;
  final initial = {
    for (final t in group.items)
      if (check?.isDone(t) ?? false) t,
  };

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
    ),
    builder: (_) => _QuickCheckSheet(
      group: group,
      initialSelected: initial,
      onConfirm: (selected) async {
        final notifier = ref.read(petProvider.notifier);
        // 초기 상태와 달라진 항목만 토글.
        for (final t in group.items) {
          final wasDone = initial.contains(t);
          final nowDone = selected.contains(t);
          if (wasDone != nowDone) await notifier.toggleCheck(t);
        }
      },
    ),
  );
}

class _QuickCheckSheet extends StatefulWidget {
  const _QuickCheckSheet({
    required this.group,
    required this.initialSelected,
    required this.onConfirm,
  });

  final QuickCheckGroup group;
  final Set<QuickCheckType> initialSelected;
  final Future<void> Function(Set<QuickCheckType> selected) onConfirm;

  @override
  State<_QuickCheckSheet> createState() => _QuickCheckSheetState();
}

class _QuickCheckSheetState extends State<_QuickCheckSheet> {
  late Set<QuickCheckType> _selected = {...widget.initialSelected};
  bool _saving = false;

  int get _points => _selected.length * 2;

  Future<void> _confirm() async {
    setState(() => _saving = true);
    await widget.onConfirm(_selected);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
            Text(widget.group.question,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            const Text('체크한 항목마다 +2점이 올라요',
                style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: AppSpacing.xl),
            for (final type in widget.group.items) ...[
              _CheckRow(
                type: type,
                checked: _selected.contains(type),
                onTap: () => setState(() {
                  _selected.contains(type)
                      ? _selected.remove(type)
                      : _selected.add(type);
                  _selected = {..._selected};
                }),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: '취소',
                    variant: AppButtonVariant.ghost,
                    onPressed: _saving ? null : () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: PrimaryButton(
                    label: '완료 ($_points점)',
                    loading: _saving,
                    onPressed: _saving ? null : _confirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckRow extends StatelessWidget {
  const _CheckRow({
    required this.type,
    required this.checked,
    required this.onTap,
  });

  final QuickCheckType type;
  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          color: checked ? const Color(0xFFEFF6FF) : AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: checked ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Text(type.emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: AppSpacing.md),
            Text(type.label,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textStrong)),
            const Spacer(),
            Icon(
              checked ? Icons.check_circle : Icons.circle_outlined,
              color: checked ? AppColors.primary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
