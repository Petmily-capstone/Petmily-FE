import { motion } from 'framer-motion'

const pageVariants = {
  initial: { opacity: 0, y: 20 },
  animate: { opacity: 1, y: 0 },
  exit: { opacity: 0, y: -10 },
}

export default function PageWrapper({ children, className = '', hasNav = true }) {
  return (
    <motion.div
      variants={pageVariants}
      initial="initial"
      animate="animate"
      exit="exit"
      transition={{ duration: 0.25, ease: 'easeOut' }}
      className={`min-h-screen bg-[#F0F7FF] ${hasNav ? 'pb-20' : ''} ${className}`}
    >
      {children}
    </motion.div>
  )
}
