import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/pet_provider.dart';

/// 홈 화면. 활성 펫의 펫밀리 레벨과 오늘의 퀵체크를 보여준다.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petState = ref.watch(petProvider);

    return Scaffold(
      body: petState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const _HomeError(),
        data: (state) {
          final pet = state.activePet;
          if (pet == null) return const _EmptyPets();
          return _HomeContent(state: state, pet: pet);
        },
      ),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.state, required this.pet});

  final PetState state;
  final Pet pet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final check = state.todayCheck;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _Header(state: state, pet: pet),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('오늘의 케어',
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    '+${check?.earnedExp ?? 0} exp',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.92,
                children: [
                  for (final type in QuickCheckType.values)
                    _CheckTile(
                      type: type,
                      done: check?.isDone(type) ?? false,
                      onTap: () =>
                          ref.read(petProvider.notifier).toggleCheck(type),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text('바로가기', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _ShortcutCard(
                      icon: Icons.medical_services_rounded,
                      title: 'AI 진단',
                      subtitle: '증상 확인하기',
                      onTap: () => context.go(Routes.diagnosis),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _ShortcutCard(
                      icon: Icons.shopping_bag_rounded,
                      title: '맞춤 쇼핑',
                      subtitle: '추천 사료 보기',
                      onTap: () => context.go(Routes.shop),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.state, required this.pet});

  final PetState state;
  final Pet pet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GradientHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('안녕하세요 👋',
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              _Avatar(url: pet.imageUrl),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          pet.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Text(
                            'Lv.${pet.level}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [pet.species.label, if (pet.breed != null) pet.breed!]
                          .join(' · '),
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppProgressBar(
            value: pet.levelProgress,
            color: Colors.white,
            backgroundColor: Colors.white24,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '다음 레벨까지 ${pet.expToNextLevel} exp',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          if (state.pets.length > 1) ...[
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.pets.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (_, i) {
                  final p = state.pets[i];
                  final selected = p.id == pet.id;
                  return ScaleTap(
                    onTap: () =>
                        ref.read(petProvider.notifier).selectPet(p.id),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: selected ? Colors.white : Colors.white24,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        p.name,
                        style: TextStyle(
                          color: selected ? AppColors.primary : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: url == null || url!.isEmpty
          ? const Icon(Icons.pets, color: AppColors.primary)
          : CachedNetworkImage(
              imageUrl: url!,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) =>
                  const Icon(Icons.pets, color: AppColors.primary),
            ),
    );
  }
}

class _CheckTile extends StatelessWidget {
  const _CheckTile({
    required this.type,
    required this.done,
    required this.onTap,
  });

  final QuickCheckType type;
  final bool done;
  final VoidCallback onTap;

  IconData get _icon => switch (type) {
        QuickCheckType.walk => Icons.directions_walk_rounded,
        QuickCheckType.meal => Icons.restaurant_rounded,
        QuickCheckType.water => Icons.water_drop_rounded,
        QuickCheckType.potty => Icons.wc_rounded,
        QuickCheckType.play => Icons.sports_baseball_rounded,
        QuickCheckType.grooming => Icons.content_cut_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: done ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: AppShadows.soft,
          border: Border.all(
            color: done ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_icon,
                size: 28, color: done ? Colors.white : AppColors.primary),
            const SizedBox(height: AppSpacing.sm),
            Text(
              type.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: done ? Colors.white : AppColors.textBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  const _ShortcutCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: AppSpacing.md),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: AppColors.textStrong)),
          const SizedBox(height: 2),
          Text(subtitle,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _EmptyPets extends StatelessWidget {
  const _EmptyPets();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.pets, size: 56, color: AppColors.primaryLight),
            const SizedBox(height: AppSpacing.lg),
            const Text('등록된 반려동물이 없어요',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.sm),
            const Text('첫 반려동물을 등록하고 케어를 시작해 보세요.',
                style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: '반려동물 등록',
              expanded: false,
              onPressed: () => context.push(Routes.petSetup),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('정보를 불러오지 못했어요.',
          style: TextStyle(color: AppColors.textMuted)),
    );
  }
}
