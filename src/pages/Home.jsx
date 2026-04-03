import { useState, useRef, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence, useMotionValue, useTransform } from 'framer-motion'
import useAppStore from '../store/useAppStore'
import BottomNav from '../components/BottomNav'
import PageWrapper from '../components/PageWrapper'
import ProgressBar from '../components/ProgressBar'
import Badge from '../components/Badge'
import { mockHealthContents } from '../data/mockData'

// ── Quick Check 그룹 정의 ──
const CHECK_GROUPS = [
  {
    key: '산책/놀이',
    emoji: '🦮',
    items: [
      { key: 'walk', label: '산책', emoji: '🦮' },
      { key: 'play', label: '놀이', emoji: '🎾' },
    ],
  },
  {
    key: '식사/급수/영양',
    emoji: '🍖',
    items: [
      { key: 'meal', label: '식사', emoji: '🍖' },
      { key: 'water', label: '급수', emoji: '💧' },
      { key: 'nutrition', label: '영양', emoji: '💊' },
    ],
  },
]

// ── Quick Check 모달 (드래그로 높이 조절 가능한 바텀시트) ──
function QuickCheckModal({ group, onConfirm, onCancel }) {
  const [checked, setChecked] = useState([])

  // 드래그 Y 값: 위로 드래그 = 음수, 아래로 드래그 = 양수
  const dragY = useMotionValue(0)
  // dragY를 시트 높이(vh)로 변환: y=0 → 60vh, y=-200 → 88vh
  const sheetHeight = useTransform(dragY, [-220, 0], ['92vh', '60vh'])

  const toggle = (key) => {
    setChecked(prev =>
      prev.includes(key) ? prev.filter(k => k !== key) : [...prev, key]
    )
  }

  const handleDragEnd = (_, info) => {
    // 아래로 120px 이상 드래그 시 닫기
    if (info.offset.y > 120) onCancel()
    // 위로 당겼다 놓으면 dragY는 자동으로 constraint 내 위치 유지
  }

  return (
    <motion.div
      className="fixed z-50 flex items-end justify-center"
      style={{
        top: 0, bottom: 0,
        width: '390px', left: '50%', transform: 'translateX(-50%)',
      }}
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
    >
      {/* Backdrop */}
      <motion.div
        className="absolute inset-0 bg-black/40"
        onClick={onCancel}
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
      />

      {/* 드래그 가능한 시트 */}
      <motion.div
        drag="y"
        dragConstraints={{ top: -220, bottom: 0 }}
        dragElastic={{ top: 0.15, bottom: 0.4 }}
        onDragEnd={handleDragEnd}
        style={{ y: dragY, height: sheetHeight }}
        className="relative w-full bg-white rounded-t-3xl flex flex-col overflow-hidden"
        initial={{ y: '100%' }}
        animate={{ y: 0 }}
        exit={{ y: '100%' }}
        transition={{ type: 'spring', damping: 30, stiffness: 300 }}
      >
        {/* 드래그 핸들 + 헤더 (고정) */}
        <div className="px-6 pt-4 pb-3 shrink-0 cursor-grab active:cursor-grabbing">
          <div className="w-10 h-1.5 bg-gray-300 rounded-full mx-auto mb-4" />
          <h3 className="text-lg font-bold text-gray-800 mb-0.5">
            오늘 {group.key} 했나요?
          </h3>
          <p className="text-sm text-gray-400">위로 드래그하면 크게 볼 수 있어요 (+2점/개)</p>
        </div>

        {/* 체크리스트 (스크롤) */}
        <div className="flex-1 overflow-y-auto px-6 py-2 space-y-3">
          {group.items.map(item => {
            const isChecked = checked.includes(item.key)
            return (
              <motion.button
                key={item.key}
                onClick={() => toggle(item.key)}
                className={`w-full flex items-center gap-4 p-4 rounded-2xl border-2 transition-all
                  ${isChecked ? 'border-primary bg-blue-50' : 'border-gray-200 bg-gray-50'}`}
                whileTap={{ scale: 0.98 }}
              >
                <span className="text-2xl">{item.emoji}</span>
                <span className={`flex-1 text-left font-semibold ${isChecked ? 'text-primary' : 'text-gray-700'}`}>
                  {item.label}
                </span>
                <motion.div
                  className={`w-6 h-6 rounded-full border-2 flex items-center justify-center
                    ${isChecked ? 'bg-primary border-primary' : 'border-gray-300'}`}
                  animate={isChecked ? { scale: [1, 1.2, 1] } : {}}
                >
                  {isChecked && <span className="text-white text-xs font-bold">✓</span>}
                </motion.div>
              </motion.button>
            )
          })}
        </div>

        {/* 버튼 영역 (항상 하단 고정) */}
        <div className="px-6 pt-3 pb-8 shrink-0 border-t border-gray-100 flex gap-3 bg-white">
          <button
            onClick={onCancel}
            className="flex-1 py-3.5 rounded-2xl border-2 border-gray-200 text-gray-500 font-semibold"
          >
            취소
          </button>
          <motion.button
            onClick={() => onConfirm(checked)}
            className="flex-1 py-3.5 rounded-2xl bg-primary text-white font-semibold shadow-lg shadow-blue-200"
            whileTap={{ scale: 0.97 }}
          >
            완료 ({checked.length > 0 ? `+${checked.length * 2}점` : '0점'})
          </motion.button>
        </div>
      </motion.div>
    </motion.div>
  )
}

