import { Routes, Route, Navigate } from 'react-router-dom';
import { AnimatePresence } from 'framer-motion';
import Splash from './pages/Splash';
import Onboarding from './pages/Onboarding';
import Login from './pages/Login';
import PetSetup from './pages/PetSetup';
import PetSetupComplete from './pages/PetSetupComplete';
import Home from './pages/Home';
import Diagnosis from './pages/Diagnosis';
import Shop from './pages/Shop';
import ProductDetail from './pages/ProductDetail';
import MyPage from './pages/MyPage';
import Cart from './pages/Cart';

export default function App() {
  return (
    <AnimatePresence mode="wait">
      <Routes>
        <Route path="/" element={<Navigate to="/splash" replace />} />
        <Route path="/splash" element={<Splash />} />
        <Route path="/onboarding" element={<Onboarding />} />
        <Route path="/login" element={<Login />} />
        <Route path="/pet-setup" element={<PetSetup />} />
        <Route path="/pet-setup/complete" element={<PetSetupComplete />} />
        <Route path="/home" element={<Home />} />
        <Route path="/diagnosis" element={<Diagnosis />} />
        <Route path="/shop" element={<Shop />} />
        <Route path="/shop/product/:id" element={<ProductDetail />} />
        <Route path="/shop/cart" element={<Cart />} />
        <Route path="/mypage" element={<MyPage />} />
      </Routes>
    </AnimatePresence>
  );
}
