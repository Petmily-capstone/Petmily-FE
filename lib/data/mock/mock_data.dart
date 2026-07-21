import '../models/models.dart';

/// 목 단계 시드 데이터.
///
/// 백엔드 연동 전까지 Mock*Repository가 참조한다. 화면은 이 값을 직접 보지 않고
/// 반드시 Repository를 경유한다.
abstract final class MockData {
  static const AppUser demoUser = AppUser(
    id: 'u1',
    email: 'demo@petmily.app',
    name: '펫밀리',
    provider: AuthProvider.email,
  );

  static List<Pet> pets() => [
        Pet(
          id: 'p1',
          name: '초코',
          species: PetSpecies.dog,
          breed: '포메라니안',
          gender: PetGender.male,
          birthDate: DateTime(2023, 4, 10),
          weightKg: 3.4,
          size: DogSize.small,
          neutered: true,
          allergies: const [],
          imageUrl:
              'https://images.unsplash.com/photo-1583512603805-3cc6b41f3edb?w=400',
          // Lv.3, 62/100 (다음 레벨까지 38점)
          exp: 262,
        ),
        Pet(
          id: 'p2',
          name: '나비',
          species: PetSpecies.cat,
          breed: '코리안숏헤어',
          gender: PetGender.female,
          birthDate: DateTime(2022, 8, 2),
          weightKg: 3.6,
          neutered: true,
          allergies: const ['닭고기'],
          imageUrl:
              'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=400',
          exp: 120,
        ),
      ];

  static List<Product> products() => [
        Product(
          id: 'f1',
          name: '로얄캐닌 미니 인도어 어덜트',
          brand: '로얄캐닌',
          price: 58000,
          species: PetSpecies.dog,
          category: ProductCategory.food,
          imageUrl:
              'https://images.unsplash.com/photo-1585846888147-3fe14c130048?w=500',
          tags: const ['소형견', '실내견'],
          rating: 3.5,
          reviewCount: 328,
          matchScore: 88,
          certified: true,
          description: '실내 소형견을 위한 체중·피모 관리 어덜트 사료.',
          ingredients: const [
            Ingredient(name: '닭고기·오리·칠면조', kind: IngredientKind.good),
            Ingredient(name: '쌀·보리', kind: IngredientKind.good),
            Ingredient(name: '동물성 부산물 포함', kind: IngredientKind.caution),
            Ingredient(name: '합성보존제 미량', kind: IngredientKind.caution),
            Ingredient(
                name: 'L-카르니틴', kind: IngredientKind.functional, note: '체중'),
            Ingredient(
                name: 'EPA·DHA', kind: IngredientKind.functional, note: '피모'),
            Ingredient(
                name: '프리바이오틱스',
                kind: IngredientKind.functional,
                note: '장'),
          ],
          suitableFor: const [
            '강아지',
            '소화기가 민감한 반려동물',
            '피부·모질 관리가 필요한 반려동물',
            '체중 관리가 필요한 반려동물',
          ],
          reviews: [
            Review(
              id: 'r1',
              author: '초코맘',
              rating: 4,
              text: '알갱이가 작아서 우리 포메가 잘 먹어요. 눈물자국도 줄었어요.',
              createdAt: DateTime(2026, 7, 10),
            ),
            Review(
              id: 'r2',
              author: '댕댕이집사',
              rating: 3,
              text: '기호성은 좋은데 가격이 조금 부담돼요.',
              createdAt: DateTime(2026, 6, 28),
            ),
          ],
        ),
        Product(
          id: 'f2',
          name: '오리젠 오리지널 독',
          brand: '오리젠',
          price: 25000,
          species: PetSpecies.dog,
          category: ProductCategory.food,
          imageUrl:
              'https://images.unsplash.com/photo-1568640347023-a616a30bc3bd?w=500',
          tags: const ['고단백', '전연령'],
          rating: 4.6,
          reviewCount: 152,
          matchScore: 82,
          description: '신선육 85% 함량의 고단백 그레인프리 사료.',
          ingredients: const [
            Ingredient(name: '신선닭·청어·칠면조 85%', kind: IngredientKind.good),
            Ingredient(name: '렌틸콩', kind: IngredientKind.good),
            Ingredient(name: '고단백(민감견 주의)', kind: IngredientKind.caution),
            Ingredient(
                name: '오메가3', kind: IngredientKind.functional, note: '피모'),
          ],
          suitableFor: const ['강아지', '활동량이 많은 반려동물'],
          reviews: [
            Review(
              id: 'r3',
              author: '봄이아빠',
              rating: 5,
              text: '급여 후 활력이 좋아졌어요. 재구매합니다.',
              createdAt: DateTime(2026, 7, 5),
            ),
          ],
        ),
        Product(
          id: 's1',
          name: '바이오펫츠 펫메가3 150ml',
          brand: '바이오펫츠',
          price: 25000,
          species: PetSpecies.dog,
          category: ProductCategory.supplement,
          imageUrl:
              'https://images.unsplash.com/photo-1607923432780-7a9c30adcb72?w=500',
          tags: const ['오메가3', '피모'],
          rating: 4.4,
          reviewCount: 89,
          matchScore: 95,
          description: '피부·모질 건강을 위한 오메가3 액상 보충제.',
          ingredients: const [
            Ingredient(name: '연어 오일', kind: IngredientKind.good),
            Ingredient(
                name: 'EPA·DHA', kind: IngredientKind.functional, note: '피모'),
          ],
          suitableFor: const ['강아지', '피부·모질 관리가 필요한 반려동물'],
        ),
        Product(
          id: 's2',
          name: '버박 뉴트리플러스겔 120g',
          brand: '버박',
          price: 29000,
          species: PetSpecies.dog,
          category: ProductCategory.supplement,
          imageUrl:
              'https://images.unsplash.com/photo-1596492784531-6e6eb5ea9993?w=500',
          tags: const ['종합영양', '기력'],
          rating: 4.7,
          reviewCount: 210,
          matchScore: 90,
          description: '식욕부진·회복기 반려동물을 위한 고열량 종합영양겔.',
          ingredients: const [
            Ingredient(name: '비타민 A·D·E', kind: IngredientKind.good),
            Ingredient(name: '고열량(비만견 주의)', kind: IngredientKind.caution),
            Ingredient(
                name: '타우린', kind: IngredientKind.functional, note: '기력'),
          ],
          suitableFor: const ['강아지', '회복기 반려동물'],
        ),
        Product(
          id: 'k1',
          name: '건강한 오리 안심 트릿',
          brand: '펫스낵',
          price: 9000,
          species: PetSpecies.dog,
          category: ProductCategory.snack,
          imageUrl:
              'https://images.unsplash.com/photo-1558929996-da64ba858215?w=500',
          tags: const ['수제간식', '훈련용'],
          rating: 4.3,
          reviewCount: 64,
          description: '첨가물 없이 건조한 오리 안심 트레이닝 간식.',
          ingredients: const [
            Ingredient(name: '오리 안심 100%', kind: IngredientKind.good),
          ],
          suitableFor: const ['강아지', '훈련 중인 반려동물'],
        ),
        Product(
          id: 'cf1',
          name: '캣 인도어 헤어볼 케어',
          brand: '지위픽',
          price: 41000,
          species: PetSpecies.cat,
          category: ProductCategory.food,
          imageUrl:
              'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=500',
          tags: const ['헤어볼', '실내묘'],
          rating: 4.7,
          reviewCount: 143,
          matchScore: 90,
          description: '실내 고양이 헤어볼 배출과 체중 관리를 돕는 사료.',
          ingredients: const [
            Ingredient(name: '닭고기', kind: IngredientKind.good),
            Ingredient(name: '식이섬유', kind: IngredientKind.good),
            Ingredient(
                name: '타우린', kind: IngredientKind.functional, note: '심장'),
          ],
          suitableFor: const ['고양이', '실내 고양이'],
          reviews: [
            Review(
              id: 'r4',
              author: '나비집사',
              rating: 5,
              text: '헤어볼 토하는 횟수가 확 줄었어요.',
              createdAt: DateTime(2026, 7, 1),
            ),
          ],
        ),
        Product(
          id: 'ck1',
          name: '참치 & 크랜베리 습식캔',
          brand: '아카나',
          price: 2800,
          species: PetSpecies.cat,
          category: ProductCategory.snack,
          imageUrl:
              'https://images.unsplash.com/photo-1573865526739-10659fec78a5?w=500',
          tags: const ['습식', '수분보충'],
          rating: 4.5,
          reviewCount: 77,
          description: '수분 보충에 좋은 습식 간식 캔.',
          ingredients: const [
            Ingredient(name: '참치', kind: IngredientKind.good),
            Ingredient(
                name: '크랜베리',
                kind: IngredientKind.functional,
                note: '요로'),
          ],
          suitableFor: const ['고양이'],
        ),
      ];