// ── 펫 프로필 카드 ──
function PetCard({ pet, levelData, isActive, onClick }) {
  return (
    <motion.div
      onClick={onClick}
      className={`w-full rounded-2xl p-4 flex items-center gap-3 cursor-pointer transition-all
        ${isActive ? 'bg-white/25 border-2 border-white/50' : 'bg-white/10 border-2 border-white/20'}`}
      whileTap={{ scale: 0.97 }}
    >
      <div className="relative">
        <img
          src={pet.type === 'cat' ? 'https://placekitten.com/60/60' : 'https://placedog.net/60/60'}
          alt={pet.name}
          className="w-14 h-14 rounded-xl object-cover border-2 border-white/50"
        />
        {isActive && (
          <div className="absolute -bottom-1 -right-1 w-5 h-5 bg-green-400 rounded-full border-2 border-white flex items-center justify-center">
            <span className="text-[10px] text-white font-bold">✓</span>
          </div>
        )}
      </div>
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-1.5 mb-0.5">
          <h2 className="text-white font-bold text-base truncate">{pet.name}</h2>
          {levelData && (
            <span className="text-[10px] bg-white/20 text-white px-1.5 py-0.5 rounded-full font-medium flex-shrink-0">
              Lv.{levelData.level}
            </span>
          )}
        </div>
        <p className="text-blue-100 text-xs">{pet.breed || '믹스'} · {pet.age || '?'}살 · {pet.gender || '미선택'}</p>
        {pet.allergy && (
          <p className="text-blue-200 text-[10px] mt-0.5 truncate">알러지: {pet.allergy}</p>
        )}
      </div>
    </motion.div>
  )
}

// ── Add Pet 카드 ──
function AddPetCard({ onClick }) {
  return (
    <motion.div
      onClick={onClick}
      className="w-full rounded-2xl border-2 border-dashed border-white/40 flex items-center justify-center gap-4 py-5 px-5 cursor-pointer bg-white/5"
      whileTap={{ scale: 0.97 }}
    >
      <div className="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center flex-shrink-0">
        <span className="text-white text-3xl font-light leading-none">+</span>
      </div>
      <div>
        <p className="text-white font-semibold text-sm">반려동물 추가</p>
        <p className="text-white/60 text-xs mt-0.5">새 펫을 등록해보세요</p>
      </div>
    </motion.div>
  )
}

