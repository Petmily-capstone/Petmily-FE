import { useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import useAppStore from '../store/useAppStore'
import BottomNav from '../components/BottomNav'
import PageWrapper from '../components/PageWrapper'
import Button from '../components/Button'
import Badge from '../components/Badge'
import ProductCard from '../components/ProductCard'
import { mockProducts } from '../data/mockData'

const categories = [
  { id: 'skin', label: '피부', emoji: '🌡️' },
  { id: 'digest', label: '소화', emoji: '🤢' },
  { id: 'breath', label: '호흡', emoji: '💨' },
  { id: 'eyes', label: '눈·귀', emoji: '👁️' },
  { id: 'behavior', label: '행동', emoji: '🐾' },
  { id: 'etc', label: '기타', emoji: '❓' },
]

const loadingSteps = ['증상 수집 중', '데이터 매칭 중', '결과 생성 중']

function LoadingScreen() {
  const [currentStep, setCurrentStep] = useState(0)

  useEffect(() => {
    const t1 = setTimeout(() => setCurrentStep(1), 1000)
    const t2 = setTimeout(() => setCurrentStep(2), 2000)
    return () => { clearTimeout(t1); clearTimeout(t2) }
  }, [])

  return (
    <div
      className="fixed inset-0 z-50 flex flex-col items-center justify-center"
      style={{ width: '390px', left: '50%', transform: 'translateX(-50%)', background: '#F0F7FF' }}
    >
      {/* 이퀄라이저 바 */}
      <div className="flex items-end gap-1.5 mb-10" style={{ height: 56 }}>
        {[0.6, 1, 0.75, 1, 0.5, 0.85, 0.4].map((scale, i) => (
          <motion.div
            key={i}
            className="w-3 rounded-full"
            style={{ backgroundColor: '#3B82F6', opacity: 0.3 + i * 0.07 }}
            animate={{ height: ['12px', `${44 * scale}px`, '12px'] }}
            transition={{ duration: 0.9, repeat: Infinity, delay: i * 0.1, ease: 'easeInOut' }}
          />
        ))}
      </div>

      {/* 텍스트 */}
      <p className="text-lg font-bold text-gray-800 mb-1">AI가 분석하고 있어요</p>
      <p className="text-sm text-gray-400 mb-10">잠시만 기다려주세요</p>

      {/* 스텝 */}
      <div className="w-60 space-y-3">
        {loadingSteps.map((label, i) => (
          <div key={label} className="flex items-center gap-3">
            <motion.div
              className="w-4 h-4 rounded-full flex-shrink-0 flex items-center justify-center"
              animate={{
                backgroundColor: currentStep > i ? '#3B82F6' : currentStep === i ? '#93C5FD' : '#E5E7EB',
              }}
              transition={{ duration: 0.3 }}
            >
              {currentStep > i && (
                <svg width="8" height="8" viewBox="0 0 10 8" fill="none">
                  <path d="M1 4l3 3 5-6" stroke="white" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
              )}
            </motion.div>
            <span className={`text-sm ${currentStep >= i ? 'text-gray-700 font-medium' : 'text-gray-300'}`}>
              {label}
            </span>
          </div>
        ))}
      </div>
    </div>
  )
}

function DiagnosisResult({ result }) {
  const navigate = useNavigate()
  const recommendedProducts = mockProducts.filter(p => p.recommended).slice(0, 3)

  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      className="space-y-4"
    >
      {/* Result summary */}
      <div className="bg-gradient-to-r from-primary to-primary-deep rounded-2xl p-5 text-white">
        <div className="flex items-center gap-2 mb-2">
          <span className="text-xl">🤖</span>
          <span className="text-sm font-medium text-blue-200">AI 진단 결과</span>
        </div>
        <h3 className="text-xl font-bold mb-1">{result.summary}</h3>
        <p className="text-blue-100 text-sm">분석 완료 · {new Date().toLocaleDateString('ko-KR')}</p>
      </div>

      {/* Disease possibility */}
      <div className="bg-white rounded-2xl shadow-sm p-4">
        <h4 className="font-bold text-gray-800 mb-3">의심 질환</h4>
        <div className="space-y-3">
          <div>
            <div className="flex items-center justify-between mb-1.5">
              <div className="flex items-center gap-2">
                <Badge variant="red">1순위</Badge>
                <span className="font-semibold text-gray-800 text-sm">{result.disease}</span>
              </div>
              <span className="text-lg font-bold text-red-500">{result.possibility}%</span>
            </div>
            <div className="w-full bg-gray-100 rounded-full h-2 overflow-hidden">
              <motion.div
                className="h-full bg-red-400 rounded-full"
                initial={{ width: 0 }}
                animate={{ width: `${result.possibility}%` }}
                transition={{ duration: 1, delay: 0.3 }}
              />
            </div>
          </div>
          <div>
            <div className="flex items-center justify-between mb-1.5">
              <div className="flex items-center gap-2">
                <Badge variant="yellow">2순위</Badge>
                <span className="font-semibold text-gray-800 text-sm">{result.secondaryDisease}</span>
              </div>
              <span className="text-lg font-bold text-yellow-500">{result.secondaryPossibility}%</span>
            </div>
            <div className="w-full bg-gray-100 rounded-full h-2 overflow-hidden">
              <motion.div
                className="h-full bg-yellow-400 rounded-full"
                initial={{ width: 0 }}
                animate={{ width: `${result.secondaryPossibility}%` }}
                transition={{ duration: 1, delay: 0.5 }}
              />
            </div>
          </div>
        </div>
      </div>

      {/* Hospital badge */}
      {result.hospitalRecommended && (
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.3 }}
          className="bg-red-50 border-2 border-red-200 rounded-2xl p-4 flex items-center gap-3"
        >
          <div className="w-10 h-10 bg-red-100 rounded-xl flex items-center justify-center flex-shrink-0">
            <span className="text-xl">🏥</span>
          </div>
          <div>
            <p className="font-bold text-red-700 text-sm">병원 방문 권장</p>
            <p className="text-red-500 text-xs">증상이 심각할 수 있으니 수의사 진료를 권장드려요</p>
          </div>
          <Badge variant="red" className="ml-auto flex-shrink-0">{result.urgency}</Badge>
        </motion.div>
      )}

      {/* Cautions */}
      <div className="bg-white rounded-2xl shadow-sm p-4">
        <h4 className="font-bold text-gray-800 mb-3">⚠️ 주의사항</h4>
        <div className="space-y-2">
          {result.cautions.map((caution, i) => (
            <motion.div
              key={i}
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: 0.1 * i }}
              className="flex items-start gap-2.5 bg-orange-50 rounded-xl p-3"
            >
              <span className="text-orange-400 mt-0.5 flex-shrink-0">⚡</span>
              <p className="text-sm text-gray-700">{caution}</p>
            </motion.div>
          ))}
        </div>
      </div>

      {/* Guide */}
      <div className="bg-white rounded-2xl shadow-sm p-4">
        <h4 className="font-bold text-gray-800 mb-3">📋 관리 가이드</h4>
        <p className="text-sm text-gray-600 leading-relaxed">{result.guide}</p>
      </div>

      {/* Recommended products */}
      <div>
        <div className="flex items-center justify-between mb-3">
          <h4 className="font-bold text-gray-800">🛒 추천 상품</h4>
          <button onClick={() => navigate('/shop')} className="text-xs text-primary font-medium">전체보기</button>
        </div>
        <div className="flex gap-3 overflow-x-auto scrollbar-hide -mx-4 px-4">
          {recommendedProducts.map(p => (
            <ProductCard key={p.id} product={p} size="small" />
          ))}
        </div>
      </div>
    </motion.div>
  )
}

