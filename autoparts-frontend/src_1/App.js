// src/App.js
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import NavigationBar from './components/NavigationBar';
import Footer from './components/Footer';
import HomeScreen from './screens/HomeScreen';
import ProductScreen from './screens/ProductScreen';
import CategoryScreen from './screens/CategoryScreen';
import PartDetailScreen from './screens/PartDetailScreen';
import './App.css';

function App() {
    return (
        <Router>
            <div>
                <NavigationBar />
                <main className="container">
                    <Routes>
                        <Route path="/" element={<HomeScreen />} />
                        <Route path="/category/:brand" element={<CategoryScreen />} />
                        <Route path="/products/:car" element={<ProductScreen />} />
                        <Route path="/part/:id" element={<PartDetailScreen />} />
                    </Routes>
                </main>
                <Footer />
            </div>
        </Router>
    );
}

export default App;
