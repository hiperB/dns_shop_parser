drop database if exists dns_shop_parser;

CREATE DATABASE IF NOT EXISTS dns_shop_parser;

USE dns_shop_parser;

CREATE TABLE IF NOT EXISTS districts (
    id_district BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_district),
    name VARCHAR(1024) NOT NULL,
    data_district_id VARCHAR(1024) NOT NULL,
    date_add DATETIME NOT NULL,
    date_update DATETIME NOT NULL,
    is_exist BOOLEAN NOT NULL    
);

CREATE TABLE IF NOT EXISTS regions (
    id_region BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_region),
    name VARCHAR(1024) NOT NULL,
    data_region_id VARCHAR(1024) NOT NULL,
    date_add DATETIME NOT NULL,
    date_update DATETIME NOT NULL,
    is_exist BOOLEAN NOT NULL,    
    id_district BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_district) REFERENCES districts (id_district) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS cities (
    id_city BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_city),
    name VARCHAR(1024) NOT NULL,
    short_name VARCHAR(255) NOT NULL,
    data_city_id VARCHAR(1024) NOT NULL,
    date_add DATETIME NOT NULL,
    date_update DATETIME NOT NULL,
    is_exist BOOLEAN NOT NULL,    
    id_region BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_region) REFERENCES regions (id_region) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shops (
    id_shop BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_shop),
    address TEXT NOT NULL,
    description TEXT NOT NULL,    
    data_shop_id VARCHAR(1024) NOT NULL,
    date_add DATETIME NOT NULL,
    date_update DATETIME NOT NULL,
    is_exist BOOLEAN NOT NULL,    
    id_city BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_city) REFERENCES cities (id_city) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS categories (
    id_category BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_category),
    name VARCHAR(4096) NOT NULL,       
    data_category_id VARCHAR(1024) NOT NULL,
    parent_id_category BIGINT UNSIGNED,
    name_latin VARCHAR(4096), 
    date_add DATETIME NOT NULL,
    date_update DATETIME NOT NULL,
    is_exist BOOLEAN NOT NULL,    
);

CREATE TABLE IF NOT EXISTS products (
    id_product BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_product),
    name VARCHAR(4096) NOT NULL,
    vendor_code BIGINT UNSIGNED NOT NULL,
    brand VARCHAR(1024) NOT NULL,
    dot_status TINYINT UNSIGNED,
    href BLOB NOT NULL,
    completeness TEXT,
    appearance TEXT,
    form TEXT,
    price_old INT UNSIGNED,
    price INT UNSIGNED NOT NULL,
    profit INT UNSIGNED,
    percent_profit INT UNSIGNED,
    date_add DATETIME NOT NULL,
    date_update DATETIME NOT NULL,
    is_exist BOOLEAN NOT NULL,    
    id_city BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_city) REFERENCES cities (id_city) ON DELETE CASCADE
    id_category BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_category) REFERENCES categories (id_category) ON DELETE CASCADE
    id_shop BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_shop) REFERENCES shops (id_shop) ON DELETE CASCADE    
);

CREATE USER 'parser_dns_shop'@'%' IDENTIFIED BY 'rg1DKuUpDDBZExJDNMDtIowsI';
GRANT ALL PRIVILEGES ON dns_shop_parser.* TO 'parser_dns_shop'@'%';
FLUSH PRIVILEGES;