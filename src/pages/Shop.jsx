import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import useAppStore from '../store/useAppStore';
import BottomNav from '../components/BottomNav';
import PageWrapper from '../components/PageWrapper';
import ProductCard from '../components/ProductCard';
import Badge from '../components/Badge';
import { mockProducts } from '../data/mockData';

const categories = ['전체', '사료', '영양제', '간식', '위생', '배변', '장난감'];

export default function Shop() {
  const navigate = useNavigate();
  const { selectedCategory, setSelectedCategory, pets, activePetId, cartItems } =
    useAppStore();
  const pet = pets.find((p) => p.id === activePetId) || pets[0];
  const recommended = mockProducts.filter((p) => p.recommended);
  const filtered =
    selectedCategory === '전체'
      ? mockProducts
      : mockProducts.filter((p) => p.category === selectedCategory);

  return (
    <PageWrapper>
      {/* Header */}
      <div className="bg-gradient-to-b from-primary-deep to-primary pt-12 pb-5 px-4">
        <div className="flex items-center justify-between mb-1">
          <div>
            <p className="text-blue-200 text-sm">🛒 쇼핑</p>
            <h1 className="text-xl font-bold text-white">펫밀리 스토어</h1>
          </div>
          <motion.button
            onClick={() => navigate('/shop/cart')}
            whileTap={{ scale: 0.9 }}
            className="relative w-10 h-10 bg-white/20 rounded-full flex items-center justify-center"
          >
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2">
              <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 01-8 0"/>
            </svg>
            {cartItems.length > 0 && (
              <span className="absolute -top-1 -right-1 w-5 h-5 bg-red-500 rounded-full text-white text-xs font-bold flex items-center justify-center">
                {cartItems.reduce((sum, item) => sum + item.qty, 0)}
              </span>
            )}
          </motion.button>
        </div>
      </div>

      <div className="px-4 py-4 space-y-5">
        {/* Recommended for pet */}
        <div>
          <div className="flex items-center justify-between mb-3">
            <div>
              <h3 className="font-bold text-gray-800">
                {pet.name}를 위한 추천
              </h3>
              <p className="text-xs text-gray-500">
                {pet.allergy} 알러지 고려 · {pet.breed} 맞춤
              </p>
            </div>
            <Badge variant="blue">AI 추천</Badge>
          </div>
          <div className="flex gap-3 overflow-x-auto scrollbar-hide -mx-4 px-4">
            {recommended.map((p) => (
              <ProductCard key={p.id} product={p} size="small" />
            ))}
          </div>
        </div>

        {/* Category tabs */}
        <div>
          <div className="flex gap-2 overflow-x-auto scrollbar-hide -mx-4 px-4 pb-1">
            {categories.map((cat) => (
              <motion.button
                key={cat}
                onClick={() => setSelectedCategory(cat)}
                className={`flex-shrink-0 px-4 py-2 rounded-full text-sm font-semibold transition-all
                  ${
                    selectedCategory === cat
                      ? 'bg-primary text-white shadow-md shadow-blue-200'
                      : 'bg-white text-gray-500 border border-gray-200'
                  }`}
                whileTap={{ scale: 0.94 }}
              >
                {cat}
              </motion.button>
            ))}
          </div>
        </div>

        {/* Product grid */}
        <div>
          <div className="flex items-center justify-between mb-3">
            <p className="text-sm text-gray-600 font-medium">
              총 {filtered.length}개
            </p>
            <button className="text-xs text-gray-400 flex items-center gap-1">
              최신순 <span>▼</span>
            </button>
          </div>
          <motion.div
            className="grid grid-cols-2 gap-3"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.3 }}
          >
            {filtered.map((product, i) => (
              <motion.div
                key={product.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: i * 0.05 }}
              >
                <ProductCard product={product} />
              </motion.div>
            ))}
          </motion.div>
        </div>
      </div>

      <BottomNav />
    </PageWrapper>
  );
}
