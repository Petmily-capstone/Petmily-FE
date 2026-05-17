import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import useAppStore from '../store/useAppStore'
import Button from '../components/Button'

function EyeIcon({ open }) {
  return open ? (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" strokeWidth="2" strokeLinecap="round">
      <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
      <circle cx="12" cy="12" r="3"/>
    </svg>
  ) : (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" strokeWidth="2" strokeLinecap="round">
      <path d="M17.94 17.94A10.07 10.07 0 0112 20c-7 0-11-8-11-8a18.45 18.45 0 015.06-5.94"/>
      <path d="M9.9 4.24A9.12 9.12 0 0112 4c7 0 11 8 11 8a18.5 18.5 0 01-2.16 3.19"/>
      <line x1="1" y1="1" x2="23" y2="23"/>
    </svg>
  )
}

export default function Login() {
  const navigate = useNavigate()
  const { login, hasRegisteredPet } = useAppStore()

  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [showPw, setShowPw] = useState(false)
  const [focused, setFocused] = useState(null)
  const [errors, setErrors] = useState({})

  const handleLogin = () => {
    const next = {}
    if (!email.trim() || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      next.email = '올바른 이메일 형식을 입력해주세요'
    }
    if (password.length < 6) {
      next.password = '비밀번호는 6자 이상이어야 합니다'
    }
    if (Object.keys(next).length > 0) {
      setErrors(next)
      return
    }
    login()
    navigate(hasRegisteredPet ? '/home' : '/pet-setup')
  }

  const handleKakao = () => {
    login()
    navigate(hasRegisteredPet ? '/home' : '/pet-setup')
  }

  return (
    <div className="min-h-screen bg-[#F0F7FF] flex flex-col">
      {/* Header */}
      <div className="bg-gradient-to-b from-primary-deep to-primary pt-16 pb-14 px-6 text-center">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.45 }}
        >
          <div className="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center mx-auto mb-4">
            <span className="text-3xl">🐾</span>
          </div>
          <h1 className="text-2xl font-bold text-white">펫밀리</h1>
          <p className="text-blue-200 text-sm mt-1">반려동물과 함께하는 건강한 일상</p>
        </motion.div>
      </div>

      {/* Form card */}
      <motion.div
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.15, duration: 0.4 }}
        className="flex-1 bg-white rounded-t-3xl -mt-5 px-6 pt-8 pb-10 shadow-xl"
      >
        <h2 className="text-xl font-bold text-gray-800 mb-6">로그인</h2>

        {/* Email */}
        <div className="mb-4">
          <label className="text-sm font-medium text-gray-600 mb-1.5 block">이메일</label>
          <motion.div
            animate={{ borderColor: errors.email ? '#EF4444' : focused === 'email' ? '#3B82F6' : '#E5E7EB' }}
            className="bg-gray-50 rounded-xl border-2 transition-colors"
          >
            <input
              type="email"
              value={email}
              onChange={(e) => { setEmail(e.target.value); setErrors(p => ({ ...p, email: undefined })) }}
              onFocus={() => setFocused('email')}
              onBlur={() => setFocused(null)}
              placeholder="이메일을 입력하세요"
              className="w-full px-4 py-3.5 bg-transparent text-sm text-gray-800 placeholder-gray-400 outline-none"
            />
          </motion.div>
          <AnimatePresence>
            {errors.email && (
              <motion.p
                initial={{ opacity: 0, y: -4 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0 }}
                className="text-xs text-red-500 mt-1.5 ml-1"
              >
                {errors.email}
              </motion.p>
            )}
          </AnimatePresence>
        </div>

        {/* Password */}
        <div className="mb-8">
          <label className="text-sm font-medium text-gray-600 mb-1.5 block">비밀번호</label>
          <motion.div
            animate={{ borderColor: errors.password ? '#EF4444' : focused === 'pw' ? '#3B82F6' : '#E5E7EB' }}
            className="bg-gray-50 rounded-xl border-2 transition-colors flex items-center pr-3"
          >
            <input
              type={showPw ? 'text' : 'password'}
              value={password}
              onChange={(e) => { setPassword(e.target.value); setErrors(p => ({ ...p, password: undefined })) }}
              onFocus={() => setFocused('pw')}
              onBlur={() => setFocused(null)}
              onKeyDown={(e) => e.key === 'Enter' && handleLogin()}
              placeholder="비밀번호를 입력하세요"
              className="flex-1 px-4 py-3.5 bg-transparent text-sm text-gray-800 placeholder-gray-400 outline-none"
            />
            <button type="button" onClick={() => setShowPw(p => !p)} className="p-1">
              <EyeIcon open={showPw} />
            </button>
          </motion.div>
          <AnimatePresence>
            {errors.password && (
              <motion.p
                initial={{ opacity: 0, y: -4 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0 }}
                className="text-xs text-red-500 mt-1.5 ml-1"
              >
                {errors.password}
              </motion.p>
            )}
          </AnimatePresence>
        </div>

        {/* 로그인 버튼 */}
        <Button onClick={handleLogin} size="lg" className="w-full mb-4">
          로그인
        </Button>

        {/* 비번 찾기 / 회원가입 */}
        <div className="flex justify-center gap-4 mb-6">
          <button className="text-sm text-gray-400 hover:text-gray-600">비밀번호 찾기</button>
          <span className="text-gray-300">|</span>
          <button className="text-sm text-gray-400 hover:text-gray-600">회원가입</button>
        </div>

        {/* 소셜 로그인 구분선 */}
        <div className="flex items-center gap-3 mb-5">
          <div className="flex-1 h-px bg-gray-200" />
          <span className="text-xs text-gray-400 font-medium">간편 로그인</span>
          <div className="flex-1 h-px bg-gray-200" />
        </div>

        {/* 카카오 로그인 */}
        <motion.button
          onClick={handleKakao}
          whileTap={{ scale: 0.97 }}
          className="w-full py-3.5 rounded-xl flex items-center justify-center gap-2.5 font-semibold text-sm"
          style={{ backgroundColor: '#FEE500', color: '#191919' }}
        >
          <svg width="20" height="20" viewBox="0 0 24 24" fill="#191919">
            <path d="M12 3C7.03 3 3 6.36 3 10.5c0 2.64 1.68 4.96 4.22 6.34l-.9 3.33a.3.3 0 00.44.33L10.9 18.1c.36.04.73.07 1.1.07 4.97 0 9-3.36 9-7.5S16.97 3 12 3z"/>
          </svg>
          카카오로 시작하기
        </motion.button>
      </motion.div>
    </div>
  )
}
