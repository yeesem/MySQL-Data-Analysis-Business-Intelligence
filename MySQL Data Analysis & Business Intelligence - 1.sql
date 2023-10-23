CREATE TABLE customers(
   customer_id INT AUTO_INCREMENT,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   email_address VARCHAR(255),
   number_of_complaints INT,
PRIMARY KEY(customer_id)
)

ALTER TABLE customers
ADD COLUMN gender ENUM('M','F') AFTER last_name;

INSERT INTO customers(first_name,last_name,gender,email_address,number_of_complaints)
VALUES('John','Mackinley','M','john.mckinley@365careers.com',0);

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

#Insert new row into the customers table
INSERT INTO customers(first_name,last_name,gender)
VALUES('Peter','Figaro','M')

#Show the table
SELECT * FROM customers;

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

DROP TABLE companies;

CREATE TABLE companies(
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarter_phone_number VARCHAR(255),
PRIMARY KEY(company_id),
UNIQUE KEY(headquarter_phone_number)
);

DROP TABLE companies;

CREATE TABLE companies(
    company_id INT AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    headquarters_phone_number VARCHAR(255),
PRIMARY KEY(company_id)
);

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NOT NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

INSERT INTO companies(headquarters_phone_number,company_name)
VALUES('011-5853 2973','Company A');

SELECT*FROM companies

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

/**/ #This is the syntax of comment
     -- Comment line