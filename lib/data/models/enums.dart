/// 도메인 공용 열거형과 표시 라벨.
///
/// json_serializable은 enum을 이름(name)으로 직렬화한다.
library;

/// 반려동물 종.
enum PetSpecies {
  dog,
  cat;

  String get label => switch (this) {
        PetSpecies.dog => '강아지',
        PetSpecies.cat => '고양이',
      };
}

/// 성별.
enum PetGender {
  male,
  female;

  String get label => switch (this) {
        PetGender.male => '수컷',
        PetGender.female => '암컷',
      };
}

/// 강아지 크기 분류.
enum DogSize {
  small,
  medium,
  large;

  String get label => switch (this) {
        DogSize.small => '소형견',
        DogSize.medium => '중형견',
        DogSize.large => '대형견',
      };
}

/// 로그인 수단.
enum AuthProvider { email, kakao, google }

/// 데일리 퀵체크 항목. 완료 시 항목당 고정 경험치를 준다.
enum QuickCheckType {
  walk,
  play,
  meal,
  water,
  nutrition;

  String get label => switch (this) {
        QuickCheckType.walk => '산책',
        QuickCheckType.play => '놀이',
        QuickCheckType.meal => '식사',
        QuickCheckType.water => '급수',
        QuickCheckType.nutrition => '영양',
      };

  String get emoji => switch (this) {
        QuickCheckType.walk => '🐕',
        QuickCheckType.play => '🎾',
        QuickCheckType.meal => '🍖',
        QuickCheckType.water => '💧',
        QuickCheckType.nutrition => '💊',
      };

  /// 체크한 항목마다 +2점.
  int get exp => 2;
}

/// 오늘의 케어 그룹. 홈에서 2개 카드로 묶여 표시된다.
enum QuickCheckGroup {
  activity,
  feeding;

  String get label => switch (this) {
        QuickCheckGroup.activity => '산책/놀이',
        QuickCheckGroup.feeding => '식사/급수/영양',
      };

  String get emoji => switch (this) {
        QuickCheckGroup.activity => '🐕',
        QuickCheckGroup.feeding => '🍖',
      };

  String get question => '오늘 $label 했나요?';

  List<QuickCheckType> get items => switch (this) {
        QuickCheckGroup.activity => const [
            QuickCheckType.walk,
            QuickCheckType.play,
          ],
        QuickCheckGroup.feeding => const [
            QuickCheckType.meal,
            QuickCheckType.water,
            QuickCheckType.nutrition,
          ],
      };
}

/// 펫푸드 카테고리.
enum ProductCategory {
  food,
  supplement,
  snack;

  String get label => switch (this) {
        ProductCategory.food => '사료',
        ProductCategory.supplement => '영양제',
        ProductCategory.snack => '간식',
      };

  String get emoji => switch (this) {
        ProductCategory.food => '🥩',
        ProductCategory.supplement => '💊',
        ProductCategory.snack => '🌰',
      };
}

/// 성분 분석 분류.
enum IngredientKind {
  good,
  caution,
  functional;

  String get label => switch (this) {
        IngredientKind.good => '좋은 성분',
        IngredientKind.caution => '주의 성분',
        IngredientKind.functional => '기능성 성분',
      };
}

/// AI 진단 심각도.
enum DiagnosisSeverity {
  low,
  medium,
  high;

  String get label => switch (this) {
        DiagnosisSeverity.low => '경미',
        DiagnosisSeverity.medium => '주의',
        DiagnosisSeverity.high => '위험',
      };
}
