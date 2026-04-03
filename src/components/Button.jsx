import { motion } from 'framer-motion'

export default function Button({ children, onClick, variant = 'primary', className = '', disabled = false, size = 'md' }) {
  const base = 'font-semibold rounded-2xl transition-all duration-200 flex items-center justify-center gap-2'
  const sizes = {
    sm: 'px-4 py-2 text-sm',
    md: 'px-6 py-3.5 text-base',
    lg: 'w-full py-4 text-base',
  }
  const variants = {
    primary: 'bg-primary text-white shadow-lg shadow-blue-200 active:shadow-sm',
    secondary: 'bg-white text-primary border-2 border-primary',
    ghost: 'bg-transparent text-primary',
    danger: 'bg-red-500 text-white',
    kakao: 'bg-[#FEE500] text-[#3C1E1E]',
    google: 'bg-white text-gray-700 border border-gray-200 shadow-sm',
  }

  return (
    <motion.button
      onClick={onClick}
      disabled={disabled}
      className={`${base} ${sizes[size]} ${variants[variant]} ${disabled ? 'opacity-50 cursor-not-allowed' : ''} ${className}`}
      whileTap={{ scale: disabled ? 1 : 0.97 }}
      whileHover={{ scale: disabled ? 1 : 1.01 }}
    >
      {children}
    </motion.button>
  )
}
