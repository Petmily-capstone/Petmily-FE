import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/pet_provider.dart';
import '../../state/shop_provider.dart';
import 'widgets/quick_check_sheet.dart';

/// 홈 화면. 펫 카드 캐러셀 · 펫밀리 레벨 · 오늘의 케어 · AI 코멘트 · 건강 콘텐츠.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petState = ref.watch(petProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: petState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => const _HomeError(),
          data: (state) {
            final pet = state.activePet;
            if (pet == null) return const _EmptyPets();
            return _HomeContent(state: state, pet: pet);
          },
        ),
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
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl, AppSpacing.xl, AppSpacing.xl, 40),
      children: [
        const _TopBar(),
        const SizedBox(height: AppSpacing.xl),
        _PetCarousel(state: state),
        const SizedBox(height: AppSpacing.xxl),
        _LevelCard(pet: pet),
        const SizedBox(height: AppSpacing.xxl),
        _QuickCheckSection(check: check),
        const SizedBox(height: AppSpacing.xxl),
        _AiCommentCard(pet: pet),
        const SizedBox(height: AppSpacing.xxxl),
        const _HealthContentSection(),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  static const _weekdays = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = '${now.month}월 ${now.day}일 (${_weekdays[now.weekday - 1]})';
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(today,
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 13)),
            const SizedBox(height: 2),
            Text('펫밀리', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
        const Spacer(),
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: AppShadows.soft,
          ),
          child: const Icon(Icons.notifications_none_rounded,
              color: AppColors.textBody),
        ),
      ],
    );
  }
}

/// 펫 카드 캐러셀. 오른쪽으로 스와이프하면 마지막에 '반려동물 추가' 카드가 나온다.
class _PetCarousel extends ConsumerStatefulWidget {
  const _PetCarousel({required this.state});
  final PetState state;

  @override
  ConsumerState<_PetCarousel> createState() => _PetCarouselState();
}

class _PetCarouselState extends ConsumerState<_PetCarousel> {
  late final PageController _controller;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    final pets = widget.state.pets;
    final initial = pets.indexWhere((p) => p.id == widget.state.activePetId);
    _page = initial < 0 ? 0 : initial;
    _controller = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pets = widget.state.pets;
    final pageCount = pets.length + 1; // + 추가 카드

    return Column(
      children: [
        SizedBox(
          height: 156,
          child: PageView.builder(
            controller: _controller,
            itemCount: pageCount,
            onPageChanged: (i) {
              setState(() => _page = i);
              if (i < pets.length) {
                ref.read(petProvider.notifier).selectPet(pets[i].id);
              }
            },
            itemBuilder: (_, i) {
              if (i == pets.length) return const _AddPetCard();
              return _PetCard(pet: pets[i]);
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < pageCount; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _page ? 18 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: i == _page ? AppColors.primary : AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _PetCard extends StatelessWidget {
  const _PetCard({required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      if (pet.breed != null) pet.breed!,
      if (pet.ageYears != null) '${pet.ageYears}살',
      if (pet.gender != null) pet.gender!.label,
    ].join(' · ');
    final allergy =
        pet.allergies.isEmpty ? '없음' : pet.allergies.join(', ');

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                clipBehavior: Clip.antiAlias,
                child: pet.imageUrl == null
                    ? const Icon(Icons.pets, color: AppColors.primary, size: 36)
                    : CachedNetworkImage(
                        imageUrl: pet.imageUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => const Icon(Icons.pets,
                            color: AppColors.primary, size: 36),
                      ),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                        BorderSide(color: Colors.white, width: 2)),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: const Icon(Icons.check, color: Colors.white, size: 12),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pet.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 6),
                Text('🌿 알러지: $allergy',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPetCard extends StatelessWidget {
  const _AddPetCard();

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: () => context.push(Routes.petSetup),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          gradient: AppColors.headerGradient,
          borderRadius: BorderRadius.circular(AppRadius.xxl),
        ),
        child: Row(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: Colors.white54, width: 1.5),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 36),
            ),
            const SizedBox(width: AppSpacing.lg),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('반려동물 추가',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 4),
                Text('새 펫을 등록해보세요',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(Icons.star_rounded,
                    color: AppColors.warning, size: 24),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('펫밀리 레벨',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textMuted)),
                    Text('Lv.${pet.level} ${pet.levelTitle}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${pet.levelExp}',
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 22,
                          fontWeight: FontWeight.w800),
                    ),
                    const TextSpan(
                      text: ' / 100',
                      style: TextStyle(
                          color: AppColors.textMuted, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppProgressBar(value: pet.levelProgress, height: 12),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              const AppBadge(label: '첫 진단', color: AppBadgeColor.blue),
              const SizedBox(width: AppSpacing.sm),
              AppBadge(
                  label: 'Lv.${pet.level + 1}까지 ${pet.expToNextLevel}점',
                  color: AppBadgeColor.gray),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickCheckSection extends ConsumerWidget {
  const _QuickCheckSection({this.check});
  final DailyCheck? check;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doneGroups = check?.doneGroupCount ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('오늘의 Quick Check',
                style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            Text('$doneGroups/${QuickCheckGroup.values.length} 완료',
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 13)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            for (final group in QuickCheckGroup.values) ...[
              Expanded(
                child: _QuickCheckCard(
                  group: group,
                  doneCount: check?.doneCountIn(group) ?? 0,
                  onTap: () => showQuickCheckSheet(context, ref, group),
                ),
              ),
              if (group != QuickCheckGroup.values.last)
                const SizedBox(width: AppSpacing.md),
            ],
          ],
        ),
      ],
    );
  }
}

class _QuickCheckCard extends StatelessWidget {
  const _QuickCheckCard({
    required this.group,
    required this.doneCount,
    required this.onTap,
  });

  final QuickCheckGroup group;
  final int doneCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final done = doneCount > 0;
    return ScaleTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xxl, horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: done ? AppColors.primary : AppColors.border,
            width: 1.4,
          ),
        ),
        child: Column(
          children: [
            Text(group.emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: AppSpacing.md),
            Text(group.label,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textStrong)),
            const SizedBox(height: 2),
            Text(
              done ? '$doneCount개 완료' : '탭하여 체크',
              style: TextStyle(
                fontSize: 12,
                color: done ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiCommentCard extends StatelessWidget {
  const _AiCommentCard({required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
                color: Colors.white24, shape: BoxShape.circle),
            child: const Icon(Icons.smart_toy_outlined, color: Colors.white),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI 건강 코멘트',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  '${pet.name}의 피부 상태가 걱정돼요. 오늘 피부 체크를 해보는 건 어떨까요? 🔍',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthContentSection extends ConsumerWidget {
  const _HealthContentSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contents = ref.watch(healthContentsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('건강 콘텐츠', style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            const Text('전체보기',
                style: TextStyle(color: AppColors.primary, fontSize: 13)),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          height: 208,
          child: contents.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const SizedBox.shrink(),
            data: (items) => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (_, i) => _HealthContentCard(content: items[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class _HealthContentCard extends StatelessWidget {
  const _HealthContentCard({required this.content});
  final HealthContent content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 244,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.soft,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (content.imageUrl != null)
            SizedBox(
              height: 104,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: content.imageUrl!,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) =>
                    Container(color: AppColors.background),
              ),
            ),
          // 남은 높이를 텍스트 영역이 차지하도록 해 1px 오버플로를 방지.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBadge(label: content.category, color: AppBadgeColor.blue),
                  const SizedBox(height: 6),
                  Text(content.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 3),
                  Text(content.summary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 12)),
                ],
              ),
            ),
          ),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
