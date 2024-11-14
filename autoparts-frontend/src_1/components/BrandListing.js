// src/components/BrandListing.js
import React from 'react';
import { Link } from 'react-router-dom';
import '../styles/BrandListing.css';

function BrandListing({ brands }) {
    return (
        <div className="brand-listing">
            {brands.map((brand) => (
                <Link to={`/category/${brand.name}`} key={brand.name} className="brand-card">
                    <img src={brand.logo} alt={`${brand.name} logo`} />
                    <p>{brand.name}</p>
                </Link>
            ))}
        </div>
    );
}

export default BrandListing;
