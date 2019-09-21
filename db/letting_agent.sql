DROP TABLE rentals;
DROP TABLE properties;
DROP TABLE tenants;

CREATE TABLE properties
(
  id SERIAL8 PRIMARY KEY,
  prop_name VARCHAR(255),
  prop_no INT2,
  street_name VARCHAR(255) not null,
  town VARCHAR(255) not null,
  postcode VARCHAR(255) not null,
  prop_type VARCHAR(255) not null,
  bedrooms INT2,
  price_pcm INT2
);

CREATE TABLE tenants
(
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255) not null,
  last_name VARCHAR(255) not null,
  contact_no VARCHAR(11) not null,
  email VARCHAR(255) not null
);

CREATE TABLE rentals
(
  id SERIAL8 PRIMARY KEY,
  prop_id INT8 REFERENCES properties(id),
  tenant_id INT8 REFERENCES tenants(id)
);