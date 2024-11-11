import React from 'react';
import Slider from 'react-slick';
// import './CarouselSlider.css';

const CarouselSlider = ({ images }) => {
  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
    rtl: true, // Set this to true for RTL
  };

  return (
    <Slider {...settings}>
      {images.map((img, idx) => (
        <div key={idx}>
          <img src={img} alt={`Slide ${idx}`} />
        </div>
      ))}
    </Slider>
  );
};

export default CarouselSlider;
