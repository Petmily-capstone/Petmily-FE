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

/// 데일리 퀵체크 항목. 완료 시 [exp]만큼 경험치를 준다.
enum QuickCheckType {
  walk,
  meal,
  water,
  potty,
  play,
  grooming;

  String get label => switch (this) {
        QuickCheckType.walk => '산책',
        QuickCheckType.meal => '식사',
        QuickCheckType.water => '급수',
        QuickCheckType.potty => '배변',
        QuickCheckType.play => '놀이',
        QuickCheckType.grooming => '그루밍',
      };

  /// 완료 시 획득 경험치.
  int get exp => switch (this) {
        QuickCheckType.walk => 20,
        QuickCheckType.meal => 15,
        QuickCheckType.water => 10,
        QuickCheckType.potty => 10,
        QuickCheckType.play => 15,
        QuickCheckType.grooming => 10,
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