// ── 메인 컴포넌트 ──
export default function Home() {
  const navigate = useNavigate()
  const {
    pets, activePetId, setActivePet,
    levelData, quickCheck,
    completeQuickCheckGroup,
  } = useAppStore()

  const activePet = pets.find(p => p.id === activePetId) || pets[0]
  const activeLevelData = levelData[activePetId] || levelData[pets[0]?.id]

  // 오늘 날짜와 다르면 초기화된 것으로 처리
  const today = new Date().toISOString().slice(0, 10)
  const rawQC = quickCheck[activePetId]
  const activeQC = rawQC && rawQC.date === today
    ? rawQC
    : { date: today, groups: { '산책/놀이': { done: false, checkedItems: [] }, '식사/급수/영양': { done: false, checkedItems: [] } } }

  const [activeModal, setActiveModal] = useState(null) // group key or null
  const [carouselIndex, setCarouselIndex] = useState(0)
  const carouselRef = useRef(null)

  // 각 슬라이드가 clientWidth와 동일하므로 scrollLeft / clientWidth 로 인덱스 계산
  const totalSlides = pets.length + 1
  const handleCarouselScroll = useCallback(() => {
    if (!carouselRef.current) return
    const el = carouselRef.current
    const idx = Math.round(el.scrollLeft / el.clientWidth)
    setCarouselIndex(Math.min(idx, totalSlides - 1))
  }, [totalSlides])

  const doneCount = Object.values(activeQC.groups).filter(g => g.done).length
  const totalGroups = CHECK_GROUPS.length

  const walkDone = activeQC.groups['산책/놀이']?.done
  const mealDone = activeQC.groups['식사/급수/영양']?.done
  const aiComment = walkDone && mealDone
    ? `${activePet.name}아, 오늘도 산책하고 밥 잘 먹었구나! 정말 건강한 하루야 🌟`
    : walkDone
    ? `${activePet.name}이 오늘 산책했네요! 식사 체크도 해볼까요? 🍖`
    : `${activePet.name}의 피부 상태가 걱정돼요. 오늘 피부 체크를 해보는 건 어떨까요? 🔍`

  const handleConfirm = (groupKey, checkedItems) => {
    completeQuickCheckGroup(groupKey, checkedItems)
    setActiveModal(null)
  }

  const openGroup = CHECK_GROUPS.find(g => g.key === activeModal)

  return (
    <>
      {/* Quick Check Modal - PageWrapper 바깥에 렌더링 (transform 컨텍스트 회피) */}
      <AnimatePresence>
        {openGroup && (
          <QuickCheckModal
            group={openGroup}
            onConfirm={(items) => handleConfirm(openGroup.key, items)}
            onCancel={() => setActiveModal(null)}
          />
        )}
      </AnimatePresence>

      <PageWrapper>
      {/* Header */}
      <div className="bg-gradient-to-b from-primary-deep to-primary pt-12 pb-5 px-4">
        <div className="flex items-center justify-between mb-4">
          <div>
            <p className="text-blue-200 text-sm">안녕하세요 👋</p>
            <h1 className="text-xl font-bold text-white">펫밀리</h1>
          </div>
          <motion.button whileTap={{ scale: 0.9 }} className="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2">
              <path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9M13.73 21a2 2 0 01-3.46 0"/>
            </svg>
          </motion.button>
        </div>

        {/* 펫 프로필 캐러셀 - overflow-hidden으로 다음 슬라이드 완전히 숨김 */}
        <div className="overflow-hidden -mx-4">
          <div
            ref={carouselRef}
            onScroll={handleCarouselScroll}
            className="flex overflow-x-auto scrollbar-hide pb-2"
            style={{ scrollSnapType: 'x mandatory', scrollBehavior: 'smooth' }}
          >
            {pets.map(pet => (
              <div
                key={pet.id}
                className="flex-shrink-0 w-full px-4"
                style={{ scrollSnapAlign: 'start' }}
              >
                <PetCard
                  pet={pet}
                  levelData={levelData[pet.id]}
                  isActive={pet.id === activePetId}
                  onClick={() => setActivePet(pet.id)}
                />
              </div>
            ))}
            {/* "+" 카드: 스크롤해야만 등장 */}
            <div
              className="flex-shrink-0 w-full px-4"
              style={{ scrollSnapAlign: 'start' }}
            >
              <AddPetCard onClick={() => navigate('/pet-setup?mode=add')} />
            </div>
          </div>
        </div>

        {/* 슬라이드 인디케이터 */}
        <div className="flex justify-center gap-1.5 mt-2.5 pb-1">
          {Array.from({ length: totalSlides }).map((_, i) => (
            <motion.div
              key={i}
              className="rounded-full bg-white"
              animate={{
                width: i === carouselIndex ? 16 : 6,
                height: 6,
                opacity: i === carouselIndex ? 1 : 0.35,
              }}
              transition={{ duration: 0.25 }}
            />
          ))}
        </div>
      </div>

      {/* Main content */}
      <AnimatePresence mode="wait">
        <motion.div
          key={activePetId}
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.2 }}
          className="px-4 py-4 space-y-4"
        >
          {/* Level card */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.05 }}
            className="bg-white rounded-2xl shadow-sm p-4"
          >
            <div className="flex items-center justify-between mb-3">
              <div className="flex items-center gap-2">
                <div className="w-9 h-9 bg-blue-100 rounded-xl flex items-center justify-center">
                  <span className="text-lg">⭐</span>
                </div>
                <div>
                  <p className="text-xs text-gray-500">펫밀리 레벨</p>
                  <p className="font-bold text-gray-800">
                    Lv.{activeLevelData?.level}{' '}
                    <span className="text-primary font-semibold text-sm">{activeLevelData?.title}</span>
                  </p>
                </div>
              </div>
              <div className="text-right">
                <span className="text-2xl font-bold text-primary">{activeLevelData?.score}</span>
                <span className="text-gray-400 text-sm"> / {activeLevelData?.maxScore}</span>
              </div>
            </div>
            <ProgressBar value={activeLevelData?.score || 0} max={activeLevelData?.maxScore || 100} height="h-2.5" />
            <div className="flex gap-2 mt-3 flex-wrap">
              {activeLevelData?.badges.map(b => (
                <Badge key={b} variant="blue" className="text-xs">{b}</Badge>
              ))}
              <Badge variant="gray" className="text-xs">
                Lv.{(activeLevelData?.level || 0) + 1}까지 {(activeLevelData?.maxScore || 100) - (activeLevelData?.score || 0)}점
              </Badge>
            </div>
          </motion.div>

          {/* Quick Check */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="bg-white rounded-2xl shadow-sm p-4"
          >
            <div className="flex items-center justify-between mb-3">
              <h3 className="font-bold text-gray-800">오늘의 Quick Check</h3>
              <span className="text-xs text-gray-400">{doneCount}/{totalGroups} 완료</span>
            </div>
            <div className="flex gap-3">
              {CHECK_GROUPS.map(group => {
                const groupData = activeQC.groups[group.key]
                const isDone = groupData?.done

                return (
                  <motion.button
                    key={group.key}
                    onClick={() => !isDone && setActiveModal(group.key)}
                    disabled={isDone}
                    className={`flex-1 py-4 rounded-xl border-2 flex flex-col items-center gap-1.5 transition-all duration-200
                      ${isDone
                        ? 'border-gray-200 bg-gray-100 cursor-not-allowed'
                        : 'border-primary bg-blue-50 cursor-pointer'
                      }`}
                    whileTap={isDone ? {} : { scale: 0.93 }}
                  >
                    <span className="text-2xl">{group.emoji}</span>
                    <span className={`text-xs font-semibold leading-tight text-center ${isDone ? 'text-gray-400' : 'text-primary'}`}>
                      {group.key}
                    </span>
                    <AnimatePresence>
                      {isDone ? (
                        <motion.div
                          initial={{ opacity: 0, scale: 0 }}
                          animate={{ opacity: 1, scale: 1 }}
                          className="flex flex-col items-center gap-0.5"
                        >
                          <span className="text-xs text-gray-400 font-bold">완료 ✓</span>
                          <span className="text-[10px] text-gray-400 leading-tight text-center">
                            오늘은 수정할 수 없어요
                          </span>
                        </motion.div>
                      ) : (
                        <motion.span
                          initial={{ opacity: 0 }}
                          animate={{ opacity: 1 }}
                          className="text-[10px] text-primary/70"
                        >
                          탭하여 체크
                        </motion.span>
                      )}
                    </AnimatePresence>
                  </motion.button>
                )
              })}
            </div>

            {/* 완료 항목 표시 */}
            {CHECK_GROUPS.map(group => {
              const groupData = activeQC.groups[group.key]
              if (!groupData?.done || !groupData.checkedItems.length) return null
              const allItems = group.items
              const checkedLabels = groupData.checkedItems
                .map(key => allItems.find(i => i.key === key)?.label)
                .filter(Boolean)
              return (
                <motion.div
                  key={group.key}
                  initial={{ opacity: 0, height: 0 }}
                  animate={{ opacity: 1, height: 'auto' }}
                  className="mt-2 bg-blue-50 rounded-xl px-3 py-2 flex items-center gap-2"
                >
                  <span className="text-sm">{group.emoji}</span>
                  <span className="text-xs text-primary font-medium">
                    {checkedLabels.join(', ')} 완료! +{groupData.checkedItems.length * 2}점
                  </span>
                </motion.div>
              )
            })}

            {doneCount === totalGroups && (
              <motion.div
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                className="mt-3 bg-green-50 rounded-xl p-3 flex items-center gap-2"
              >
                <span>🎉</span>
                <p className="text-sm font-medium text-green-700">오늘 모든 체크 완료! 보너스 +3점</p>
              </motion.div>
            )}
          </motion.div>

          {/* AI Comment */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.15 }}
            className="bg-gradient-to-r from-primary to-primary-light rounded-2xl p-4 flex items-start gap-3"
          >
            <div className="w-9 h-9 bg-white/20 rounded-xl flex items-center justify-center flex-shrink-0 mt-0.5">
              <span className="text-lg">🤖</span>
            </div>
            <div>
              <p className="text-white font-semibold text-xs mb-1">AI 건강 코멘트</p>
              <p className="text-blue-50 text-sm leading-relaxed">{aiComment}</p>
            </div>
          </motion.div>

          {/* Health contents */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
          >
            <div className="flex items-center justify-between mb-3">
              <h3 className="font-bold text-gray-800">건강 콘텐츠</h3>
              <button className="text-xs text-primary font-medium">전체보기</button>
            </div>
            <div className="flex gap-3 overflow-x-auto scrollbar-hide -mx-4 px-4">
              {mockHealthContents.map(content => (
                <motion.div
                  key={content.id}
                  className={`flex-shrink-0 w-52 bg-gradient-to-br ${content.color} rounded-2xl p-4 cursor-pointer`}
                  whileTap={{ scale: 0.97 }}
                >
                  <Badge variant="blue" className="bg-white/20 text-white border-0 text-xs mb-2">
                    {content.tag}
                  </Badge>
                  <p className="text-white font-bold text-sm leading-tight">{content.title}</p>
                  <p className="text-white/70 text-xs mt-1">{content.subtitle}</p>
                </motion.div>
              ))}
            </div>
          </motion.div>

          {/* AI Diagnosis shortcut */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.25 }}
            onClick={() => navigate('/diagnosis')}
            className="bg-white rounded-2xl shadow-sm p-4 flex items-center justify-between cursor-pointer border-2 border-blue-100"
          >
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                <span className="text-2xl">🔬</span>
              </div>
              <div>
                <p className="font-bold text-gray-800">AI 증상 진단</p>
                <p className="text-xs text-gray-500">{activePet.name}의 증상을 분석해드려요</p>
              </div>
            </div>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#3B82F6" strokeWidth="2.5">
              <path d="M9 18l6-6-6-6"/>
            </svg>
          </motion.div>
        </motion.div>
      </AnimatePresence>

      <BottomNav />
    </PageWrapper>
    </>
  )
}
