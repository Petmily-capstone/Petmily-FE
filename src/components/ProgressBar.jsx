import { motion } from 'framer-motion'

export default function ProgressBar({ value, max = 100, color = 'bg-primary', height = 'h-2', className = '' }) {
  const pct = Math.min(100, Math.max(0, (value / max) * 100))

  return (
    <div className={`w-full bg-blue-100 rounded-full overflow-hidden ${height} ${className}`}>
      <motion.div
        className={`${color} ${height} rounded-full`}
        initial={{ width: 0 }}
        animate={{ width: `${pct}%` }}
        transition={{ duration: 0.8, ease: 'easeOut' }}
      />
    </div>
  )
}
