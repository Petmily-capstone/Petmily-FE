import { motion } from 'framer-motion'

export default function Card({ children, className = '', onClick, animate = false }) {
  const base = 'bg-white rounded-2xl shadow-sm p-4'

  if (animate || onClick) {
    return (
      <motion.div
        className={`${base} ${className} ${onClick ? 'cursor-pointer' : ''}`}
        onClick={onClick}
        whileTap={onClick ? { scale: 0.98 } : {}}
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3 }}
      >
        {children}
      </motion.div>
    )
  }

  return (
    <div className={`${base} ${className}`}>
      {children}
    </div>
  )
}
