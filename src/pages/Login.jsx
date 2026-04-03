import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion } from 'framer-motion'
import useAppStore from '../store/useAppStore'
import Button from '../components/Button'

export default function Login() {
  const navigate = useNavigate()
  const { login } = useAppStore()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [focused, setFocused] = useState(null)

  const handleLogin = () => {
    login()
    navigate('/pet-setup')
  }

  return (
    <div className="min-h-screen bg-[#F0F7FF] flex flex-col">
      {/* Header */}
      <div className="bg-gradient-to-b from-primary-deep to-primary pt-16 pb-12 px-6 text-center">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div className="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center mx-auto mb-4">
            <span className="text-3xl">🐾</span>
          </div>
          <h1 className="text-2xl font-bold text-white">펫밀리</h1>
          <p className="text-blue-200 text-sm mt-1">반려동물과 함께하는 건강한 일상</p>
        </motion.div>
      </div>

      {/* Form */}
      <motion.div
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.2, duration: 0.4 }}
        className="flex-1 bg-[#F0F7FF] rounded-t-3xl -mt-4 px-6 pt-8 pb-10"
      >
        <h2 className="text-xl font-bold text-gray-800 mb-6">로그인</h2>

        {/* Email */}
        <div className="mb-4">
          <label className="text-sm font-medium text-gray-600 mb-1.5 block">이메일</label>
          <motion.div
            animate={{ borderColor: focused === 'email' ? '#3B82F6' : '#E2E8F0' }}
            className="bg-white rounded-xl border-2 transition-colors"
          >
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              onFocus={() => setFocused('email')}
              onBlur={() => setFocused(null)}
              placeholder="이메일을 입력하세요"
              className="w-full px-4 py-3.5 bg-transparent text-sm text-gray-800 placeholder-gray-400 outline-none"
            />
          </motion.div>
        </div>

        {/* Password */}
        <div className="mb-6">
          <label className="text-sm font-medium text-gray-600 mb-1.5 block">비밀번호</label>
          <motion.div
            animate={{ borderColor: focused === 'pw' ? '#3B82F6' : '#E2E8F0' }}
            className="bg-white rounded-xl border-2 transition-colors"
          >
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              onFocus={() => setFocused('pw')}
              onBlur={() => setFocused(null)}
              placeholder="비밀번호를 입력하세요"
              className="w-full px-4 py-3.5 bg-transparent text-sm text-gray-800 placeholder-gray-400 outline-none"
            />
          </motion.div>
        </div>

        {/* Login button */}
        <Button onClick={handleLogin} size="lg" className="w-full mb-4">
          로그인
        </Button>

        {/* Forgot password */}
        <div className="flex justify-center gap-4 mb-6">
          <button className="text-sm text-gray-400">비밀번호 찾기</button>
          <span className="text-gray-300">|</span>
          <button className="text-sm text-gray-400">회원가입</button>
        </div>

        {/* Divider */}
        <div className="flex items-center gap-3 mb-6">
          <div className="flex-1 h-px bg-gray-200" />
          <span className="text-xs text-gray-400 font-medium">소셜 로그인</span>
          <div className="flex-1 h-px bg-gray-200" />
        </div>

        {/* Social buttons */}
        <div className="flex gap-3">
          <Button onClick={handleLogin} variant="kakao" className="flex-1 py-3 text-sm font-semibold">
            <span className="text-lg">💬</span>
            카카오
          </Button>
          <Button onClick={handleLogin} variant="google" className="flex-1 py-3 text-sm font-medium">
            <svg width="18" height="18" viewBox="0 0 24 24">
              <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
              <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
              <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
              <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
            </svg>
            구글
          </Button>
        </div>
      </motion.div>
    </div>
  )
}
