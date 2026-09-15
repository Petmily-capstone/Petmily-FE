import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/content_provider.dart';

/// 건강 콘텐츠 작성 화면. 태그 선택 · 제목 · 본문 · 사진(최대 5장).
class ContentComposePage extends ConsumerStatefulWidget {
  const ContentComposePage({super.key});

  @override
  ConsumerState<ContentComposePage> createState() => _ContentComposePageState();
}

class _ContentComposePageState extends ConsumerState<ContentComposePage> {
  final _picker = ImagePicker();

  ContentCategory? _category;
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _images = <XFile>[];
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _category != null &&
      _title.text.trim().isNotEmpty &&
      _body.text.trim().isNotEmpty;

  Future<void> _pickImages() async {
    final remaining = HealthContent.maxImages - _images.length;
    if (remaining <= 0) return;
    try {
      final picked = await _picker.pickMultiImage();
      if (picked.isEmpty) return;
      setState(() => _images.addAll(picked.take(remaining)));
      if (picked.length > remaining && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('사진은 최대 ${HealthContent.maxImages}장까지 넣을 수 있어요.'),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('사진을 불러오지 못했어요.')));
      }
    }
  }

  Future<void> _submit() async {
    if (!_canSubmit || _saving) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(contentProvider.notifier)
          .create(
            category: _category!,
            title: _title.text.trim(),
            body: _body.text.trim(),
            imagePaths: _images.map((x) => x.path).toList(),
          );
      if (!mounted) return;
      context.pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('게시글을 등록했어요.')));
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('등록에 실패했어요. 다시 시도해 주세요.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.textStrong,
        backgroundColor: AppColors.background,
        title: const Text('글 작성'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                const _Label('태그'),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final c in ContentCategory.values)
                      _TagChip(
                        label: c.label,
                        selected: _category == c,
                        onTap: () => setState(() => _category = c),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                const _Label('제목'),
                const SizedBox(height: AppSpacing.sm),
                _ComposeField(
                  controller: _title,
                  hint: '제목을 입력하세요',
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.xl),
                const _Label('내용'),
                const SizedBox(height: AppSpacing.sm),
                _ComposeField(
                  controller: _body,
                  hint: '내용을 입력하세요',
                  minLines: 5,
                  maxLines: 10,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.xl),
                _Label('사진 (${_images.length}/${HealthContent.maxImages})'),
                const SizedBox(height: AppSpacing.sm),
                _ImagePickerGrid(
                  images: _images,
                  onAdd: _pickImages,
                  onRemove: (i) => setState(() => _images.removeAt(i)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: PrimaryButton(
              label: '등록',
              loading: _saving,
              onPressed: _canSubmit && !_saving ? _submit : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textStrong,
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
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
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEFF6FF) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.6 : 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.primary : AppColors.textStrong,
          ),
        ),
      ),
    );
  }
}

class _ComposeField extends StatelessWidget {
  const _ComposeField({
    required this.controller,
    required this.hint,
    this.minLines,
    this.maxLines = 1,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final int? minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.top,
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

/// 사진 썸네일 그리드 + 추가 타일.
class _ImagePickerGrid extends StatelessWidget {
  const _ImagePickerGrid({
    required this.images,
    required this.onAdd,
    required this.onRemove,
  });

  final List<XFile> images;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final canAdd = images.length < HealthContent.maxImages;
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (var i = 0; i < images.length; i++)
          _Thumbnail(file: images[i], onRemove: () => onRemove(i)),
        if (canAdd)
          ScaleTap(
            onTap: onAdd,
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border, width: 1.2),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: AppColors.textMuted,
                    size: 24,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '추가',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.file, required this.onRemove});

  final XFile file;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Image.file(
            File(file.path),
            width: 84,
            height: 84,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              width: 84,
              height: 84,
              color: AppColors.background,
              child: const Icon(
                Icons.image_outlined,
                color: AppColors.textMuted,
              ),
            ),
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: ScaleTap(
            onTap: onRemove,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.textStrong,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(2),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}
