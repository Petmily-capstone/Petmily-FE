import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// 건강 콘텐츠 이미지. 원격 URL은 캐시 네트워크 이미지로, 로컬 파일 경로는
/// [Image.file]로 표시한다.
///
/// 지금은 사용자가 첨부한 사진을 로컬 경로 그대로 보관하므로 두 경우를 모두 다룬다.
/// (웹은 로컬 파일 미지원 — 백엔드 업로드 연동 시 전부 URL로 통일된다.)
class ContentImage extends StatelessWidget {
  const ContentImage({
    super.key,
    required this.source,
    this.fit = BoxFit.cover,
  });

  final String source;
  final BoxFit fit;

  bool get _isRemote =>
      source.startsWith('http://') || source.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    if (_isRemote) {
      return CachedNetworkImage(
        imageUrl: source,
        fit: fit,
        errorWidget: (_, _, _) => const _ImageFallback(),
      );
    }
    return Image.file(
      File(source),
      fit: fit,
      errorBuilder: (_, _, _) => const _ImageFallback(),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, color: AppColors.textMuted),
    );
  }
}
