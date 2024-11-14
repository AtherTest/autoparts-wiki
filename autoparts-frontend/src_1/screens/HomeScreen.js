// src/screens/HomeScreen.js
import React from 'react';
import Search from '../components/Search';
import Filter from '../components/Filter';
import BrandListing from '../components/BrandListing';
import { brands } from '../data/brands';

function HomeScreen() {
    const dimensions = ["Year", "Make", "Model", "Engine", "Brand"];

    const handleFilterApply = (dimension, value) => {
        console.log("Filter applied:", dimension, value);
    };

    const handleSearch = (searchTerm) => {
        console.log("Searching for:", searchTerm);
        // Implement search logic or navigate to relevant screen here
    };

    return (
        <div>
            <Search onSearch={handleSearch} />
            <Filter dimensions={dimensions} onFilterApply={handleFilterApply} />
            <BrandListing brands={brands} />
        </div>
    );
}

export default HomeScreen;
