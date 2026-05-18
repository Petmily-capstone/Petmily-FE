import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import useAppStore from '../store/useAppStore';
import BottomNav from '../components/BottomNav';
import PageWrapper from '../components/PageWrapper';
import { petFoodProducts } from '../data/petFoodProducts';

const CATEGORIES = ['전체', '사료', '영양제', '간식'];
const CATEGORY_EMOJI = { 사료: '🥩', 영양제: '💊', 간식: '🍖' };

const NO_IMAGE_BG = ['bg-blue-50', 'bg-emerald-50', 'bg-violet-50', 'bg-amber-50'];
const NO_IMAGE_EMOJI = { 사료: '🥩', 영양제: '💊', 간식: '🍖' };

function IngredientSection({ type, items }) {
  if (!items || items.length === 0) return null;
  const cfg = {
    good:    { label: '좋은 성분', bg: 'bg-emerald-50', text: 'text-emerald-700', border: 'border-emerald-200', dot: 'bg-emerald-400', icon: '✅' },
    caution: { label: '주의 성분', bg: 'bg-amber-50',   text: 'text-amber-700',   border: 'border-amber-200',   dot: 'bg-amber-400',   icon: '⚠️' },
    key:     { label: '기능성 성분', bg: 'bg-violet-50', text: 'text-violet-700',  border: 'border-violet-200',  dot: 'bg-violet-400',  icon: '💜' },
  }[type];
  return (
    <div className={`rounded-xl border ${cfg.border} ${cfg.bg} px-3 py-2.5`}>
      <p className={`text-[11px] font-bold ${cfg.text} mb-1.5 flex items-center gap-1`}>
        {cfg.icon} {cfg.label}
      </p>
      <div className="space-y-1">
        {items.map((item, i) => (
          <div key={i} className="flex items-start gap-1.5">
            <span className={`mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0 ${cfg.dot}`} />
            <p className={`text-xs ${cfg.text} leading-5`}>{item}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

function ProductDetailModal({ product, onClose, onAddCart, isInCart }) {
  const [qty, setQty] = useState(1);
  return (
    <motion.div
      className="fixed z-[60] flex items-end justify-center"
      style={{ top: 0, bottom: 0, width: '390px', left: '50%', transform: 'translateX(-50%)' }}
      initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
    >
      <motion.div className="absolute inset-0 bg-black/40" onClick={onClose} />
      <motion.div
        className="relative w-full bg-white rounded-t-3xl overflow-hidden flex flex-col"
        style={{ maxHeight: '92vh' }}
        initial={{ y: '100%' }} animate={{ y: 0 }} exit={{ y: '100%' }}
        transition={{ type: 'spring', damping: 30, stiffness: 300 }}
      >
        {/* 핸들 */}
        <div className="pt-3 pb-1 flex justify-center flex-shrink-0">
          <div className="w-10 h-1 bg-gray-300 rounded-full" />
        </div>

        {/* 스크롤 영역 */}
        <div className="flex-1 overflow-y-auto scrollbar-hide">
          {/* 이미지 */}
          <div className="w-full h-52 bg-gray-50 flex items-center justify-center overflow-hidden">
            {product.image ? (
              <img src={product.image} alt={product.name} className="h-full w-full object-contain" />
            ) : (
              <span className="text-6xl">{NO_IMAGE_EMOJI[product.category] || '📦'}</span>
            )}
          </div>

          {/* 기본 정보 */}
          <div className="px-5 pt-4 pb-3 border-b border-gray-100">
            <div className="flex items-center gap-2 mb-1">
              <span className="text-xs font-semibold text-primary bg-blue-50 px-2 py-0.5 rounded-full">
                {CATEGORY_EMOJI[product.category]} {product.category}
              </span>
              {product.subCategory && (
                <span className="text-xs text-gray-400">{product.subCategory}</span>
              )}
            </div>
            <p className="text-xs text-gray-400 mb-0.5">{product.brand}</p>
            <h2 className="text-base font-bold text-gray-900 leading-snug mb-2">{product.name}</h2>
            <p className="text-xl font-bold text-primary">{product.price?.toLocaleString()}원</p>
          </div>

          {/* 성분 분석 */}
          <div className="px-5 py-4 space-y-3">
            <h3 className="text-sm font-bold text-gray-800">성분 분석</h3>
            <IngredientSection type="good"    items={product.goodIngredients} />
            <IngredientSection type="caution" items={product.cautionIngredients} />
            <IngredientSection type="key"     items={product.keyIngredients} />
          </div>
          <div className="h-28" />
        </div>

        {/* 하단 고정: 수량 + 담기 */}
        <div className="flex-shrink-0 px-5 py-4 border-t border-gray-100 bg-white">
          <div className="flex items-center gap-3">
            <div className="flex items-center gap-2 bg-gray-100 rounded-full px-2 py-1.5">
              <button
                onClick={() => setQty(q => Math.max(1, q - 1))}
                className="w-7 h-7 flex items-center justify-center text-gray-600 font-bold text-lg"
              >−</button>
              <span className="text-sm font-bold w-5 text-center">{qty}</span>
              <button
                onClick={() => setQty(q => q + 1)}
                className="w-7 h-7 flex items-center justify-center text-primary font-bold text-lg"
              >+</button>
            </div>
            <motion.button
              onClick={() => { onAddCart(product, qty); onClose(); }}
              whileTap={{ scale: 0.97 }}
              className="flex-1 py-3.5 rounded-2xl bg-primary text-white font-bold text-sm shadow-lg shadow-blue-200 flex items-center justify-center gap-2"
            >
              🛒 장바구니 담기 · {(product.price * qty)?.toLocaleString()}원
            </motion.button>
          </div>
        </div>
      </motion.div>
    </motion.div>
  );
}

function ProductCard({ product, onClick, cartCount, recommended }) {
  const bgIdx = (product.id?.charCodeAt(product.id.length - 1) || 0) % NO_IMAGE_BG.length;

  return (
    <motion.div
      onClick={onClick}
      whileTap={{ scale: 0.97 }}
      className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden cursor-pointer"
    >
      {/* 이미지 */}
      <div className={`w-full h-36 flex items-center justify-center overflow-hidden relative ${product.image ? 'bg-gray-50' : NO_IMAGE_BG[bgIdx]}`}>
        {product.image ? (
          <img src={product.image} alt={product.name} className="w-full h-full object-contain" />
        ) : (
          <span className="text-5xl">{NO_IMAGE_EMOJI[product.category] || '📦'}</span>
        )}
        {recommended && (
          <span className="absolute top-2 right-2 text-[10px] bg-primary text-white px-1.5 py-0.5 rounded-full font-bold">AI추천</span>
        )}
        {cartCount > 0 && (
          <span className="absolute top-2 left-2 w-5 h-5 bg-primary text-white text-[10px] font-bold rounded-full flex items-center justify-center">
            {cartCount}
          </span>
        )}
      </div>

      {/* 텍스트 */}
      <div className="p-3">
        <div className="flex items-center gap-1 mb-1">
          <span className="text-[10px] font-semibold text-primary bg-blue-50 px-1.5 py-0.5 rounded-full">
            {CATEGORY_EMOJI[product.category]} {product.category}
          </span>
        </div>
        <p className="text-[11px] text-gray-400">{product.brand}</p>
        <p className="text-xs font-bold text-gray-900 leading-snug mt-0.5 mb-2 line-clamp-2">{product.name}</p>

        {product.goodIngredients?.[0] && (
          <div className="bg-emerald-50 rounded-lg px-2 py-1 mb-1.5">
            <p className="text-[10px] text-emerald-700 line-clamp-1">✅ {product.goodIngredients[0]}</p>
          </div>
        )}

        <div className="flex items-center justify-between mt-2">
          <p className="text-sm font-bold text-primary">{product.price?.toLocaleString()}원</p>
          <span className="text-[10px] text-gray-400">상세보기 →</span>
        </div>
      </div>
    </motion.div>
  );
}

export default function Shop() {
  const navigate = useNavigate();
  const { selectedCategory, setSelectedCategory, pets, activePetId, cartItems, addToCart, updateCartQty } = useAppStore();
  const pet = pets.find((p) => p.id === activePetId) || pets[0];
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [search, setSearch] = useState('');
  const [addedId, setAddedId] = useState(null);

  const petType = pet?.type || 'dog';
  const totalCartQty = cartItems.reduce((s, i) => s + i.qty, 0);

  const filtered = petFoodProducts.filter((p) => {
    if (p.petType !== petType) return false;
    if (selectedCategory !== '전체' && p.category !== selectedCategory) return false;
    if (search.trim()) {
      const q = search.trim().toLowerCase();
      return p.name.toLowerCase().includes(q) || p.brand.toLowerCase().includes(q);
    }
    return true;
  });

  // 좋은 성분 많고 주의 성분 짧은 순으로 상위 5개 추천
  const recommended = petFoodProducts
    .filter((p) => p.petType === petType)
    .sort((a, b) => {
      const scoreA = (a.goodIngredients?.length || 0) * 2 - (a.cautionIngredients?.join('').length || 0) / 20;
      const scoreB = (b.goodIngredients?.length || 0) * 2 - (b.cautionIngredients?.join('').length || 0) / 20;
      return scoreB - scoreA;
    })
    .slice(0, 5);
  const recommendedIds = new Set(recommended.map(p => p.id));

  const handleAddCart = (product, qty = 1) => {
    for (let i = 0; i < qty; i++) addToCart(product);
    setAddedId(product.id);
    setTimeout(() => setAddedId(null), 1500);
  };

  return (
    <>
      <AnimatePresence>
        {selectedProduct && (
          <ProductDetailModal
            product={selectedProduct}
            onClose={() => setSelectedProduct(null)}
            onAddCart={handleAddCart}
            isInCart={cartItems.some(c => c.id === selectedProduct.id)}
          />
        )}
      </AnimatePresence>

      <AnimatePresence>
        {addedId && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: 20 }}
            className="fixed bottom-24 left-1/2 -translate-x-1/2 z-50 bg-gray-900 text-white text-xs font-semibold px-4 py-2.5 rounded-full shadow-lg"
          >
            🛒 장바구니에 담았어요
          </motion.div>
        )}
      </AnimatePresence>

      <PageWrapper>
        {/* Header */}
        <div className="bg-gradient-to-b from-primary-deep to-primary pt-12 pb-5 px-4">
          <div className="flex items-center justify-between mb-3">
            <div>
              <p className="text-blue-200 text-sm">성분 분석 쇼핑</p>
              <h1 className="text-xl font-bold text-white">
                {petType === 'dog' ? '🐶' : '🐱'} {pet?.name}의 푸드 가이드
              </h1>
            </div>
            <motion.button
              onClick={() => navigate('/shop/cart')}
              whileTap={{ scale: 0.9 }}
              className="relative w-10 h-10 bg-white/20 rounded-full flex items-center justify-center"
            >
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2">
                <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/>
                <line x1="3" y1="6" x2="21" y2="6"/>
                <path d="M16 10a4 4 0 01-8 0"/>
              </svg>
              {totalCartQty > 0 && (
                <span className="absolute -top-1 -right-1 w-5 h-5 bg-red-500 rounded-full text-white text-[10px] font-bold flex items-center justify-center">
                  {totalCartQty}
                </span>
              )}
            </motion.button>
          </div>
          {/* 검색 */}
          <div className="bg-white/20 rounded-xl flex items-center gap-2 px-3 py-2.5">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2.5">
              <circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/>
            </svg>
            <input
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="브랜드, 제품명 검색"
              className="bg-transparent text-sm text-white placeholder-white/60 outline-none flex-1"
            />
          </div>
        </div>

        <div className="px-4 py-4 space-y-4">
          {/* 추천 섹션 */}
          {!search && selectedCategory === '전체' && (
            <div>
              <div className="flex items-center gap-2 mb-3">
                <span className="text-sm font-bold text-gray-800">AI 추천</span>
                <span className="text-xs text-primary bg-blue-50 px-2 py-0.5 rounded-full font-medium">좋은 성분 TOP 5</span>
              </div>
              <div className="flex gap-3 overflow-x-auto scrollbar-hide -mx-4 px-4">
                {recommended.map((product) => {
                  const cartCount = cartItems.find(c => c.id === product.id)?.qty || 0;
                  return (
                    <motion.div
                      key={product.id}
                      className="flex-shrink-0 w-36 bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden cursor-pointer"
                      whileTap={{ scale: 0.97 }}
                      onClick={() => setSelectedProduct(product)}
                    >
                      <div className="relative w-full h-28 bg-gray-50 flex items-center justify-center overflow-hidden">
                        {product.image ? (
                          <img src={product.image} alt={product.name} className="w-full h-full object-contain" />
                        ) : (
                          <span className="text-4xl">{NO_IMAGE_EMOJI[product.category]}</span>
                        )}
                        <span className="absolute top-1.5 right-1.5 text-[9px] bg-primary text-white px-1.5 py-0.5 rounded-full font-bold">AI추천</span>
                        {cartCount > 0 && (
                          <span className="absolute top-1.5 left-1.5 w-4 h-4 bg-primary text-white text-[9px] font-bold rounded-full flex items-center justify-center">{cartCount}</span>
                        )}
                      </div>
                      <div className="p-2.5">
                        <p className="text-[10px] text-gray-400">{product.brand}</p>
                        <p className="text-xs font-bold text-gray-900 line-clamp-2 leading-snug mt-0.5">{product.name}</p>
                        <p className="text-xs font-bold text-primary mt-1">{product.price?.toLocaleString()}원</p>
                      </div>
                    </motion.div>
                  );
                })}
                <div className="flex-shrink-0 w-2" />
              </div>
            </div>
          )}

          {/* 카테고리 탭 */}
          <div className="flex gap-2 overflow-x-auto scrollbar-hide -mx-4 px-4">
            {CATEGORIES.map((cat) => (
              <motion.button
                key={cat}
                onClick={() => setSelectedCategory(cat)}
                className={`flex-shrink-0 px-4 py-2 rounded-full text-sm font-semibold transition-all ${
                  selectedCategory === cat
                    ? 'bg-primary text-white shadow-md shadow-blue-200'
                    : 'bg-white text-gray-500 border border-gray-200'
                }`}
                whileTap={{ scale: 0.94 }}
              >
                {cat === '전체' ? '전체' : `${CATEGORY_EMOJI[cat]} ${cat}`}
              </motion.button>
            ))}
          </div>

          <p className="text-xs text-gray-400">
            {petType === 'dog' ? '🐶 강아지' : '🐱 고양이'} 제품 {filtered.length}개
          </p>

          {/* 제품 그리드 */}
          <div className="grid grid-cols-2 gap-3">
            {filtered.map((product, i) => {
              const cartCount = cartItems.find(c => c.id === product.id)?.qty || 0;
              return (
                <motion.div
                  key={product.id}
                  initial={{ opacity: 0, y: 16 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: i * 0.02 }}
                >
                  <ProductCard
                    product={product}
                    cartCount={cartCount}
                    recommended={recommendedIds.has(product.id)}
                    onClick={() => setSelectedProduct(product)}
                  />
                </motion.div>
              );
            })}
          </div>
        </div>

        <BottomNav />
      </PageWrapper>
    </>
  );
}
