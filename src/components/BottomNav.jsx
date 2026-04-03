import { useNavigate, useLocation } from 'react-router-dom'
import { motion } from 'framer-motion'

const tabs = [
  {
    path: '/home',
    label: '홈',
    icon: (active) => (
      <svg width="22" height="22" viewBox="0 0 24 24" fill={active ? '#3B82F6' : 'none'} stroke={active ? '#3B82F6' : '#94A3B8'} strokeWidth="2">
        <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
        <polyline points="9,22 9,12 15,12 15,22"/>
      </svg>
    ),
  },
  {
    path: '/diagnosis',
    label: 'AI진단',
    icon: (active) => (
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke={active ? '#3B82F6' : '#94A3B8'} strokeWidth="2">
        <path d="M9 3H5a2 2 0 00-2 2v4m6-6h10a2 2 0 012 2v4M9 3v18m0 0h10a2 2 0 002-2V9M9 21H5a2 2 0 01-2-2V9m0 0h18"/>
        <circle cx="12" cy="12" r="2" fill={active ? '#3B82F6' : '#94A3B8'}/>
      </svg>
    ),
  },
  {
    path: '/shop',
    label: '쇼핑',
    icon: (active) => (
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke={active ? '#3B82F6' : '#94A3B8'} strokeWidth="2">
        <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/>
        <line x1="3" y1="6" x2="21" y2="6"/>
        <path d="M16 10a4 4 0 01-8 0"/>
      </svg>
    ),
  },
  {
    path: '/mypage',
    label: '마이페이지',
    icon: (active) => (
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke={active ? '#3B82F6' : '#94A3B8'} strokeWidth="2">
        <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/>
        <circle cx="12" cy="7" r="4"/>
      </svg>
    ),
  },
]

export default function BottomNav() {
  const navigate = useNavigate()
  const location = useLocation()

  return (
    <div className="fixed bottom-0 left-1/2 -translate-x-1/2 w-[390px] bg-white border-t border-gray-100 z-50"
      style={{ boxShadow: '0 -4px 20px rgba(59,130,246,0.08)' }}>
      <div className="flex items-center justify-around px-2 py-2 pb-safe">
        {tabs.map((tab) => {
          const active = location.pathname.startsWith(tab.path)
          return (
            <motion.button
              key={tab.path}
              onClick={() => navigate(tab.path)}
              className="flex flex-col items-center gap-0.5 px-4 py-1.5 rounded-2xl"
              whileTap={{ scale: 0.9 }}
            >
              {tab.icon(active)}
              <span className={`text-[10px] font-medium ${active ? 'text-primary' : 'text-slate-400'}`}>
                {tab.label}
              </span>
              {active && (
                <motion.div
                  layoutId="navIndicator"
                  className="absolute bottom-1 w-1 h-1 rounded-full bg-primary"
                  style={{ position: 'relative' }}
                />
              )}
            </motion.button>
          )
        })}
      </div>
    </div>
  )
}
