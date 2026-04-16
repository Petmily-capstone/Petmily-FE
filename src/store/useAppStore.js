import { create } from 'zustand';
import { mockPet, mockLevel, mockDiagnosisResult } from '../data/mockData';

const TODAY = () => new Date().toISOString().slice(0, 10);

const makeDefaultQuickCheck = () => ({
  date: TODAY(),
  groups: {
    '산책/놀이': { done: false, checkedItems: [] },
    '식사/급수/영양': { done: false, checkedItems: [] },
  },
});

const makeDefaultLevel = () => ({ ...mockLevel });

const INITIAL_PET = { ...mockPet, id: 'pet-1' };

const useAppStore = create((set, get) => ({
  // Auth
  isLoggedIn: false,
  hasCompletedOnboarding: false,
  hasRegisteredPet: false,

  // Pets (배열)
  pets: [INITIAL_PET],
  activePetId: 'pet-1',

  // 펫별 레벨 데이터
  levelData: {
    'pet-1': makeDefaultLevel(),
  },

  // 펫별 Quick Check (날짜 기반 자동 초기화)
  quickCheck: {
    'pet-1': makeDefaultQuickCheck(),
  },

  // Diagnosis
  diagnosisSymptom: '',
  diagnosisCategory: null,
  diagnosisResult: null,
  isDiagnosing: false,

  // Shop
  selectedCategory: '전체',
  wishlist: [1, 3],
  cartItems: [],

  // Premium
  isPremium: false,

  // ── Actions ──

  completeOnboarding: () => set({ hasCompletedOnboarding: true }),

  login: () => set({ isLoggedIn: true }),

  setActivePet: (petId) => set({ activePetId: petId }),

  // 최초 펫 등록 (PetSetup 초기 플로우)
  registerPet: (petData) => {
    const { pets, levelData, quickCheck } = get();
    const age = petData.birthYear
      ? new Date().getFullYear() - parseInt(petData.birthYear) + 1
      : petData.age || 1;
    const updated = { ...pets[0], ...petData, age };
    set({
      pets: [updated, ...pets.slice(1)],
      hasRegisteredPet: true,
    });
  },

  // 추가 펫 등록
  addPet: (petData) => {
    const { pets, levelData, quickCheck } = get();
    const id = `pet-${Date.now()}`;
    const age = petData.birthYear
      ? new Date().getFullYear() - parseInt(petData.birthYear) + 1
      : 1;
    const newPet = { ...petData, id, age };
    set({
      pets: [...pets, newPet],
      activePetId: id,
      levelData: { ...levelData, [id]: makeDefaultLevel() },
      quickCheck: { ...quickCheck, [id]: makeDefaultQuickCheck() },
    });
    return id;
  },

  // Quick Check 그룹 완료
  completeQuickCheckGroup: (groupName, checkedItems) => {
    const { quickCheck, activePetId, levelData } = get();
    const today = TODAY();
    const existing = quickCheck[activePetId];
    const base =
      existing && existing.date === today ? existing : makeDefaultQuickCheck();

    const newData = {
      ...base,
      date: today,
      groups: {
        ...base.groups,
        [groupName]: { done: true, checkedItems },
      },
    };

    const currentLevel = levelData[activePetId] || makeDefaultLevel();
    const newScore = Math.min(
      100,
      currentLevel.score + checkedItems.length * 2
    );

    set({
      quickCheck: { ...quickCheck, [activePetId]: newData },
      levelData: {
        ...levelData,
        [activePetId]: { ...currentLevel, score: newScore },
      },
    });
  },

  setDiagnosisCategory: (cat) => set({ diagnosisCategory: cat }),
  setDiagnosisSymptom: (text) => set({ diagnosisSymptom: text }),

  startDiagnosis: () => {
    set({ isDiagnosing: true, diagnosisResult: null });
    setTimeout(() => {
      const { pets, activePetId } = get();
      const activePet = pets.find((p) => p.id === activePetId) || pets[0];
      set({
        isDiagnosing: false,
        diagnosisResult: {
          ...mockDiagnosisResult,
          summary: `${activePet.name}의 피부 증상을 분석했어요`,
        },
      });
    }, 3000);
  },

  clearDiagnosis: () =>
    set({
      diagnosisCategory: null,
      diagnosisSymptom: '',
      diagnosisResult: null,
    }),

  subscribePremium: () => set({ isPremium: true }),

  setSelectedCategory: (cat) => set({ selectedCategory: cat }),

  toggleWishlist: (productId) => {
    const { wishlist } = get();
    set({
      wishlist: wishlist.includes(productId)
        ? wishlist.filter((id) => id !== productId)
        : [...wishlist, productId],
    });
  },

  addToCart: (product) => {
    const { cartItems } = get();
    const existing = cartItems.find((item) => item.id === product.id);
    set({
      cartItems: existing
        ? cartItems.map((item) =>
            item.id === product.id ? { ...item, qty: item.qty + 1 } : item
          )
        : [...cartItems, { ...product, qty: 1 }],
    });
  },

  updateCartQty: (productId, delta) => {
    const { cartItems } = get();
    const updated = cartItems
      .map((item) =>
        item.id === productId ? { ...item, qty: item.qty + delta } : item
      )
      .filter((item) => item.qty > 0);
    set({ cartItems: updated });
  },

  removeFromCart: (productId) => {
    const { cartItems } = get();
    set({ cartItems: cartItems.filter((item) => item.id !== productId) });
  },
}));

export default useAppStore;
