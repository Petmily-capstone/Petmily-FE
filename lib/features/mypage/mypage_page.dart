import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/auth_provider.dart';
import '../../state/pet_provider.dart';

/// 마이페이지. 사용자 정보 · 반려동물 목록 · 설정 · 로그아웃.
class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    await ref.read(authProvider.notifier).signOut();
    if (context.mounted) context.go(Routes.login);
  }

  Future<void> _editName(
    BuildContext context,
    WidgetRef ref,
    String current,
  ) async {
    final name = await showDialog<String>(
      context: context,
      builder: (_) => _EditNameDialog(initial: current),
    );
    if (name == null) return;
    try {
      await ref.read(authProvider.notifier).updateDisplayName(name);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이름 변경에 실패했어요. 다시 시도해 주세요.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((s) => s.user));
    final pets = ref.watch(petProvider).value?.pets ?? const [];

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 34,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: HeaderTitle(
                    title: user?.name ?? '게스트',
                    // 이메일이 없으면 빈 줄이 생기지 않도록 null 전달.
                    subtitle: (user?.email.isNotEmpty ?? false)
                        ? user!.email
                        : null,
                  ),
                ),
                if (user != null)
                  IconButton(
                    onPressed: () => _editName(context, ref, user.name),
                    icon: const Icon(Icons.edit_outlined, color: Colors.white),
                    tooltip: '이름 편집',
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page,
              AppSpacing.section,
              AppSpacing.page,
              AppSpacing.section,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '내 반려동물',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton.icon(
                      onPressed: () => context.push(Routes.petSetup),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('추가'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                if (pets.isEmpty)
                  const Text(
                    '등록된 반려동물이 없어요.',
                    style: TextStyle(color: AppColors.textMuted),
                  )
                else
                  for (final pet in pets) ...[
                    _PetRow(pet: pet),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                const SizedBox(height: AppSpacing.section),
                Text('설정', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),
                const _MenuTile(
                  icon: Icons.notifications_outlined,
                  label: '알림 설정',
                ),
                const SizedBox(height: AppSpacing.lg),
                const _MenuTile(
                  icon: Icons.headset_mic_outlined,
                  label: '고객센터',
                ),
                const SizedBox(height: AppSpacing.lg),
                const _MenuTile(icon: Icons.info_outline, label: '앱 정보'),
                const SizedBox(height: AppSpacing.section),
                PrimaryButton(
                  label: '로그아웃',
                  variant: AppButtonVariant.ghost,
                  onPressed: () => _logout(context, ref),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PetRow extends StatelessWidget {
  const _PetRow({required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 64,
              height: 64,
              child: pet.imageUrl == null
                  ? Container(
                      color: AppColors.background,
                      child: const Icon(
                        Icons.pets,
                        color: AppColors.primaryLight,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: pet.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => Container(
                        color: AppColors.background,
                        child: const Icon(
                          Icons.pets,
                          color: AppColors.primaryLight,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  [
                    pet.species.label,
                    if (pet.breed != null) pet.breed!,
                  ].join(' · '),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          AppBadge(label: 'Lv.${pet.level}', color: AppBadgeColor.blue),
        ],
      ),
    );
  }
}

/// 표시 이름 편집 다이얼로그. 확인 시 새 이름을, 취소 시 null을 반환한다.
class _EditNameDialog extends StatefulWidget {
  const _EditNameDialog({required this.initial});
  final String initial;

  @override
  State<_EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<_EditNameDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('이름 편집'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 20,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
        decoration: const InputDecoration(
          hintText: '이름을 입력하세요',
          counterText: '',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        TextButton(onPressed: _submit, child: const Text('저장')),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      // TODO: 각 설정 화면 연결.
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, color: AppColors.textBody, size: 24),
          const SizedBox(width: AppSpacing.lg),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.textStrong,
            ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
