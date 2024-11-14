-- Step 1: Connect to PostgreSQL as a superuser
\c postgres;

-- Step 2: Create Database
CREATE DATABASE autoparts_wiki;

-- Step 3: Create User
CREATE USER autopartswiki_user WITH PASSWORD '123';

-- Step 4: Grant Superuser Privileges to User on the autoparts_wiki database
GRANT ALL PRIVILEGES ON DATABASE autoparts_wiki TO autopartswiki_user;
ALTER USER autopartswiki_user WITH SUPERUSER;

-- Connect to the new database
\c autoparts_wiki;

-- Step 5: Create Tables and Define Relationships
-- Note: Make sure to connect to the `autoparts_wiki` database before running this section

-- Company Table
CREATE TABLE Company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    company_description TEXT
);

-- Brand Table
CREATE TABLE Brand (
    brand_id SERIAL PRIMARY KEY,
    company_id INT REFERENCES Company(company_id) ON DELETE CASCADE,
    brand_name VARCHAR(255) NOT NULL,
    brand_description TEXT
);

-- Car Category Table
CREATE TABLE CarCategory (
    car_category_id SERIAL PRIMARY KEY,
    brand_id INT REFERENCES Brand(brand_id) ON DELETE CASCADE,
    car_category_name VARCHAR(255) NOT NULL,
    car_category_description TEXT
);

-- Car Subcategory Table
CREATE TABLE CarSubcategory (
    car_subcategory_id SERIAL PRIMARY KEY,
    car_category_id INT REFERENCES CarCategory(car_category_id) ON DELETE CASCADE,
    car_subcategory_name VARCHAR(255) NOT NULL,
    car_subcategory_description TEXT
);

-- Car Table
CREATE TABLE Car (
    car_id SERIAL PRIMARY KEY,
    car_subcategory_id INT REFERENCES CarSubcategory(car_subcategory_id) ON DELETE CASCADE,
    car_name VARCHAR(255) NOT NULL,
    car_model VARCHAR(100),
    car_year INT,
    description TEXT,
    note TEXT,
    availability BOOLEAN,
    stock_forecast INT,
    weight DECIMAL(10, 2),
    transmission_model VARCHAR(50),
    fuel_induction VARCHAR(50),
    frame VARCHAR(50),
    gear_shift_type VARCHAR(50),
    engine_info TEXT,
    door_count INT,
    vehicle_grade VARCHAR(50),
    country_id INT,
    destination_region_id INT
);

-- Part Group Table
CREATE TABLE PartGroup (
    part_group_id SERIAL PRIMARY KEY,
    part_group_name VARCHAR(255) NOT NULL,
    part_group_description TEXT
);

-- Part Subgroup Table
CREATE TABLE PartSubgroup (
    part_subgroup_id SERIAL PRIMARY KEY,
    part_group_id INT REFERENCES PartGroup(part_group_id) ON DELETE CASCADE,
    part_subgroup_name VARCHAR(255) NOT NULL,
    part_subgroup_description TEXT
);

-- Part Category Table
CREATE TABLE PartCategory (
    part_category_id SERIAL PRIMARY KEY,
    part_subgroup_id INT REFERENCES PartSubgroup(part_subgroup_id) ON DELETE CASCADE,
    part_category_name VARCHAR(255) NOT NULL,
    part_category_description TEXT
);

-- Part Subcategory Table
CREATE TABLE PartSubcategory (
    part_subcategory_id SERIAL PRIMARY KEY,
    part_category_id INT REFERENCES PartCategory(part_category_id) ON DELETE CASCADE,
    part_subcategory_name VARCHAR(255) NOT NULL,
    part_subcategory_description TEXT
);

-- Part Table
CREATE TABLE Part (
    part_id SERIAL PRIMARY KEY,
    part_subcategory_id INT REFERENCES PartSubcategory(part_subcategory_id) ON DELETE CASCADE,
    part_name VARCHAR(255) NOT NULL,
    part_code VARCHAR(100) UNIQUE,
    short_name VARCHAR(50),
    part_description TEXT,
    part_note TEXT,
    price DECIMAL(10, 2),
    availability BOOLEAN,
    quantity_in_stock INT,
    compatibility_ids TEXT[],
    prod_image TEXT,
    brand_image TEXT,
    company_image TEXT,
    alternate_product_ids TEXT[],
    make VARCHAR(100),
    made_in VARCHAR(100),
    region VARCHAR(100)
);

-- Country Table
CREATE TABLE Country (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL
);

-- Destination Region Table
CREATE TABLE DestinationRegion (
    destination_region_id SERIAL PRIMARY KEY,
    destination_region_name VARCHAR(255) NOT NULL
);

-- Foreign Key Constraints for Car Table
ALTER TABLE Car
    ADD CONSTRAINT fk_country
    FOREIGN KEY (country_id) REFERENCES Country(country_id) ON DELETE SET NULL;

ALTER TABLE Car
    ADD CONSTRAINT fk_destination_region
    FOREIGN KEY (destination_region_id) REFERENCES DestinationRegion(destination_region_id) ON DELETE SET NULL;

-- Grant Permissions on All Tables to autopartswiki_user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO autopartswiki_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO autopartswiki_user;

-- Grant permissions to create additional objects (tables, indexes, etc.) to autopartswiki_user
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO autopartswiki_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO autopartswiki_user;

-- Verify setup
\dt+ -- List all tables to verify setup

