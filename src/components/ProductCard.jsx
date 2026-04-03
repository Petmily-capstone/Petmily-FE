import { motion } from 'framer-motion'
import { useNavigate } from 'react-router-dom'
import useAppStore from '../store/useAppStore'
import Badge from './Badge'

export default function ProductCard({ product, size = 'default' }) {
  const navigate = useNavigate()
  const { wishlist, toggleWishlist } = useAppStore()
  const isWished = wishlist.includes(product.id)

  if (size === 'small') {
    return (
      <motion.div
        onClick={() => navigate(`/shop/product/${product.id}`)}
        className="bg-white rounded-2xl shadow-sm overflow-hidden cursor-pointer flex-shrink-0 w-36"
        whileTap={{ scale: 0.97 }}
      >
        <div className="relative">
          <img
            src={`https://picsum.photos/200/200?random=${product.id}`}
            alt={product.name}
            className="w-full h-28 object-cover"
          />
          <motion.button
            onClick={(e) => { e.stopPropagation(); toggleWishlist(product.id) }}
            className="absolute top-2 right-2 w-7 h-7 bg-white rounded-full flex items-center justify-center shadow-sm"
            whileTap={{ scale: 0.85 }}
          >
            <span className="text-sm">{isWished ? '❤️' : '🤍'}</span>
          </motion.button>
        </div>
        <div className="p-2.5">
          <p className="text-xs text-gray-400 mb-0.5">{product.brand}</p>
          <p className="text-xs font-semibold text-gray-800 line-clamp-2 leading-tight">{product.name}</p>
          <p className="text-sm font-bold text-primary mt-1">{product.price.toLocaleString()}원</p>
          <div className="flex items-center gap-1 mt-1">
            <span className="text-yellow-400 text-xs">⭐</span>
            <span className="text-xs font-medium text-gray-600">{product.petmilyScore}</span>
          </div>
        </div>
      </motion.div>
    )
  }

  return (
    <motion.div
      onClick={() => navigate(`/shop/product/${product.id}`)}
      className="bg-white rounded-2xl shadow-sm overflow-hidden cursor-pointer"
      whileTap={{ scale: 0.97 }}
    >
      <div className="relative">
        <img
          src={`https://picsum.photos/200/200?random=${product.id}`}
          alt={product.name}
          className="w-full h-40 object-cover"
        />
        <motion.button
          onClick={(e) => { e.stopPropagation(); toggleWishlist(product.id) }}
          className="absolute top-2 right-2 w-8 h-8 bg-white rounded-full flex items-center justify-center shadow-sm"
          whileTap={{ scale: 0.8 }}
        >
          <span>{isWished ? '❤️' : '🤍'}</span>
        </motion.button>
        {product.originalPrice > product.price && (
          <div className="absolute top-2 left-2 bg-red-500 text-white text-xs font-bold px-2 py-0.5 rounded-full">
            {Math.round((1 - product.price / product.originalPrice) * 100)}%
          </div>
        )}
      </div>
      <div className="p-3">
        <p className="text-xs text-gray-400 mb-0.5">{product.brand}</p>
        <p className="text-sm font-semibold text-gray-800 line-clamp-2 leading-snug">{product.name}</p>
        <div className="flex items-center gap-2 mt-2">
          <span className="text-base font-bold text-gray-900">{product.price.toLocaleString()}원</span>
          {product.originalPrice > product.price && (
            <span className="text-xs text-gray-400 line-through">{product.originalPrice.toLocaleString()}원</span>
          )}
        </div>
        <div className="flex items-center justify-between mt-1.5">
          <div className="flex items-center gap-1">
            <span className="text-yellow-400 text-xs">⭐</span>
            <span className="text-xs font-semibold text-gray-700">{product.rating}</span>
            <span className="text-xs text-gray-400">({product.reviewCount})</span>
          </div>
          <Badge variant="blue">펫밀리 {product.petmilyScore}점</Badge>
        </div>
      </div>
    </motion.div>
  )
}