export default function Diagnosis() {
  const {
    pets, activePetId,
    diagnosisCategory, diagnosisSymptom, diagnosisResult, isDiagnosing,
    setDiagnosisCategory, setDiagnosisSymptom, startDiagnosis, clearDiagnosis,
  } = useAppStore()
  const pet = pets.find(p => p.id === activePetId) || pets[0]
  const [selectedImage, setSelectedImage] = useState(null)
  const [imagePreviewUrl, setImagePreviewUrl] = useState('')
  const fileInputRef = useRef(null)

  useEffect(() => {
    if (!selectedImage) {
      setImagePreviewUrl('')
      return
    }

    const objectUrl = URL.createObjectURL(selectedImage)
    setImagePreviewUrl(objectUrl)

    return () => URL.revokeObjectURL(objectUrl)
  }, [selectedImage])

  const handleImageSelect = (event) => {
    const file = event.target.files?.[0]
    if (!file) return
    setSelectedImage(file)
  }

  const handleImageRemove = () => {
    setSelectedImage(null)
    if (fileInputRef.current) fileInputRef.current.value = ''
  }

  const canStart = diagnosisCategory || diagnosisSymptom.trim() || selectedImage

  return (
    <PageWrapper>
      {/* Loading overlay */}
      <AnimatePresence>
        {isDiagnosing && <LoadingScreen />}
      </AnimatePresence>

      {/* Header */}
      <div className="bg-gradient-to-b from-primary-deep to-primary pt-12 pb-6 px-4">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-blue-200 text-sm">🔬 AI 진단</p>
            <h1 className="text-xl font-bold text-white">증상 분석</h1>
          </div>
          {diagnosisResult && (
            <motion.button
              onClick={clearDiagnosis}
              whileTap={{ scale: 0.9 }}
              className="bg-white/20 px-3 py-1.5 rounded-full text-white text-xs font-medium"
            >
              새 진단
            </motion.button>
          )}
        </div>
      </div>

      <div className="px-4 py-5 space-y-4">
        {!diagnosisResult ? (
          <>
            {/* Category */}
            <div className="bg-white rounded-2xl shadow-sm p-4">
              <h3 className="font-bold text-gray-800 mb-3">증상 카테고리</h3>
              <div className="grid grid-cols-3 gap-2.5">
                {categories.map(cat => (
                  <motion.button
                    key={cat.id}
                    onClick={() => setDiagnosisCategory(cat.id === diagnosisCategory ? null : cat.id)}
                    className={`py-3 rounded-xl border-2 flex flex-col items-center gap-1 transition-all
                      ${diagnosisCategory === cat.id ? 'border-primary bg-blue-50' : 'border-gray-200 bg-gray-50'}`}
                    whileTap={{ scale: 0.94 }}
                  >
                    <span className="text-2xl">{cat.emoji}</span>
                    <span className={`text-xs font-semibold ${diagnosisCategory === cat.id ? 'text-primary' : 'text-gray-500'}`}>
                      {cat.label}
                    </span>
                  </motion.button>
                ))}
              </div>
            </div>

            {/* Symptom input */}
            <div className="bg-white rounded-2xl shadow-sm p-4">
              <h3 className="font-bold text-gray-800 mb-3">증상 설명</h3>
              <textarea
                value={diagnosisSymptom}
                onChange={(e) => setDiagnosisSymptom(e.target.value)}
                placeholder={`${pet.name}의 증상을 자세히 설명해주세요.\n예: 3일 전부터 뒷다리를 계속 긁어요. 붉은 반점이 생겼어요.`}
                rows={4}
                className="w-full text-sm text-gray-700 placeholder-gray-400 outline-none resize-none bg-gray-50 rounded-xl p-3"
              />
            </div>

            {/* Image upload */}
            <div className="bg-white rounded-2xl shadow-sm p-4">
              <h3 className="font-bold text-gray-800 mb-3">사진 첨부 (선택)</h3>
              <input
                ref={fileInputRef}
                type="file"
                accept="image/*"
                onChange={handleImageSelect}
                className="hidden"
              />
              <motion.button
                type="button"
                onClick={() => fileInputRef.current?.click()}
                className="w-full border-2 border-dashed border-gray-200 rounded-xl p-6 flex flex-col items-center gap-2 bg-gray-50"
                whileTap={{ scale: 0.98 }}
              >
                {imagePreviewUrl ? (
                  <>
                    <img
                      src={imagePreviewUrl}
                      alt="Selected"
                      className="w-full max-h-56 rounded-xl object-cover"
                    />
                    <div className="text-center">
                      <p className="text-sm font-medium text-gray-700">{selectedImage?.name}</p>
                      <p className="text-xs text-gray-400 mt-1">이 사진 영역을 다시 누르면 사진을 바꿀 수 있습니다.</p>
                    </div>
                  </>
                ) : (
                  <>
                    <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#3B82F6" strokeWidth="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                        <circle cx="8.5" cy="8.5" r="1.5"/>
                        <polyline points="21,15 16,10 5,21"/>
                      </svg>
                    </div>
                    <p className="text-sm font-medium text-gray-600">사진 추가</p>
                    <p className="text-xs text-gray-400">피부, 눈, 귀 등 증상 부위를 촬영해주세요</p>
                  </>
                )}
              </motion.button>
              {selectedImage && (
                <div className="mt-3 flex justify-end">
                  <button
                    type="button"
                    onClick={handleImageRemove}
                    className="text-xs font-medium text-red-500"
                  >
                    사진 제거
                  </button>
                </div>
              )}
            </div>

            {/* Start button */}
            <Button
              onClick={startDiagnosis}
              disabled={!canStart}
              size="lg"
              className="w-full"
            >
              🔬 진단 시작
            </Button>
          </>
        ) : (
          <DiagnosisResult result={diagnosisResult} />
        )}
      </div>

      <BottomNav />
    </PageWrapper>
  )
}
