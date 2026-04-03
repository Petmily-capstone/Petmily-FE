import { useNavigate, useSearchParams } from 'react-router-dom'
import { motion } from 'framer-motion'
import useAppStore from '../store/useAppStore'
import Button from '../components/Button'

export default function PetSetupComplete() {
  const navigate = useNavigate()
  const [searchParams] = useSearchParams()
  const isAddMode = searchParams.get('mode') === 'add'

  const { pets, activePetId } = useAppStore()
  const activePet = pets.find(p => p.id === activePetId) || pets[0]

  return (
    <div className="min-h-screen bg-gradient-to-b from-primary-deep to-primary-light flex flex-col items-center justify-center px-6">
      <motion.div
        initial={{ scale: 0, rotate: -180 }}
        animate={{ scale: 1, rotate: 0 }}
        transition={{ duration: 0.6, type: 'spring', bounce: 0.4 }}
        className="w-32 h-32 bg-white rounded-full flex items-center justify-center shadow-2xl mb-8"
      >
        <span className="text-6xl">🎉</span>
      </motion.div>

      {['🐾', '⭐', '💙', '🌟', '🐶'].map((emoji, i) => (
        <motion.span
          key={i}
          className="absolute text-2xl"
          style={{ left: `${15 + i * 18}%`, top: `${20 + (i % 3) * 15}%` }}
          animate={{ y: [0, -20, 0], rotate: [0, 10, -10, 0], opacity: [0.6, 1, 0.6] }}
          transition={{ duration: 2 + i * 0.5, repeat: Infinity, delay: i * 0.3 }}
        >
          {emoji}
        </motion.span>
      ))}

      <motion.div
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.4 }}
        className="text-center mb-8"
      >
        <h1 className="text-3xl font-bold text-white mb-3">등록 완료!</h1>
        <p className="text-blue-100 text-base leading-relaxed">
          <span className="text-white font-bold">{activePet.name}</span>이(가) 펫밀리에<br />
          성공적으로 등록되었어요 🐾
        </p>
      </motion.div>

      <motion.div
        initial={{ opacity: 0, scale: 0.8 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ delay: 0.6 }}
        className="bg-white/20 backdrop-blur-sm rounded-3xl p-5 w-full mb-8 flex items-center gap-4"
      >
        <div className="w-16 h-16 rounded-2xl overflow-hidden bg-white/30">
          <img
            src={activePet.type === 'cat' ? 'https://placekitten.com/80/80' : 'https://placedog.net/80/80'}
            alt={activePet.name}
            className="w-full h-full object-cover"
          />
        </div>
        <div>
          <p className="text-white font-bold text-lg">{activePet.name}</p>
          <p className="text-blue-100 text-sm">{activePet.breed || '믹스'} · {activePet.gender || '미선택'}</p>
          <div className="flex gap-1 mt-1">
            {['첫 등록', '펫밀리 신규'].map(b => (
              <span key={b} className="text-xs bg-white/20 text-white px-2 py-0.5 rounded-full">{b}</span>
            ))}
          </div>
        </div>
      </motion.div>

      {!isAddMode && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.8 }}
          className="bg-white/10 rounded-2xl p-4 w-full mb-8"
        >
          <p className="text-white text-sm text-center leading-relaxed">
            🎁 신규 회원 웰컴 선물로<br />
            <span className="font-bold">펫밀리 포인트 500P</span>가 지급되었어요!
          </p>
        </motion.div>
      )}

      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 1 }}
        className="w-full"
      >
        <Button
          onClick={() => navigate('/home')}
          variant="secondary"
          size="lg"
          className="w-full bg-white text-primary border-0"
        >
          🏠 홈으로 이동
        </Button>
      </motion.div>
    </div>
  )
}
