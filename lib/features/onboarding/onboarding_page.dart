import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';

/// 온보딩 소개 슬라이드.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  static const _slides = [
    _Slide(
      icon: Icons.favorite_rounded,
      title: '매일 케어로 레벨업',
      description: '산책·식사·급수를 체크하며\n펫밀리 레벨을 함께 올려요.',
    ),
    _Slide(
      icon: Icons.medical_services_rounded,
      title: 'AI 증상 진단',
      description: '증상을 입력하면 AI가\n빠르게 상태를 살펴봐요.',
    ),
    _Slide(
      icon: Icons.shopping_bag_rounded,
      title: '맞춤 펫푸드',
      description: '성분 분석으로 우리 아이에게\n꼭 맞는 사료를 추천해요.',
    ),
  ];

  bool get _isLast => _index == _slides.length - 1;

  void _next() {
    if (_isLast) {
      context.go(Routes.login);
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go(Routes.login),
                child: const Text('건너뛰기'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => _slides[i],
              ),
            ),
            _Dots(count: _slides.length, index: _index),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: PrimaryButton(
                label: _isLast ? '시작하기' : '다음',
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 68, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == index ? 22 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == index ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
      ],
    );
  }
}
