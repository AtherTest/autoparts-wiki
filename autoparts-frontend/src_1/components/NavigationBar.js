// src/components/NavigationBar.js
import React from 'react';
import { Link } from 'react-router-dom';
import '../styles/NavigationBar.css';

function NavigationBar() {
    return (
        <header className="navbar">
            <Link to="/" className="navbar-brand">Auto Parts Catalog</Link>
            <nav>
                <Link to="/">Home</Link>
                <Link to="/about">About Us</Link>
                <Link to="/contact">Contact Us</Link>
            </nav>
        </header>
    );
}

export default NavigationBar;
