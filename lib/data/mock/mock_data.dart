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
          breed: '푸들',
          gender: PetGender.male,
          birthDate: DateTime(2021, 3, 14),
          weightKg: 4.2,
          imageUrl:
              'https://images.unsplash.com/photo-1583512603805-3cc6b41f3edb?w=400',
          exp: 340,
        ),
        Pet(
          id: 'p2',
          name: '나비',
          species: PetSpecies.cat,
          breed: '코리안숏헤어',
          gender: PetGender.female,
          birthDate: DateTime(2022, 8, 2),
          weightKg: 3.6,
          imageUrl:
              'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=400',
          exp: 120,
        ),
      ];

  static List<Product> products() => const [
        Product(
          id: 'f1',
          name: '연어 & 고구마 그레인프리 사료',
          brand: '내추럴코어',
          price: 38000,
          species: PetSpecies.dog,
          imageUrl:
              'https://images.unsplash.com/photo-1585846888147-3fe14c130048?w=400',
          tags: ['그레인프리', '피부/모질'],
          rating: 4.8,
          matchScore: 95,
          description: '알레르기 유발이 적은 연어 단백질 기반 전연령 사료.',
          ingredients: [
            Ingredient(name: '연어', isGood: true, note: '오메가3 풍부'),
            Ingredient(name: '고구마', isGood: true),
            Ingredient(name: '완두콩', isGood: true),
            Ingredient(name: '합성보존료', isGood: false, note: '무첨가'),
          ],
        ),
        Product(
          id: 'f2',
          name: '닭고기 & 현미 어덜트 사료',
          brand: '오리젠',
          price: 52000,
          species: PetSpecies.dog,
          imageUrl:
              'https://images.unsplash.com/photo-1568640347023-a616a30bc3bd?w=400',
          tags: ['고단백', '체중관리'],
          rating: 4.6,
          matchScore: 82,
          description: '활동량 많은 성견을 위한 고단백 레시피.',
          ingredients: [
            Ingredient(name: '닭고기', isGood: true),
            Ingredient(name: '현미', isGood: true),
            Ingredient(name: '옥수수', isGood: false, note: '소화 부담 가능'),
          ],
        ),
        Product(
          id: 'f3',
          name: '캣 인도어 헤어볼 케어',
          brand: '지위픽',
          price: 41000,
          species: PetSpecies.cat,
          imageUrl:
              'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400',
          tags: ['헤어볼', '실내묘'],
          rating: 4.7,
          matchScore: 90,
          description: '실내 고양이 헤어볼 배출과 체중 관리를 돕는 사료.',
          ingredients: [
            Ingredient(name: '닭고기', isGood: true),
            Ingredient(name: '식이섬유', isGood: true),
            Ingredient(name: '타우린', isGood: true, note: '심장/눈 건강'),
          ],
        ),
        Product(
          id: 'f4',
          name: '참치 & 크랜베리 습식캔',
          brand: '아카나',
          price: 2800,
          species: PetSpecies.cat,
          imageUrl:
              'https://images.unsplash.com/photo-1573865526739-10659fec78a5?w=400',
          tags: ['습식', '수분보충'],
          rating: 4.5,
          description: '수분 보충에 좋은 습식 간식 캔.',
          ingredients: [
            Ingredient(name: '참치', isGood: true),
            Ingredient(name: '크랜베리', isGood: true, note: '요로 건강'),
          ],
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
