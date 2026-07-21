import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

/// 상품 리뷰 1건.
@freezed
abstract class Review with _$Review {
  const factory Review({
    required String id,
    required String author,
    required double rating,
    required String text,
    required DateTime createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
