import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import useAppStore from '../store/useAppStore';
import BottomNav from '../components/BottomNav';
import PageWrapper from '../components/PageWrapper';
import Badge from '../components/Badge';
import ProgressBar from '../components/ProgressBar';
import ProductCard from '../components/ProductCard';
import { mockDiagnosisHistory, mockProducts } from '../data/mockData';

const settingItems = [
  { icon: '🔔', label: '알림 설정', arrow: true },
  { icon: '🔒', label: '개인정보 관리', arrow: true },
  { icon: '💬', label: '고객 문의', arrow: true },
  { icon: '⭐', label: '앱 평가하기', arrow: true },
  { icon: '📋', label: '이용약관', arrow: true },
  { icon: '🚪', label: '로그아웃', arrow: false, danger: true },
];

export default function MyPage() {
  const navigate = useNavigate();
  const {
    pets,
    activePetId,
    levelData,
    wishlist,
    isPremium,
    subscribePremium,
  } = useAppStore();
  const activePet = pets.find((p) => p.id === activePetId) || pets[0];
  const activeLevelData = levelData[activePetId] || levelData[pets[0]?.id];
  const wishedProducts = mockProducts
    .filter((p) => wishlist.includes(p.id))
    .slice(0, 4);

  return (
    <PageWrapper>
      {/* Header */}
      <div className="bg-gradient-to-b from-primary-deep to-primary pt-12 pb-6 px-4">
        <h1 className="text-xl font-bold text-white mb-4">마이페이지</h1>

        {/* Profile */}
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex items-center gap-4"
        >
          <div className="relative">
            <div className="w-16 h-16 rounded-2xl bg-white/20 flex items-center justify-center text-3xl border-2 border-white/30">
              👤
            </div>
            <div className="absolute -bottom-1 -right-1 w-5 h-5 bg-white rounded-full border-2 border-primary flex items-center justify-center">
              <span className="text-xs">✏️</span>
            </div>
          </div>
          <div>
            <h2 className="text-white font-bold text-lg">김하나</h2>
            <p className="text-blue-200 text-sm">hana@petmily.com</p>
            <div className="flex gap-1.5 mt-1">
              <Badge
                variant="blue"
                className="bg-white/20 text-white border-0 text-xs"
              >
                Lv.{activeLevelData?.level}
              </Badge>
              <Badge
                variant="blue"
                className="bg-white/20 text-white border-0 text-xs"
              >
                {activeLevelData?.title}
              </Badge>
            </div>
          </div>
        </motion.div>
      </div>

      <div className="px-4 py-4 space-y-4">
        {/* Level card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.05 }}
          className="bg-white rounded-2xl shadow-sm p-4"
        >
          <div className="flex items-center justify-between mb-3">
            <h3 className="font-bold text-gray-800">펫밀리 레벨</h3>
            <div className="flex gap-1 flex-wrap justify-end">
              {activeLevelData?.badges.map((b) => (
                <Badge key={b} variant="blue" className="text-xs">
                  {b}
                </Badge>
              ))}
            </div>
          </div>
          <div className="flex items-center gap-3 mb-2">
            <div className="w-10 h-10 bg-blue-100 rounded-xl flex items-center justify-center text-xl">
              ⭐
            </div>
            <div className="flex-1">
              <div className="flex justify-between text-sm mb-1">
                <span className="font-semibold text-gray-700">
                  Lv.{activeLevelData?.level} → Lv.
                  {(activeLevelData?.level || 0) + 1}
                </span>
                <span className="font-bold text-primary">
                  {activeLevelData?.score} / {activeLevelData?.maxScore}
                </span>
              </div>
              <ProgressBar
                value={activeLevelData?.score || 0}
                max={activeLevelData?.maxScore || 100}
              />
            </div>
          </div>
          <p className="text-xs text-gray-500 text-center">
            다음 레벨까지{' '}
            {(activeLevelData?.maxScore || 100) - (activeLevelData?.score || 0)}
            점 남았어요!
          </p>
        </motion.div>

        {/* Pet info cards */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="bg-white rounded-2xl shadow-sm p-4"
        >
          <div className="flex items-center justify-between mb-3">
            <h3 className="font-bold text-gray-800">
              내 반려동물 ({pets.length}마리)
            </h3>
            <motion.button
              onClick={() => navigate('/pet-setup?mode=add')}
              whileTap={{ scale: 0.9 }}
              className="text-xs text-primary font-medium bg-blue-50 px-3 py-1.5 rounded-full"
            >
              + 추가
            </motion.button>
          </div>
          <div className="space-y-3">
            {pets.map((pet) => (
              <div key={pet.id} className="flex items-center gap-3">
                <img
                  src={
                    pet.photo ||
                    (pet.type === 'cat'
                      ? `https://loremflickr.com/60/60/cat,kitten?lock=${pet.id.slice(-3)}`
                      : `https://loremflickr.com/60/60/dog,puppy?lock=${pet.id.slice(-3)}`)
                  }
                  alt={pet.name}
                  className="w-12 h-12 rounded-xl object-cover"
                />
                <div className="flex-1">
                  <p className="font-bold text-gray-800 text-sm">{pet.name}</p>
                  <p className="text-xs text-gray-500">
                    {pet.breed || '믹스'} · {pet.age || '?'}살 ·{' '}
                    {pet.gender || '미선택'}
                  </p>
                  <div className="flex gap-1.5 mt-1 flex-wrap">
                    {pet.neutered && (
                      <Badge variant="blue" className="text-xs">
                        중성화 완료
                      </Badge>
                    )}
                    {pet.allergy && (
                      <Badge variant="orange" className="text-xs">
                        알러지: {pet.allergy}
                      </Badge>
                    )}
                  </div>
                </div>
                {pet.id === activePetId && (
                  <Badge variant="blue" className="text-xs flex-shrink-0">
                    선택중
                  </Badge>
                )}
              </div>
            ))}
          </div>
        </motion.div>

        {/* Diagnosis history */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.15 }}
          className="bg-white rounded-2xl shadow-sm p-4 relative overflow-hidden"
        >
          <div className="flex items-center justify-between mb-3">
            <h3 className="font-bold text-gray-800">진단 히스토리</h3>
            <Badge variant={isPremium ? 'green' : 'purple'}>
              {isPremium ? '프리미엄 ✓' : '프리미엄'}
            </Badge>
          </div>

          {mockDiagnosisHistory.map((item) => (
            <div
              key={item.id}
              className={`flex items-center gap-3 p-3 bg-gray-50 rounded-xl mb-2 ${
                !isPremium && item.premium ? 'opacity-40' : ''
              }`}
            >
              <div className="w-9 h-9 bg-blue-100 rounded-xl flex items-center justify-center">
                <span className="text-lg">🔬</span>
              </div>
              <div className="flex-1">
                <p className="text-sm font-semibold text-gray-800">
                  {item.symptom}
                </p>
                <p className="text-xs text-gray-400">{item.date}</p>
              </div>
              {(!item.premium || isPremium) && (
                <Badge variant="red" className="text-xs">
                  결과보기
                </Badge>
              )}
            </div>
          ))}

          {!isPremium && (
            <div className="relative mt-2">
              <div className="bg-white/80 backdrop-blur-[1px] rounded-xl flex flex-col items-center justify-center gap-2 py-4">
                <span className="text-2xl">🔒</span>
                <p className="text-sm font-bold text-gray-700">프리미엄 전용</p>
                <p className="text-xs text-gray-500">
                  전체 진단 기록을 확인하세요
                </p>
                <motion.button
                  onClick={subscribePremium}
                  whileTap={{ scale: 0.96 }}
                  className="mt-1 bg-primary text-white px-4 py-2 rounded-full text-xs font-bold"
                >
                  프리미엄 시작하기
                </motion.button>
              </div>
            </div>
          )}
        </motion.div>

        {/* Wishlist */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <div className="flex items-center justify-between mb-3">
            <h3 className="font-bold text-gray-800">찜한 상품</h3>
            <button
              onClick={() => navigate('/shop')}
              className="text-xs text-primary font-medium"
            >
              전체보기
            </button>
          </div>
          {wishedProducts.length > 0 ? (
            <div className="flex gap-3 overflow-x-auto scrollbar-hide -mx-4 px-4">
              {wishedProducts.map((p) => (
                <ProductCard key={p.id} product={p} size="small" />
              ))}
            </div>
          ) : (
            <div className="bg-white rounded-2xl shadow-sm p-6 text-center">
              <p className="text-gray-400 text-sm">찜한 상품이 없어요</p>
              <button
                onClick={() => navigate('/shop')}
                className="mt-2 text-primary text-xs font-medium"
              >
                쇼핑하러 가기 →
              </button>
            </div>
          )}
        </motion.div>

        {/* Premium banner */}
        {isPremium ? (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.25 }}
            className="bg-gradient-to-r from-yellow-400 to-orange-400 rounded-2xl p-5 relative overflow-hidden"
          >
            <div className="absolute -right-4 -top-4 w-24 h-24 bg-white/10 rounded-full" />
            <div className="absolute -right-2 bottom-2 w-16 h-16 bg-white/10 rounded-full" />
            <div className="relative flex items-center gap-3">
              <span className="text-4xl">👑</span>
              <div>
                <Badge
                  variant="yellow"
                  className="mb-1 text-xs bg-white/30 border-0 text-white"
                >
                  PREMIUM 이용중
                </Badge>
                <h3 className="text-white font-bold text-base mb-0.5">
                  프리미엄 구독중이에요!
                </h3>
                <p className="text-yellow-100 text-xs">
                  무제한 AI 진단 · 전체 히스토리 · 전문가 상담
                </p>
              </div>
            </div>
          </motion.div>
        ) : (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.25 }}
            className="bg-gradient-to-r from-primary-deep to-primary rounded-2xl p-5 relative overflow-hidden"
          >
            <div className="absolute -right-4 -top-4 w-24 h-24 bg-white/10 rounded-full" />
            <div className="absolute -right-2 bottom-2 w-16 h-16 bg-white/10 rounded-full" />
            <div className="relative">
              <Badge variant="yellow" className="mb-2 text-xs">
                PREMIUM
              </Badge>
              <h3 className="text-white font-bold text-base mb-1">
                프리미엄으로 업그레이드
              </h3>
              <p className="text-blue-100 text-xs mb-3">
                무제한 AI 진단 · 전체 히스토리 · 전문가 상담
              </p>
              <motion.button
                onClick={subscribePremium}
                whileTap={{ scale: 0.96 }}
                className="bg-white text-primary text-sm font-bold px-4 py-2 rounded-full"
              >
                월 2,900원으로 시작 →
              </motion.button>
            </div>
          </motion.div>
        )}

        {/* Settings */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="bg-white rounded-2xl shadow-sm overflow-hidden"
        >
          {settingItems.map((item, i) => (
            <motion.button
              key={item.label}
              whileTap={{ backgroundColor: '#F3F4F6' }}
              className={`w-full flex items-center gap-3 px-4 py-4 ${
                i < settingItems.length - 1 ? 'border-b border-gray-50' : ''
              }`}
            >
              <span className="text-xl w-8">{item.icon}</span>
              <span
                className={`flex-1 text-left text-sm font-medium ${
                  item.danger ? 'text-red-500' : 'text-gray-700'
                }`}
              >
                {item.label}
              </span>
              {item.arrow && (
                <svg
                  width="16"
                  height="16"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#94A3B8"
                  strokeWidth="2"
                >
                  <path d="M9 18l6-6-6-6" />
                </svg>
              )}
            </motion.button>
          ))}
        </motion.div>

        <p className="text-center text-xs text-gray-400 pb-2">
          펫밀리 v1.0.0 · 2025 Petmily Inc.
        </p>
      </div>

      <BottomNav />
    </PageWrapper>
  );
}
