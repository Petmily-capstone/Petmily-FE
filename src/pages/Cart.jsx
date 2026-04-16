import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import useAppStore from '../store/useAppStore'
import PageWrapper from '../components/PageWrapper'
import BottomNav from '../components/BottomNav'

const DELIVERY_FEE = 3000
const FREE_DELIVERY_THRESHOLD = 50000

export default function Cart() {
  const navigate = useNavigate()
  const { cartItems, updateCartQty, removeFromCart } = useAppStore()

  const subtotal = cartItems.reduce((sum, item) => sum + item.price * item.qty, 0)
  const deliveryFee = subtotal >= FREE_DELIVERY_THRESHOLD || subtotal === 0 ? 0 : DELIVERY_FEE
  const total = subtotal + deliveryFee

  return (
    <PageWrapper>
      {/* Header */}
      <div className="bg-gradient-to-b from-primary-deep to-primary pt-12 pb-5 px-4">
        <div className="flex items-center gap-3">
          <motion.button
            onClick={() => navigate(-1)}
            whileTap={{ scale: 0.9 }}
            className="w-9 h-9 bg-white/20 rounded-full flex items-center justify-center"
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2.5">
              <path d="M15 18l-6-6 6-6"/>
            </svg>
          </motion.button>
          <div>
            <h1 className="text-xl font-bold text-white">장바구니</h1>
            {cartItems.length > 0 && (
              <p className="text-blue-200 text-xs">{cartItems.length}개 상품</p>
            )}
          </div>
        </div>
      </div>

      <div className="px-4 py-4 space-y-4">
        {cartItems.length === 0 ? (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="flex flex-col items-center justify-center py-20 gap-4"
          >
            <span className="text-6xl">🛒</span>
            <p className="text-gray-500 font-medium">장바구니가 비었어요</p>
            <motion.button
              onClick={() => navigate('/shop')}
              whileTap={{ scale: 0.96 }}
              className="bg-primary text-white px-6 py-2.5 rounded-full text-sm font-bold"
            >
              쇼핑하러 가기
            </motion.button>
          </motion.div>
        ) : (
          <>
            {/* Cart items */}
            <div className="bg-white rounded-2xl shadow-sm overflow-hidden">
              <AnimatePresence>
                {cartItems.map((item, i) => (
                  <motion.div
                    key={item.id}
                    layout
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, x: -50, height: 0 }}
                    transition={{ delay: i * 0.04 }}
                    className={`flex items-center gap-3 p-4 ${i < cartItems.length - 1 ? 'border-b border-gray-50' : ''}`}
                  >
                    <img
                      src={item.image || `https://picsum.photos/80/80?random=${item.id}`}
                      alt={item.name}
                      className="w-16 h-16 rounded-xl object-cover flex-shrink-0"
                    />
                    <div className="flex-1 min-w-0">
                      <p className="text-xs text-gray-400 truncate">{item.brand}</p>
                      <p className="text-sm font-semibold text-gray-800 line-clamp-2 leading-snug">{item.name}</p>
                      <p className="text-sm font-bold text-primary mt-0.5">{(item.price * item.qty).toLocaleString()}원</p>
                    </div>
                    <div className="flex flex-col items-end gap-2">
                      <motion.button
                        onClick={() => removeFromCart(item.id)}
                        whileTap={{ scale: 0.85 }}
                        className="text-gray-300 hover:text-gray-500 transition-colors"
                      >
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                          <path d="M18 6L6 18M6 6l12 12"/>
                        </svg>
                      </motion.button>
                      <div className="flex items-center gap-2 bg-gray-100 rounded-full px-1 py-0.5">
                        <motion.button
                          onClick={() => updateCartQty(item.id, -1)}
                          whileTap={{ scale: 0.85 }}
                          className="w-6 h-6 flex items-center justify-center text-gray-600 font-bold text-lg rounded-full"
                        >
                          −
                        </motion.button>
                        <span className="text-sm font-bold text-gray-800 w-5 text-center">{item.qty}</span>
                        <motion.button
                          onClick={() => updateCartQty(item.id, 1)}
                          whileTap={{ scale: 0.85 }}
                          className="w-6 h-6 flex items-center justify-center text-primary font-bold text-lg rounded-full"
                        >
                          +
                        </motion.button>
                      </div>
                    </div>
                  </motion.div>
                ))}
              </AnimatePresence>
            </div>

            {/* Price summary */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
              className="bg-white rounded-2xl shadow-sm p-4 space-y-3"
            >
              <h3 className="font-bold text-gray-800 mb-1">결제 금액</h3>
              <div className="flex justify-between text-sm text-gray-600">
                <span>상품 금액</span>
                <span>{subtotal.toLocaleString()}원</span>
              </div>
              <div className="flex justify-between text-sm text-gray-600">
                <span>배송비</span>
                {deliveryFee === 0 ? (
                  <span className="text-primary font-medium">무료</span>
                ) : (
                  <span>{deliveryFee.toLocaleString()}원</span>
                )}
              </div>
              {subtotal > 0 && subtotal < FREE_DELIVERY_THRESHOLD && (
                <p className="text-xs text-blue-500 bg-blue-50 rounded-lg px-3 py-2">
                  {(FREE_DELIVERY_THRESHOLD - subtotal).toLocaleString()}원 더 담으면 무료배송!
                </p>
              )}
              <div className="border-t border-gray-100 pt-3 flex justify-between font-bold text-gray-900">
                <span>총 결제 금액</span>
                <span className="text-primary text-lg">{total.toLocaleString()}원</span>
              </div>
            </motion.div>
          </>
        )}
      </div>

      {/* Bottom checkout button */}
      {cartItems.length > 0 && (
        <div className="fixed bottom-16 left-1/2 -translate-x-1/2 w-[390px] bg-white border-t border-gray-100 p-4 z-40">
          <div className="relative">
            <button
              disabled
              className="w-full py-4 rounded-2xl bg-gray-200 text-gray-400 font-bold text-base cursor-not-allowed flex items-center justify-center gap-2"
            >
              <span>🔒</span> 결제하기 (준비중)
            </button>
          </div>
        </div>
      )}

      <BottomNav />
    </PageWrapper>
  )
}
