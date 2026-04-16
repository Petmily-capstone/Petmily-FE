import { useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import useAppStore from '../store/useAppStore';
import Button from '../components/Button';
import Badge from '../components/Badge';
import { mockProducts } from '../data/mockData';

const tabs = ['성분 분석', '적합 대상', '리뷰'];

export default function ProductDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { wishlist, toggleWishlist, addToCart } = useAppStore();
  const product = mockProducts.find((p) => p.id === parseInt(id));
  const [activeTab, setActiveTab] = useState(0);
  const [added, setAdded] = useState(false);
  const isWished = wishlist.includes(product?.id);

  if (!product)
    return (
      <div className="p-8 text-center text-gray-400">상품을 찾을 수 없어요</div>
    );

  const handleAddToCart = () => {
    addToCart(product);
    setAdded(true);
    setTimeout(() => setAdded(false), 2000);
  };

  const discountPct =
    product.originalPrice > product.price
      ? Math.round((1 - product.price / product.originalPrice) * 100)
      : 0;

  return (
    <div className="min-h-screen bg-[#F0F7FF] pb-28">
      {/* Back button */}
      <div className="absolute top-12 left-4 z-10">
        <motion.button
          onClick={() => navigate(-1)}
          whileTap={{ scale: 0.9 }}
          className="w-10 h-10 bg-white rounded-full flex items-center justify-center shadow-md"
        >
          <svg
            width="20"
            height="20"
            viewBox="0 0 24 24"
            fill="none"
            stroke="#374151"
            strokeWidth="2.5"
          >
            <path d="M15 18l-6-6 6-6" />
          </svg>
        </motion.button>
      </div>

      {/* Product image */}
      <div className="relative bg-white">
        <img
          src={product.image || `https://picsum.photos/390/300?random=${product.id}`}
          alt={product.name}
          className="w-full h-72 object-cover"
        />
        {discountPct > 0 && (
          <div className="absolute top-4 right-4 bg-red-500 text-white text-sm font-bold px-3 py-1 rounded-full">
            {discountPct}% SALE
          </div>
        )}
        <motion.button
          onClick={() => toggleWishlist(product.id)}
          whileTap={{ scale: 0.8 }}
          className="absolute bottom-4 right-4 w-12 h-12 bg-white rounded-full flex items-center justify-center shadow-lg"
        >
          <motion.span
            className="text-2xl"
            animate={isWished ? { scale: [1, 1.4, 1] } : {}}
            transition={{ duration: 0.3 }}
          >
            {isWished ? '❤️' : '🤍'}
          </motion.span>
        </motion.button>
      </div>

      <div className="px-4 py-4 space-y-4">
        {/* Basic info */}
        <div className="bg-white rounded-2xl shadow-sm p-4">
          <div className="flex items-start justify-between mb-1">
            <p className="text-xs text-gray-400">{product.brand}</p>
            <Badge variant="blue">펫밀리 {product.petmilyScore}점</Badge>
          </div>
          <h1 className="text-lg font-bold text-gray-800 mb-2 leading-snug">
            {product.name}
          </h1>
          <div className="flex items-center gap-3 mb-3">
            <span className="text-2xl font-bold text-gray-900">
              {product.price.toLocaleString()}원
            </span>
            {discountPct > 0 && (
              <span className="text-base text-gray-400 line-through">
                {product.originalPrice.toLocaleString()}원
              </span>
            )}
          </div>
          <div className="flex items-center gap-3">
            <div className="flex items-center gap-1">
              {[...Array(5)].map((_, i) => (
                <svg
                  key={i}
                  width="14"
                  height="14"
                  viewBox="0 0 24 24"
                  fill={i < Math.floor(product.rating) ? '#FBBF24' : '#E5E7EB'}
                >
                  <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
                </svg>
              ))}
              <span className="text-sm font-semibold text-gray-700 ml-1">
                {product.rating}
              </span>
            </div>
            <span className="text-xs text-gray-400">
              리뷰 {product.reviewCount}개
            </span>
          </div>
        </div>

        {/* Tabs */}
        <div className="bg-white rounded-2xl shadow-sm overflow-hidden">
          <div className="flex border-b border-gray-100">
            {tabs.map((tab, i) => (
              <button
                key={tab}
                onClick={() => setActiveTab(i)}
                className={`flex-1 py-3.5 text-sm font-semibold transition-all ${
                  activeTab === i
                    ? 'text-primary border-b-2 border-primary'
                    : 'text-gray-400'
                }`}
              >
                {tab}
              </button>
            ))}
          </div>

          <AnimatePresence mode="wait">
            <motion.div
              key={activeTab}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.2 }}
              className="p-4"
            >
              {activeTab === 0 && (
                <div className="space-y-4">
                  <div>
                    <h4 className="text-sm font-bold text-green-600 mb-2 flex items-center gap-1.5">
                      <span className="w-2 h-2 rounded-full bg-green-500 inline-block" />
                      좋은 성분
                    </h4>
                    <div className="flex flex-wrap gap-2">
                      {product.goodIngredients.map((ing) => (
                        <span
                          key={ing}
                          className="bg-green-50 text-green-700 px-3 py-1 rounded-full text-xs font-medium border border-green-200"
                        >
                          ✓ {ing}
                        </span>
                      ))}
                    </div>
                  </div>
                  {product.cautionIngredients.length > 0 && (
                    <div>
                      <h4 className="text-sm font-bold text-orange-500 mb-2 flex items-center gap-1.5">
                        <span className="w-2 h-2 rounded-full bg-orange-400 inline-block" />
                        주의 성분
                      </h4>
                      <div className="flex flex-wrap gap-2">
                        {product.cautionIngredients.map((ing) => (
                          <span
                            key={ing}
                            className="bg-orange-50 text-orange-600 px-3 py-1 rounded-full text-xs font-medium border border-orange-200"
                          >
                            ⚠️ {ing}
                          </span>
                        ))}
                      </div>
                    </div>
                  )}
                  {product.functionalIngredients.length > 0 && (
                    <div>
                      <h4 className="text-sm font-bold text-blue-600 mb-2 flex items-center gap-1.5">
                        <span className="w-2 h-2 rounded-full bg-blue-500 inline-block" />
                        기능성 성분
                      </h4>
                      <div className="flex flex-wrap gap-2">
                        {product.functionalIngredients.map((ing) => (
                          <span
                            key={ing}
                            className="bg-blue-50 text-blue-600 px-3 py-1 rounded-full text-xs font-medium border border-blue-200"
                          >
                            💊 {ing}
                          </span>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              )}

              {activeTab === 1 && (
                <div className="space-y-3">
                  <div>
                    <h4 className="text-sm font-bold text-green-600 mb-2">
                      ✅ 적합 대상
                    </h4>
                    <div className="flex flex-wrap gap-2">
                      {product.suitable.map((s) => (
                        <Badge key={s} variant="green">
                          {s}
                        </Badge>
                      ))}
                    </div>
                  </div>
                  {product.unsuitable.length > 0 && (
                    <div>
                      <h4 className="text-sm font-bold text-red-500 mb-2">
                        ❌ 비적합 대상
                      </h4>
                      <div className="flex flex-wrap gap-2">
                        {product.unsuitable.map((s) => (
                          <Badge key={s} variant="red">
                            {s}
                          </Badge>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              )}

              {activeTab === 2 && (
                <div className="space-y-3">
                  {product.reviews.map((review, i) => (
                    <motion.div
                      key={i}
                      initial={{ opacity: 0, y: 10 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: i * 0.1 }}
                      className="bg-gray-50 rounded-xl p-3"
                    >
                      <div className="flex items-center justify-between mb-1.5">
                        <span className="font-semibold text-sm text-gray-800">
                          {review.user}
                        </span>
                        <div className="flex gap-0.5">
                          {[...Array(review.rating)].map((_, j) => (
                            <span key={j} className="text-yellow-400 text-xs">
                              ⭐
                            </span>
                          ))}
                        </div>
                      </div>
                      <p className="text-sm text-gray-600 leading-relaxed">
                        {review.content}
                      </p>
                      <p className="text-xs text-gray-400 mt-1">
                        {review.date}
                      </p>
                    </motion.div>
                  ))}
                </div>
              )}
            </motion.div>
          </AnimatePresence>
        </div>
      </div>

      {/* Bottom bar */}
      <div className="fixed bottom-0 left-1/2 -translate-x-1/2 w-[390px] bg-white border-t border-gray-100 p-4 z-50">
        <AnimatePresence mode="wait">
          {added ? (
            <motion.div
              key="added"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0 }}
              className="flex gap-2"
            >
              <div className="flex-1 py-4 bg-green-500 rounded-2xl flex items-center justify-center gap-2 text-white font-bold text-sm">
                <span>✅</span> 장바구니에 추가됨
              </div>
              <motion.button
                onClick={() => navigate('/shop/cart')}
                whileTap={{ scale: 0.96 }}
                className="flex-1 py-4 bg-primary rounded-2xl flex items-center justify-center gap-2 text-white font-bold text-sm"
              >
                장바구니 보기 →
              </motion.button>
            </motion.div>
          ) : (
            <motion.div
              key="buy"
              className="flex gap-3"
              initial={{ opacity: 1 }}
            >
              <Button
                onClick={() => toggleWishlist(product.id)}
                variant="secondary"
                className="w-14 h-14 rounded-2xl flex-shrink-0 p-0"
              >
                {isWished ? '❤️' : '🤍'}
              </Button>
              <Button onClick={handleAddToCart} size="lg" className="flex-1">
                🛒 구매하기
              </Button>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
}
