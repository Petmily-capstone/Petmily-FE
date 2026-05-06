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

      </motion.div>
    </div>
  )
}