  static List<HealthContent> healthContents() => const [
        HealthContent(
          id: 'h1',
          category: '피부관리',
          title: '말티즈 여름 피부 관리법',
          summary: '피부 트러블 예방 가이드',
          imageUrl:
              'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400',
        ),
        HealthContent(
          id: 'h2',
          category: '관절건강',
          title: '소형견 관절 건강 지키기',
          summary: '일상에서 할 수 있는 관절 케어',
          imageUrl:
              'https://images.unsplash.com/photo-1552053831-71594a27632d?w=400',
        ),
        HealthContent(
          id: 'h3',
          category: '식이관리',
          title: '우리 아이 체중 관리 식단',
          summary: '비만 예방을 위한 급여 팁',
          imageUrl:
              'https://images.unsplash.com/photo-1568640347023-a616a30bc3bd?w=400',
        ),
      ];

  static List<Diagnosis> diagnoses() => [
        Diagnosis(
          id: 'd1',
          petId: 'p1',
          createdAt: DateTime(2026, 7, 18, 9, 30),
          symptomText: '어제부터 기침을 하고 밥을 잘 안 먹어요.',
          resultTitle: '경미한 호흡기 증상 의심',
          resultSummary: '가벼운 상기도 자극일 가능성이 높습니다. 하루 이틀 경과를 지켜보세요.',
          severity: DiagnosisSeverity.low,
          recommendations: [
            '실내 습도를 50~60%로 유지하세요.',
            '증상이 3일 이상 지속되면 병원 진료를 권장합니다.',
          ],
        ),
      ];
}
