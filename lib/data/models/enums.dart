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

/// 대중적인 강아지 품종 카탈로그.
///
/// 선택지는 고정이지만, 목록에 없는 품종은 UI의 '직접 입력'으로 자유 문자열을
/// 받는다. 그래서 [Pet.breed]는 enum이 아니라 라벨 문자열로 저장한다.
enum DogBreed {
  maltese,
  poodle,
  pomeranian,
  shihTzu,
  chihuahua,
  welshCorgi,
  goldenRetriever,
  jindo,
  bichonFrise,
  yorkshireTerrier,
  dachshund,
  shibaInu,
  borderCollie,
  labradorRetriever,
  frenchBulldog;

  String get label => switch (this) {
        DogBreed.maltese => '말티즈',
        DogBreed.poodle => '푸들',
        DogBreed.pomeranian => '포메라니안',
        DogBreed.shihTzu => '시츄',
        DogBreed.chihuahua => '치와와',
        DogBreed.welshCorgi => '웰시코기',
        DogBreed.goldenRetriever => '골든리트리버',
        DogBreed.jindo => '진돗개',
        DogBreed.bichonFrise => '비숑프리제',
        DogBreed.yorkshireTerrier => '요크셔테리어',
        DogBreed.dachshund => '닥스훈트',
        DogBreed.shibaInu => '시바견',
        DogBreed.borderCollie => '보더콜리',
        DogBreed.labradorRetriever => '래브라도리트리버',
        DogBreed.frenchBulldog => '프렌치불독',
      };
}

/// 대중적인 고양이 품종 카탈로그. [DogBreed]와 동일한 정책.
enum CatBreed {
  koreanShorthair,
  persian,
  russianBlue,
  scottishFold,
  britishShorthair,
  munchkin,
  ragdoll,
  americanShorthair,
  bengal,
  siamese,
  norwegianForest,
  maineCoon,
  abyssinian,
  turkishAngora,
  sphynx;

  String get label => switch (this) {
        CatBreed.koreanShorthair => '코리안숏헤어',
        CatBreed.persian => '페르시안',
        CatBreed.russianBlue => '러시안블루',
        CatBreed.scottishFold => '스코티시폴드',
        CatBreed.britishShorthair => '브리티시숏헤어',
        CatBreed.munchkin => '먼치킨',
        CatBreed.ragdoll => '랙돌',
        CatBreed.americanShorthair => '아메리칸숏헤어',
        CatBreed.bengal => '뱅갈',
        CatBreed.siamese => '샴',
        CatBreed.norwegianForest => '노르웨이숲',
        CatBreed.maineCoon => '메인쿤',
        CatBreed.abyssinian => '아비시니안',
        CatBreed.turkishAngora => '터키시앙고라',
        CatBreed.sphynx => '스핑크스',
      };
}

/// 종에 맞는 품종 라벨 목록. 목록에 없으면 '직접 입력'으로 자유 입력한다.
extension PetSpeciesBreeds on PetSpecies {
  List<String> get breedLabels => switch (this) {
        PetSpecies.dog => [for (final b in DogBreed.values) b.label],
        PetSpecies.cat => [for (final b in CatBreed.values) b.label],
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

/// 건강 콘텐츠(게시글) 태그.
enum ContentCategory {
  skin,
  joint,
  diet,
  etc;

  String get label => switch (this) {
        ContentCategory.skin => '피부관리',
        ContentCategory.joint => '관절건강',
        ContentCategory.diet => '식이관리',
        ContentCategory.etc => '기타',
      };

  /// 라벨로 역매핑(없으면 [ContentCategory.etc]). 서버/목 문자열 매핑용.
  static ContentCategory fromLabel(String label) => values.firstWhere(
        (c) => c.label == label,
        orElse: () => ContentCategory.etc,
      );
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
