import '../../../core/widgets/widgets.dart';
import '../../../data/models/models.dart';

/// 콘텐츠 카테고리 → 배지 색상 매핑(표현 계층 전용).
extension ContentCategoryBadge on ContentCategory {
  AppBadgeColor get badgeColor => switch (this) {
    ContentCategory.skin => AppBadgeColor.orange,
    ContentCategory.joint => AppBadgeColor.purple,
    ContentCategory.diet => AppBadgeColor.green,
    ContentCategory.etc => AppBadgeColor.gray,
  };
}
