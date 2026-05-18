import { useState, useRef, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import useAppStore from '../store/useAppStore'
import BottomNav from '../components/BottomNav'
import PageWrapper from '../components/PageWrapper'
import ProgressBar from '../components/ProgressBar'
import Badge from '../components/Badge'
import { mockHealthContents } from '../data/mockData'
import catImage from '../assets/cat/cat.jpg'
import dogImage from '../assets/dog/dog.jpg'

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

// ── Quick Check 모달 (고정 높이 바텀시트) ──
function QuickCheckModal({ group, onConfirm, onCancel }) {
  const [checked, setChecked] = useState([])

  const toggle = (key) => {
    setChecked(prev =>
      prev.includes(key) ? prev.filter(k => k !== key) : [...prev, key]
    )
  }

  return (
    <motion.div
      className="fixed z-[60] flex items-end justify-center"
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

      {/* 고정 높이 시트 */}
      <motion.div
        style={{ height: '60vh' }}
        className="relative w-full bg-white rounded-t-3xl flex flex-col overflow-hidden"
        initial={{ y: '100%' }}
        animate={{ y: 0 }}
        exit={{ y: '100%' }}
        transition={{ type: 'spring', damping: 30, stiffness: 300 }}
      >
        {/* 헤더 (고정) */}
        <div className="px-6 pt-4 pb-3 shrink-0">
          <div className="w-10 h-1.5 bg-gray-300 rounded-full mx-auto mb-4" />
          <h3 className="text-lg font-bold text-gray-800 mb-0.5">
            오늘 {group.key} 했나요?
          </h3>
          <p className="text-sm text-gray-400">체크한 항목마다 +2점이 올라요</p>
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
        <div className="px-6 pt-3 pb-6 shrink-0 border-t border-gray-100 flex gap-3 bg-white">
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

function HealthContentArticle({ content, onClose }) {
  return (
    <motion.div
      className="fixed z-[70] flex items-center justify-center bg-black/45 px-4 py-8"
      style={{
        top: 0, bottom: 0,
        width: '390px', left: '50%', transform: 'translateX(-50%)',
      }}
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      onClick={onClose}
    >
      <motion.div
        className="w-full max-h-[82vh] overflow-y-auto scrollbar-hide bg-[#F7FAFC] rounded-2xl shadow-2xl"
        initial={{ opacity: 0, y: 24, scale: 0.96 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, y: 24, scale: 0.96 }}
        transition={{ duration: 0.22, ease: 'easeOut' }}
        onClick={(e) => e.stopPropagation()}
      >
        <div className={`bg-gradient-to-br ${content.color} px-5 pt-5 pb-7 text-white rounded-t-2xl`}>
          <div className="flex items-start justify-between gap-3 mb-6">
            <div className="flex items-center gap-2">
              <Badge variant="blue" className="bg-white/20 text-white border-0 text-xs">
                {content.tag}
              </Badge>
              <span className="text-xs text-white/75">{content.category}</span>
            </div>
            <button
              type="button"
              onClick={onClose}
              className="w-8 h-8 rounded-full bg-white/20 flex items-center justify-center flex-shrink-0"
              aria-label="건강 콘텐츠 닫기"
            >
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2.5">
                <path d="M18 6L6 18M6 6l12 12"/>
              </svg>
            </button>
          </div>

          <div className="text-5xl mb-4">{content.heroEmoji}</div>
          <h2 className="text-2xl font-bold leading-tight mb-3">{content.title}</h2>
          <p className="text-sm text-white/85 leading-relaxed">{content.subtitle}</p>
          <div className="flex items-center gap-2 mt-5 text-xs text-white/70">
            <span>{content.date}</span>
            <span className="w-1 h-1 rounded-full bg-white/50" />
            <span>{content.readTime} 읽기</span>
          </div>
        </div>

        <article className="px-5 py-6">
          <p className="text-base font-medium text-gray-800 leading-7 mb-6">
            {content.summary}
          </p>

          <div className="space-y-4">
            {content.sections.map((section, index) => (
              <section key={section.heading} className="bg-white rounded-2xl p-5 shadow-sm">
                <span className="text-xs font-bold text-primary">0{index + 1}</span>
                <h3 className="text-lg font-bold text-gray-900 mt-2 mb-3 leading-snug">
                  {section.heading}
                </h3>
                <p className="text-sm text-gray-600 leading-6">
                  {section.body}
                </p>
              </section>
            ))}
          </div>

          <section className="mt-5 bg-gray-900 rounded-2xl p-5 text-white">
            <p className="text-sm font-bold mb-3">오늘 바로 체크할 것</p>
            <div className="space-y-2.5">
              {content.tips.map(tip => (
                <div key={tip} className="flex items-start gap-2">
                  <span className="mt-1 w-1.5 h-1.5 rounded-full bg-primary-light flex-shrink-0" />
                  <p className="text-sm text-gray-100 leading-5">{tip}</p>
                </div>
              ))}
            </div>
          </section>
        </article>
      </motion.div>
    </motion.div>
  )
}

// ── 펫 프로필 카드 ──
function PetCard({ pet, isActive, onClick }) {
  return (
    <motion.div
      onClick={onClick}
      className="w-full cursor-pointer"
      whileTap={{ scale: 0.98 }}
    >
      <div
        className={`rounded-2xl px-4 py-3 flex items-center gap-4 transition-all ${
          isActive
            ? 'bg-white/20 border border-white/40'
            : 'bg-white/8 border border-white/15'
        }`}
        style={{ backdropFilter: 'blur(8px)' }}
      >
        {/* 사진 */}
        <div className="relative flex-shrink-0">
          <div className={`w-[68px] h-[68px] rounded-2xl overflow-hidden border-2 ${isActive ? 'border-white/70' : 'border-white/30'}`}>
            <img
              src={pet.type === 'cat' ? catImage : dogImage}
              alt={pet.name}
              className="w-full h-full object-cover"
            />
          </div>
          {isActive && (
            <div className="absolute -top-1.5 -right-1.5 w-5 h-5 bg-emerald-400 rounded-full border-2 border-white flex items-center justify-center shadow-sm">
              <svg width="9" height="9" viewBox="0 0 10 8" fill="none">
                <path d="M1 4l3 3 5-6" stroke="white" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </div>
          )}
        </div>

        {/* 정보 */}
        <div className="flex-1 min-w-0">
          <h2 className="text-white font-bold text-lg leading-tight truncate mb-1">{pet.name}</h2>
          <p className="text-blue-100/80 text-xs mb-1">
            {pet.breed || '믹스'} · {pet.age || '?'}살 · {pet.gender || '미선택'}
          </p>
          <p className="text-blue-100/60 text-xs truncate">
            🌿 알러지: {pet.allergy || '없음'}
          </p>
        </div>
      </div>
    </motion.div>
  )
}

// ── Add Pet 카드 ──
function AddPetCard({ onClick }) {
  return (
    <motion.div
      onClick={onClick}
      className="w-full rounded-2xl border border-dashed border-white/30 flex items-center gap-4 py-5 px-5 cursor-pointer"
      style={{ backdropFilter: 'blur(8px)', backgroundColor: 'rgba(255,255,255,0.07)' }}
      whileTap={{ scale: 0.97 }}
    >
      <div className="w-[68px] h-[68px] bg-white/15 rounded-2xl flex items-center justify-center flex-shrink-0 border border-white/20">
        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.7)" strokeWidth="2" strokeLinecap="round">
          <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
        </svg>
      </div>
      <div>
        <p className="text-white font-semibold text-sm">반려동물 추가</p>
        <p className="text-white/50 text-xs mt-0.5">새 펫을 등록해보세요</p>
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
  const [selectedContent, setSelectedContent] = useState(null)
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

      <AnimatePresence>
        {selectedContent && (
          <HealthContentArticle
            content={selectedContent}
            onClose={() => setSelectedContent(null)}
          />
        )}
      </AnimatePresence>

      <PageWrapper>
        {/* 알림 버튼 (파란 블럭 위) */}
        <div className="flex items-center justify-between px-4 pt-10 pb-2">
          <div>
            <p className="text-gray-400 text-xs font-medium mb-0.5">
              {new Date().toLocaleDateString('ko-KR', { month: 'long', day: 'numeric', weekday: 'short' })}
            </p>
            <h1 className="text-gray-800 text-xl font-bold tracking-tight">펫밀리</h1>
          </div>
          <motion.button
            whileTap={{ scale: 0.88 }}
            className="w-10 h-10 rounded-full flex items-center justify-center border border-gray-200 bg-white shadow-sm"
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#374151" strokeWidth="2" strokeLinecap="round">
              <path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9"/>
              <path d="M13.73 21a2 2 0 01-3.46 0"/>
            </svg>
          </motion.button>
        </div>

      {/* Header */}
      <div
        className="pt-2.5 pb-2.5 px-4 mx-2 mt-1 rounded-[28px]"
        style={{ background: 'linear-gradient(150deg, #1E4FD8 0%, #3B82F6 60%, #60A5FA 100%)' }}
      >

        {/* 캐러셀 */}
        <div className="overflow-hidden mt-4">
          <div
            ref={carouselRef}
            onScroll={handleCarouselScroll}
            className="flex overflow-x-auto scrollbar-hide"
            style={{ scrollSnapType: 'x mandatory', scrollBehavior: 'smooth' }}
          >
            {pets.map(pet => (
              <div key={pet.id} className="flex-shrink-0 w-full" style={{ scrollSnapAlign: 'start' }}>
                <PetCard
                  pet={pet}
                  isActive={pet.id === activePetId}
                  onClick={() => setActivePet(pet.id)}
                />
              </div>
            ))}
            <div className="flex-shrink-0 w-full" style={{ scrollSnapAlign: 'start' }}>
              <AddPetCard onClick={() => navigate('/pet-setup?mode=add')} />
            </div>
          </div>
        </div>

        {/* 인디케이터 */}
        <div className="flex justify-center gap-1.5 mt-1">
          {Array.from({ length: totalSlides }).map((_, i) => (
            <motion.div
              key={i}
              className="rounded-full bg-white"
              animate={{ width: i === carouselIndex ? 20 : 6, height: 6, opacity: i === carouselIndex ? 1 : 0.3 }}
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
                <motion.button
                  key={content.id}
                  type="button"
                  onClick={() => setSelectedContent(content)}
                  className="flex-shrink-0 w-52 bg-white rounded-2xl p-4 cursor-pointer shadow-sm border border-gray-100 text-left"
                  whileTap={{ scale: 0.97 }}
                >
                  <span
                    className="inline-block text-xs font-semibold px-2.5 py-1 rounded-full mb-2"
                    style={{ backgroundColor: '#EFF6FF', color: '#0147EB' }}
                  >
                    {content.tag}
                  </span>
                  <p className="text-gray-900 font-bold text-sm leading-tight">{content.title}</p>
                  <p className="text-gray-400 text-xs mt-1">{content.subtitle}</p>
                </motion.button>
              ))}
              <div className="flex-shrink-0 w-4" />
            </div>
          </motion.div>

        </motion.div>
      </AnimatePresence>

      <BottomNav />
    </PageWrapper>
    </>
  )
}
