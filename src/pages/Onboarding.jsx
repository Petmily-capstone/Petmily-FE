import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import useAppStore from '../store/useAppStore'
import Button from '../components/Button'

const slides = [
  {
    emoji: '🐾',
    title: '반려동물의 건강한 일상',
    subtitle: '펫밀리와 함께하세요',
    desc: '우리 아이의 산책, 식사, 건강을 매일 체크하고\n펫밀리 레벨을 높여보세요!',
    bg: 'from-blue-500 to-blue-600',
    light: '#EFF6FF',
  },
  {
    emoji: '🔬',
    title: 'AI 증상 진단',
    subtitle: '전문가 수준의 AI 분석',
    desc: '증상을 입력하면 AI가 분석해드려요.\n사진 첨부로 더 정확한 진단이 가능해요.',
    bg: 'from-purple-500 to-blue-500',
    light: '#F3F0FF',
  },
  {
    emoji: '🛒',
    title: '맞춤 펫푸드 쇼핑',
    subtitle: '내 아이에게 딱 맞는 제품',
    desc: '성분 분석과 펫밀리 점수로\n안전하고 건강한 제품을 찾아드려요.',
    bg: 'from-blue-500 to-teal-500',
    light: '#F0FDF4',
  },
]

export default function Onboarding() {
  const navigate = useNavigate()
  const { completeOnboarding } = useAppStore()
  const [current, setCurrent] = useState(0)
  const [direction, setDirection] = useState(1)

  const goNext = () => {
    if (current < slides.length - 1) {
      setDirection(1)
      setCurrent(current + 1)
    } else {
      completeOnboarding()
      navigate('/login')
    }
  }

  const goPrev = () => {
    if (current > 0) {
      setDirection(-1)
      setCurrent(current - 1)
    }
  }

  const skip = () => {
    completeOnboarding()
    navigate('/login')
  }

  const slide = slides[current]

  return (
    <div className="min-h-screen flex flex-col" style={{ background: slide.light }}>
      {/* Skip button */}
      <div className="flex justify-end p-4">
        {current < slides.length - 1 && (
          <button onClick={skip} className="text-sm text-gray-400 font-medium px-3 py-1.5 rounded-full hover:bg-gray-100">
            건너뛰기
          </button>
        )}
      </div>

      {/* Slide content - onPanEnd로 좌우 스와이프 감지 */}
      <motion.div
        className="flex-1 flex flex-col items-center justify-center px-8 pb-8"
        onPanEnd={(e, info) => {
          if (Math.abs(info.offset.x) < 40) return
          if (info.offset.x < 0) goNext()
          else goPrev()
        }}
      >
        <AnimatePresence mode="wait">
          <motion.div
            key={current}
            initial={{ opacity: 0, x: direction * 80 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: direction * -80 }}
            transition={{ duration: 0.3, ease: 'easeOut' }}
            className="flex flex-col items-center text-center w-full"
          >
            {/* Illustration card */}
            <motion.div
              className={`w-56 h-56 rounded-3xl bg-gradient-to-br ${slide.bg} flex items-center justify-center shadow-2xl mb-8`}
              animate={{ y: [0, -10, 0] }}
              transition={{ duration: 4, repeat: Infinity, ease: 'easeInOut' }}
            >
              <span className="text-8xl">{slide.emoji}</span>
            </motion.div>

            <span className="text-primary text-sm font-semibold bg-blue-100 px-4 py-1.5 rounded-full mb-3">
              {slide.subtitle}
            </span>
            <h2 className="text-2xl font-bold text-gray-800 mb-3">{slide.title}</h2>
            <p className="text-gray-500 text-sm leading-relaxed whitespace-pre-line">
              {slide.desc}
            </p>
          </motion.div>
        </AnimatePresence>
      </motion.div>

      {/* Bottom area */}
      <div className="px-6 pb-10 flex flex-col items-center gap-5">
        {/* Dots */}
        <div className="flex gap-2">
          {slides.map((_, i) => (
            <motion.button
              key={i}
              onClick={() => { setDirection(i > current ? 1 : -1); setCurrent(i) }}
              className={`rounded-full transition-all duration-300 ${i === current ? 'w-6 h-2 bg-primary' : 'w-2 h-2 bg-gray-300'}`}
            />
          ))}
        </div>

        {/* Button */}
        <div className="w-full flex gap-3">
          {current > 0 && (
            <Button onClick={goPrev} variant="secondary" className="flex-1">
              이전
            </Button>
          )}
          <Button onClick={goNext} variant="primary" className="flex-1" size="lg">
            {current === slides.length - 1 ? '🐾 시작하기' : '다음'}
          </Button>
        </div>
      </div>
    </div>
  )
}
