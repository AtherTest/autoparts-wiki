import React, { useState } from 'react';
import Header from '../components/Header';
import Footer from '../components/Footer';
import Sidebar from '../components/Sidebar';
import ProductCard from '../components/ProductCard';
import SearchBar from '../components/SearchBar';
import CarouselSlider from '../components/CarouselSlider';
// import './HomePage.css';

const HomePage = () => {
  const [products, setProducts] = useState([
    { name: 'Product 1', price: '$10', image: '/images/product1.jpg' },
    { name: 'Product 2', price: '$20', image: '/images/product2.jpg' },
    { name: 'Product 3', price: '$30', image: '/images/product3.jpg' },
  ]);

  const handleSearch = (query) => {
    console.log('Search:', query);
  };

  return (
    <div>
      <Header />
      <SearchBar onSearch={handleSearch} />
      <CarouselSlider images={['/images/slide1.jpg', '/images/slide2.jpg']} />
      <div className="main-content">
        <Sidebar />
        <div className="product-list">
          {products.map((product, idx) => (
            <ProductCard key={idx} product={product} />
          ))}
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default HomePage;
