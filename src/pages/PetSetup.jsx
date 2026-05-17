import { useState } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import useAppStore from '../store/useAppStore';
import Button from '../components/Button';

const dogBreeds = [
  '말티즈',
  '푸들',
  '골든리트리버',
  '포메라니안',
  '비숑프리제',
  '시바이누',
  '웰시코기',
  '닥스훈트',
  '치와와',
  '불독',
  '보더콜리',
  '진도개',
];
const catBreeds = [
  '코리안숏헤어',
  '러시안블루',
  '페르시안',
  '스코티시폴드',
  '벵갈',
  '샴',
  '노르웨이숲',
  '메인쿤',
  '아비시니안',
  '버미즈',
];

const TOTAL_STEPS = 7;

export default function PetSetup() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const isAddMode = searchParams.get('mode') === 'add';

  const { registerPet, addPet } = useAppStore();

  const [step, setStep] = useState(0);
  const [petData, setPetData] = useState({
    name: '',
    type: '',
    breed: '',
    gender: '',
    birthYear: '',
    birthMonth: '',
    neutered: null,
    disease: '',
    allergy: '',
  });
  const [useCustomBreed, setUseCustomBreed] = useState(false);
  const [customBreed, setCustomBreed] = useState('');
  const [noDisease, setNoDisease] = useState(false);
  const [noAllergy, setNoAllergy] = useState(false);

  const update = (key, value) =>
    setPetData((prev) => ({ ...prev, [key]: value }));

  const handleBreedSelect = (val) => {
    setUseCustomBreed(false);
    update('breed', val);
  };

  const handleCustomBreedToggle = () => {
    setUseCustomBreed(true);
    update('breed', customBreed);
  };

  const handleCustomBreedChange = (val) => {
    setCustomBreed(val);
    update('breed', val);
  };

  const handleNoDiseaseToggle = () => {
    const next = !noDisease;
    setNoDisease(next);
    if (next) update('disease', '없음');
    else update('disease', '');
  };

  const handleNoAllergyToggle = () => {
    const next = !noAllergy;
    setNoAllergy(next);
    if (next) update('allergy', '없음');
    else update('allergy', '');
  };

  const goNext = () => {
    if (step < TOTAL_STEPS - 1) {
      setStep(step + 1);
    } else {
      if (isAddMode) {
        addPet(petData);
        navigate('/pet-setup/complete?mode=add');
      } else {
        registerPet(petData);
        navigate('/pet-setup/complete');
      }
    }
  };

  const goPrev = () => {
    if (step > 0) setStep(step - 1);
  };

  const breeds =
    petData.type === 'dog'
      ? dogBreeds
      : petData.type === 'cat'
      ? catBreeds
      : [];

  const steps = [
    // Step 0: Type
    <div key={0} className="flex flex-col items-center gap-4">
      <h2 className="text-xl font-bold text-gray-800 text-center mb-2">
        어떤 반려동물인가요?
      </h2>
      <div className="flex gap-4 w-full">
        {[
          { val: 'dog', emoji: '🐶', label: '강아지' },
          { val: 'cat', emoji: '🐱', label: '고양이' },
        ].map((opt) => (
          <motion.button
            key={opt.val}
            onClick={() => update('type', opt.val)}
            className={`flex-1 py-8 rounded-2xl border-2 flex flex-col items-center gap-2 transition-all
              ${
                petData.type === opt.val
                  ? 'border-primary bg-blue-50'
                  : 'border-gray-200 bg-white'
              }`}
            whileTap={{ scale: 0.96 }}
          >
            <span className="text-5xl">{opt.emoji}</span>
            <span
              className={`font-semibold text-base ${
                petData.type === opt.val ? 'text-primary' : 'text-gray-600'
              }`}
            >
              {opt.label}
            </span>
          </motion.button>
        ))}
      </div>
    </div>,

    // Step 1: Breed
    <div key={1} className="flex flex-col gap-4">
      <h2 className="text-xl font-bold text-gray-800 text-center mb-2">
        품종을 선택해주세요
      </h2>
      <div className="flex flex-wrap gap-2">
        {breeds.map((b) => (
          <motion.button
            key={b}
            onClick={() => handleBreedSelect(b)}
            whileTap={{ scale: 0.95 }}
            className={`px-4 py-2 rounded-full text-sm font-medium border-2 transition-all
              ${
                !useCustomBreed && petData.breed === b
                  ? 'border-primary bg-blue-50 text-primary'
                  : 'border-gray-200 bg-white text-gray-600'
              }`}
          >
            {b}
          </motion.button>
        ))}
        <motion.button
          onClick={handleCustomBreedToggle}
          whileTap={{ scale: 0.95 }}
          className={`px-4 py-2 rounded-full text-sm font-medium border-2 transition-all
            ${
              useCustomBreed
                ? 'border-primary bg-blue-50 text-primary'
                : 'border-gray-200 bg-white text-gray-600'
            }`}
        >
          ✏️ 직접입력
        </motion.button>
      </div>
      {useCustomBreed && (
        <motion.div
          initial={{ opacity: 0, y: -8 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-white rounded-2xl border-2 border-primary overflow-hidden"
        >
          <input
            type="text"
            value={customBreed}
            onChange={(e) => handleCustomBreedChange(e.target.value)}
            placeholder="품종을 직접 입력해주세요"
            className="w-full px-4 py-3.5 text-sm bg-transparent outline-none placeholder-gray-400"
            autoFocus
          />
        </motion.div>
      )}
      {petData.breed && (
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-blue-50 rounded-2xl p-4 flex items-center gap-3"
        >
          <span className="text-3xl">
            {petData.type === 'dog' ? '🐶' : '🐱'}
          </span>
          <div>
            <p className="font-semibold text-gray-800">{petData.breed}</p>
            <p className="text-xs text-gray-500">선택되었어요!</p>
          </div>
        </motion.div>
      )}
    </div>,

    // Step 2: Gender
    <div key={2} className="flex flex-col gap-4">
      <h2 className="text-xl font-bold text-gray-800 text-center mb-2">
        성별을 선택해주세요
      </h2>
      <div className="flex gap-4">
        {[
          { val: '수컷', emoji: '♂️' },
          { val: '암컷', emoji: '♀️' },
        ].map((opt) => (
          <motion.button
            key={opt.val}
            onClick={() => update('gender', opt.val)}
            className={`flex-1 py-8 rounded-2xl border-2 flex flex-col items-center gap-2 transition-all
              ${
                petData.gender === opt.val
                  ? 'border-primary bg-blue-50'
                  : 'border-gray-200 bg-white'
              }`}
            whileTap={{ scale: 0.96 }}
          >
            <span className="text-4xl">{opt.emoji}</span>
            <span
              className={`font-semibold ${
                petData.gender === opt.val ? 'text-primary' : 'text-gray-600'
              }`}
            >
              {opt.val}
            </span>
          </motion.button>
        ))}
      </div>
    </div>,

    // Step 3: Birthday
    <div key={3} className="flex flex-col gap-4">
      <h2 className="text-xl font-bold text-gray-800 text-center mb-2">
        생년월일을 입력해주세요
      </h2>
      <div className="flex gap-3">
        <div className="flex-1">
          <label className="text-xs text-gray-500 mb-1 block">
            태어난 연도
          </label>
          <div className="bg-white rounded-xl border-2 border-gray-200">
            <input
              type="number"
              value={petData.birthYear}
              onChange={(e) => update('birthYear', e.target.value)}
              placeholder="2021"
              min="2000"
              max="2025"
              className="w-full px-4 py-3.5 text-sm bg-transparent outline-none"
            />
          </div>
        </div>
        <div className="w-28">
          <label className="text-xs text-gray-500 mb-1 block">태어난 월</label>
          <div className="bg-white rounded-xl border-2 border-gray-200">
            <select
              value={petData.birthMonth}
              onChange={(e) => update('birthMonth', e.target.value)}
              className="w-full px-3 py-3.5 text-sm bg-transparent outline-none appearance-none"
            >
              <option value="">월</option>
              {Array.from({ length: 12 }, (_, i) => (
                <option key={i + 1} value={i + 1}>
                  {i + 1}월
                </option>
              ))}
            </select>
          </div>
        </div>
      </div>
    </div>,

    // Step 4: Neutered
    <div key={4} className="flex flex-col gap-4">
      <h2 className="text-xl font-bold text-gray-800 text-center mb-2">
        중성화 수술을 했나요?
      </h2>
      <div className="flex gap-4">
        {[
          { val: true, label: '했어요', emoji: '✅' },
          { val: false, label: '안 했어요', emoji: '❌' },
        ].map((opt) => (
          <motion.button
            key={String(opt.val)}
            onClick={() => update('neutered', opt.val)}
            className={`flex-1 py-8 rounded-2xl border-2 flex flex-col items-center gap-2 transition-all
              ${
                petData.neutered === opt.val
                  ? 'border-primary bg-blue-50'
                  : 'border-gray-200 bg-white'
              }`}
            whileTap={{ scale: 0.96 }}
          >
            <span className="text-4xl">{opt.emoji}</span>
            <span
              className={`font-semibold ${
                petData.neutered === opt.val ? 'text-primary' : 'text-gray-600'
              }`}
            >
              {opt.label}
            </span>
          </motion.button>
        ))}
      </div>
    </div>,

    // Step 5: Health info
    <div key={5} className="flex flex-col gap-4">
      <h2 className="text-xl font-bold text-gray-800 text-center mb-2">
        건강 정보를 알려주세요
      </h2>
      <div>
        <div className="flex items-center justify-between mb-1.5">
          <label className="text-sm font-medium text-gray-600">기존 질환</label>
          <motion.button
            onClick={handleNoDiseaseToggle}
            whileTap={{ scale: 0.95 }}
            className={`px-3 py-1 rounded-full text-xs font-semibold border-2 transition-all
              ${noDisease ? 'border-primary bg-blue-50 text-primary' : 'border-gray-200 bg-white text-gray-500'}`}
          >
            없음
          </motion.button>
        </div>
        <div className={`bg-white rounded-xl border-2 transition-all ${noDisease ? 'border-gray-100 bg-gray-50' : 'border-gray-200'}`}>
          <input
            type="text"
            value={noDisease ? '없음' : petData.disease}
            onChange={(e) => update('disease', e.target.value)}
            disabled={noDisease}
            placeholder="슬개골 탈구 / 아토피 / 심장병 등"
            className="w-full px-4 py-3.5 text-sm bg-transparent outline-none placeholder-gray-400 disabled:text-gray-400"
          />
        </div>
      </div>
      <div>
        <div className="flex items-center justify-between mb-1.5">
          <label className="text-sm font-medium text-gray-600">알러지</label>
          <motion.button
            onClick={handleNoAllergyToggle}
            whileTap={{ scale: 0.95 }}
            className={`px-3 py-1 rounded-full text-xs font-semibold border-2 transition-all
              ${noAllergy ? 'border-primary bg-blue-50 text-primary' : 'border-gray-200 bg-white text-gray-500'}`}
          >
            없음
          </motion.button>
        </div>
        <div className={`bg-white rounded-xl border-2 transition-all ${noAllergy ? 'border-gray-100 bg-gray-50' : 'border-gray-200'}`}>
          <input
            type="text"
            value={noAllergy ? '없음' : petData.allergy}
            onChange={(e) => update('allergy', e.target.value)}
            disabled={noAllergy}
            placeholder="닭고기 / 소고기 / 밀 등"
            className="w-full px-4 py-3.5 text-sm bg-transparent outline-none placeholder-gray-400 disabled:text-gray-400"
          />
        </div>
      </div>
      <div className="bg-blue-50 rounded-xl p-3 flex gap-2">
        <span>💡</span>
        <p className="text-xs text-blue-600 leading-relaxed">
          건강 정보는 AI 진단과 제품 추천에 활용됩니다.
        </p>
      </div>
    </div>,

    // Step 6: Name
    <div key={6} className="flex flex-col gap-4">
      <h2 className="text-xl font-bold text-gray-800 text-center mb-2">
        반려동물 이름은 뭔가요?
      </h2>
      <div className="bg-white rounded-xl border-2 border-gray-200">
        <input
          type="text"
          value={petData.name}
          onChange={(e) => update('name', e.target.value)}
          placeholder="예: 초코, 콩이, 루나..."
          className="w-full px-4 py-3.5 text-sm bg-transparent outline-none placeholder-gray-400"
        />
      </div>
      {petData.name && (
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-blue-50 rounded-2xl p-4 flex items-center gap-3"
        >
          <span className="text-4xl">
            {petData.type === 'dog' ? '🐶' : '🐱'}
          </span>
          <div>
            <p className="font-semibold text-gray-800">{petData.name}</p>
            <p className="text-sm text-gray-500">
              {petData.breed || '반려동물'} · {petData.gender || '미선택'}
            </p>
            <p className="text-xs text-gray-400">
              {petData.birthYear
                ? `${new Date().getFullYear() - parseInt(petData.birthYear)}살`
                : '나이 미입력'}{' '}
              · 중성화{' '}
              {petData.neutered === true
                ? '완료'
                : petData.neutered === false
                ? '미완료'
                : '미선택'}
            </p>
          </div>
        </motion.div>
      )}
    </div>,
  ];

  const canProceed = [
    petData.type,
    petData.breed,
    petData.gender,
    petData.birthYear && petData.birthMonth,
    petData.neutered !== null,
    true,
    petData.name.trim().length > 0,
  ][step];

  return (
    <div className="min-h-screen bg-[#F0F7FF] flex flex-col">
      {/* Header */}
      <div className="bg-white px-4 pt-12 pb-4 border-b border-gray-100">
        <div className="flex items-center gap-3 mb-4">
          {step > 0 ? (
            <motion.button
              onClick={goPrev}
              whileTap={{ scale: 0.9 }}
              className="w-9 h-9 flex items-center justify-center rounded-xl bg-gray-100"
            >
              <svg
                width="18"
                height="18"
                viewBox="0 0 24 24"
                fill="none"
                stroke="#374151"
                strokeWidth="2.5"
              >
                <path d="M15 18l-6-6 6-6" />
              </svg>
            </motion.button>
          ) : isAddMode ? (
            <motion.button
              onClick={() => navigate('/home')}
              whileTap={{ scale: 0.9 }}
              className="w-9 h-9 flex items-center justify-center rounded-xl bg-gray-100"
            >
              <svg
                width="18"
                height="18"
                viewBox="0 0 24 24"
                fill="none"
                stroke="#374151"
                strokeWidth="2.5"
              >
                <path d="M18 6L6 18M6 6l12 12" />
              </svg>
            </motion.button>
          ) : null}
          <div className="flex-1">
            <div className="flex justify-between items-center mb-1">
              <span className="text-xs text-gray-500 font-medium">
                {isAddMode ? '새 반려동물 추가' : '펫 등록'} · {step + 1} /{' '}
                {TOTAL_STEPS}
              </span>
              <span className="text-xs text-primary font-semibold">
                {Math.round(((step + 1) / TOTAL_STEPS) * 100)}%
              </span>
            </div>
            <div className="w-full bg-gray-100 rounded-full h-1.5 overflow-hidden">
              <motion.div
                className="h-full bg-primary rounded-full"
                animate={{ width: `${((step + 1) / TOTAL_STEPS) * 100}%` }}
                transition={{ duration: 0.4 }}
              />
            </div>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="flex-1 px-6 py-8">
        <AnimatePresence mode="wait">
          <motion.div
            key={step}
            initial={{ opacity: 0, x: 40 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -40 }}
            transition={{ duration: 0.25 }}
          >
            {steps[step]}
          </motion.div>
        </AnimatePresence>
      </div>

      {/* Footer button */}
      <div className="px-6 pb-10">
        <Button
          onClick={goNext}
          size="lg"
          disabled={!canProceed}
          className="w-full"
        >
          {step === TOTAL_STEPS - 1 ? '🐾 등록 완료' : '다음'}
        </Button>
      </div>
    </div>
  );
}
