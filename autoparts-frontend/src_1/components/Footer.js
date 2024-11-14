// src/components/Footer.js
import React from 'react';
import '../styles/Footer.css';

function Footer() {
    return (
        <footer className="footer">
            <p>&copy; 2024 Auto Parts Catalog</p>
            <nav>
                <a href="/about">About Us</a>
                <a href="/contact">Contact Us</a>
            </nav>
        </footer>
    );
}

export default Footer;
