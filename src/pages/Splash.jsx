import { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion } from 'framer-motion'
import useAppStore from '../store/useAppStore'

export default function Splash() {
  const navigate = useNavigate()
  const { hasCompletedOnboarding, isLoggedIn, hasRegisteredPet } = useAppStore()

  useEffect(() => {
    const timer = setTimeout(() => {
      if (!hasCompletedOnboarding) {
        navigate('/onboarding')
      } else if (!isLoggedIn) {
        navigate('/login')
      } else if (!hasRegisteredPet) {
        navigate('/pet-setup')
      } else {
        navigate('/home')
      }
    }, 2500)
    return () => clearTimeout(timer)
  }, [])

  return (
    <div className="min-h-screen bg-gradient-to-b from-primary-deep via-primary to-primary-light flex flex-col items-center justify-center relative overflow-hidden">
      {/* Background circles */}
      <motion.div
        className="absolute w-64 h-64 bg-white/5 rounded-full -top-16 -right-16"
        animate={{ scale: [1, 1.1, 1], rotate: [0, 10, 0] }}
        transition={{ duration: 8, repeat: Infinity }}
      />
      <motion.div
        className="absolute w-48 h-48 bg-white/5 rounded-full -bottom-10 -left-10"
        animate={{ scale: [1, 1.15, 1] }}
        transition={{ duration: 6, repeat: Infinity, delay: 1 }}
      />

      {/* Logo area */}
      <motion.div
        initial={{ opacity: 0, scale: 0.7, y: 20 }}
        animate={{ opacity: 1, scale: 1, y: 0 }}
        transition={{ duration: 0.7, ease: 'easeOut' }}
        className="flex flex-col items-center gap-4"
      >
        {/* Logo icon */}
        <motion.div
          className="w-24 h-24 bg-white rounded-3xl flex items-center justify-center shadow-2xl"
          animate={{ y: [0, -8, 0] }}
          transition={{ duration: 3, repeat: Infinity, ease: 'easeInOut' }}
        >
          <span className="text-5xl">🐾</span>
        </motion.div>

        {/* Brand name */}
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3, duration: 0.5 }}
          className="text-center"
        >
          <h1 className="text-4xl font-bold text-white tracking-tight">펫밀리</h1>
          <p className="text-blue-100 text-sm mt-1 font-medium">반려동물 AI 헬스케어</p>
        </motion.div>
      </motion.div>

      {/* Loading dots */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.8 }}
        className="absolute bottom-16 flex gap-2"
      >
        {[0, 1, 2].map((i) => (
          <motion.div
            key={i}
            className="w-2 h-2 bg-white/60 rounded-full"
            animate={{ opacity: [0.3, 1, 0.3], y: [0, -4, 0] }}
            transition={{ duration: 1.2, repeat: Infinity, delay: i * 0.2 }}
          />
        ))}
      </motion.div>

      {/* Bottom tagline */}
      <motion.p
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 1 }}
        className="absolute bottom-8 text-blue-200 text-xs"
      >
        내 반려동물의 건강한 일상 🐶
      </motion.p>
    </div>
  )
}
