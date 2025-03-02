---> set Role Context
USE ROLE accountadmin;

---> set Warehouse Context
USE WAREHOUSE compute_wh;


-------------------------------------------------------------------------------------------
    -- Step 2: Create Database
        -- CREATE DATABASE: https://docs.snowflake.com/en/sql-reference/sql/create-database
-------------------------------------------------------------------------------------------

---> create the Database
CREATE OR REPLACE DATABASE w3school;


-------------------------------------------------------------------------------------------
    -- Step 3: Create Schema
        -- CREATE SCHEMA: https://docs.snowflake.com/en/sql-reference/sql/create-schema
-------------------------------------------------------------------------------------------

---> create the Schema
CREATE OR REPLACE SCHEMA  w3school.uat_schema;




---> Create the Microsoft Azure Storage Integration
    -- Configuring an Azure Container for Loading Data: https://docs.snowflake.com/en/user-guide/data-load-azure-config

CREATE  OR REPLACE  STORAGE INTEGRATION w3_stage
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'AZURE'
  AZURE_TENANT_ID = '47153547-8bc2-4d1b-abf8-4c32a2489569'
  ENABLED =  TRUE
  STORAGE_ALLOWED_LOCATIONS = ('azure://zkhan.blob.core.windows.net/my-container');

---> Describe our Integration
    -- DESCRIBE INTEGRATIONS: https://docs.snowflake.com/en/sql-reference/sql/desc-integration

DESCRIBE INTEGRATION w3_stage;


---> View our Storage Integrations
    -- SHOW INTEGRATIONS: https://docs.snowflake.com/en/sql-reference/sql/show-integrations

SHOW STORAGE INTEGRATIONS;


-------------------------------------------------------------------------------------------
    -- Step 6: Create Stage Objects
-------------------------------------------------------------------------------------------

    /*--
      A stage specifies where data files are stored (i.e. "staged") so that the data in the files
      can be loaded into a table.
    --*/
---> Create CSV file format
CREATE OR REPLACE FILE FORMAT my_csv_format
TYPE = 'CSV'
FIELD_DELIMITER = '.'
RECORD_DELIMITER = '\n'
SKIP_HEADER = 1;

---> Create the Microsoft Azure Stage
    -- Creating an Azure Stage: https://docs.snowflake.com/en/user-guide/data-load-azure-create-stage

CREATE OR REPLACE STAGE w3_stage
	URL = 'azure://zkhan.blob.core.windows.net/my-container'
	CREDENTIALS = ( AZURE_SAS_TOKEN = 'sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2026-02-20T02:32:08Z&st=2025-02-20T18:32:08Z&spr=https,http&sig=3fUBMGdC4CMUCPWuIpXdBR2kkqfLiOezjyoXk3J5Yvc%3D' )
	DIRECTORY = ( ENABLE = true);


---> View our Stages
    -- SHOW STAGES: https://docs.snowflake.com/en/sql-reference/sql/show-stages
SHOW STAGES;

-------------------------------------------------------------------------------------------
    -- Step 4: Create Table
        -- CREATE TABLE: https://docs.snowflake.com/en/sql-reference/sql/create-table
-------------------------------------------------------------------------------------------

---> -- Create the target_table
CREATE OR REPLACE TABLE  w3school.uat_schema.Categories
( CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(16777216),
  ContactName VARCHAR(16777216),
  Address VARCHAR(16777216),
  City VARCHAR(16777216),
  PostalCode VARCHAR(16777216),
  Country VARCHAR(16777216)
);


---> query the empty Table
SELECT * FROM w3school.uat_schema.Categories ;


---> -- Create the target_table
CREATE OR REPLACE TABLE  w3school.uat_schema.Customers
( CategoryID VARCHAR(16777216) PRIMARY KEY,
  CategoryName VARCHAR(16777216),
  Description VARCHAR(16777216)
);

---> query the empty Table
SELECT * FROM w3school.uat_schema.Customers;


---> -- Create the target_table
CREATE OR REPLACE TABLE  w3school.uat_schema.Employees
( EmployeeID INT PRIMARY KEY,
  LastName VARCHAR(16777216),
  FirstName VARCHAR(16777216),
  BirthDate VARCHAR(16777216),
  Photo VARCHAR(16777216),
  Notes VARCHAR(16777216)
);

---> query the empty Table
SELECT * FROM w3school.uat_schema.Employees;


---> -- Create the target_table
CREATE OR REPLACE TABLE  w3school.uat_schema.Shippers
( ShipperID INT PRIMARY KEY,
  ShipperName VARCHAR(16777216),
  Phone VARCHAR(16777216)
);

---> query the empty Table
SELECT * FROM w3school.uat_schema.Shippers;


---> -- Create the target_table
CREATE OR REPLACE TABLE  w3school.uat_schema.Suppliers
( SupplierID INT PRIMARY KEY,
  SupplierName VARCHAR(16777216),
  ContactName VARCHAR(16777216),
  Address VARCHAR(16777216),
  City VARCHAR(16777216),
  PostalCode VARCHAR(16777216),
  Country VARCHAR(16777216),
  Phone VARCHAR(16777216)
);

---> query the empty Table
SELECT * FROM w3school.uat_schema.Suppliers;

-------------------------------------------------------------------------------------------
    -- Step 7: Load Data from Stages
-------------------------------------------------------------------------------------------

---> Load data from the Azure Stage into the Table
    -- Copying Data from an Azure Stage: https://docs.snowflake.com/en/user-guide/data-load-azure-copy
    -- COPY INTO <table>: https://docs.snowflake.com/en/sql-reference/sql/copy-into-table
--LIST  @MYDB.my_schema.my_table_name;



COPY INTO "W3SCHOOL"."UAT_SCHEMA"."CATEGORIES"
FROM (
    SELECT $1, $2, $3, $4, $5, $6, $7
    FROM '@"W3SCHOOL"."UAT_SCHEMA"."W3_STAGE"'
)
FILES = ('Categories.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;


SELECT * FROM W3SCHOOL.UAT_SCHEMA.CATEGORIES;


COPY INTO "W3SCHOOL"."UAT_SCHEMA"."CUSTOMERS"
FROM (
    SELECT $1, $2, $3
    FROM '@"W3SCHOOL"."UAT_SCHEMA"."W3_STAGE"'
)
FILES = ('Customers.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;

SELECT * FROM W3SCHOOL.UAT_SCHEMA.CUSTOMERS;


COPY INTO "W3SCHOOL"."UAT_SCHEMA"."EMPLOYEES"
FROM (
    SELECT $1, $2, $3, $4, $5, $6
    FROM '@"W3SCHOOL"."UAT_SCHEMA"."W3_STAGE"'
)
FILES = ('Employees.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;

SELECT * FROM W3SCHOOL.UAT_SCHEMA.EMPLOYEES;


COPY INTO "W3SCHOOL"."UAT_SCHEMA"."SHIPPERS"
FROM (
    SELECT $1, $2, $3
    FROM '@"W3SCHOOL"."UAT_SCHEMA"."W3_STAGE"'
)
FILES = ('Shippers.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;

SELECT * FROM W3SCHOOL.UAT_SCHEMA.SHIPPERS;


COPY INTO "W3SCHOOL"."UAT_SCHEMA"."SUPPLIERS"
FROM (
    SELECT $1, $2, $3, $4, $5, $6, $7, $8
    FROM '@"W3SCHOOL"."UAT_SCHEMA"."W3_STAGE"'
)
FILES = ('Suppliers.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;

SELECT * FROM W3SCHOOL.UAT_SCHEMA.SUPPLIERS;


---> -- Create the target_table
CREATE OR REPLACE TABLE  w3school.uat_schema.Products
( ProductID  INT PRIMARY KEY,
  ProductName  VARCHAR(16777216),
  SupplierID  VARCHAR(16777216),
  CategoryID  VARCHAR(16777216),
  Unit  VARCHAR(16777216),
  Price  VARCHAR(16777216)
);


COPY INTO "W3SCHOOL"."UAT_SCHEMA"."PRODUCTS"
FROM (
    SELECT $1, $2, $3, $4, $5, $6,
    FROM '@"W3SCHOOL"."UAT_SCHEMA"."W3_STAGE"'
)
FILES = ('Products.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;

SELECT * FROM W3SCHOOL.UAT_SCHEMA.PRODUCTS;



---> -- Create the target_table
CREATE OR REPLACE TABLE  w3school.uat_schema.ORDERS
( OrderID  INT PRIMARY KEY,
  CustomerID VARCHAR(16777216),
  EmployeeID VARCHAR(16777216),
  OrderDate VARCHAR(16777216),
  ShipperID VARCHAR(16777216)
);


COPY INTO "W3SCHOOL"."UAT_SCHEMA"."ORDERS"
FROM (
    SELECT $1, $2, $3, $4, $5,
    FROM '@"W3SCHOOL"."UAT_SCHEMA"."W3_STAGE"'
)
FILES = ('Orders.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;

SELECT * FROM W3SCHOOL.UAT_SCHEMA.Orders;



---> -- Create the target_table
CREATE OR REPLACE TABLE  w3school.uat_schema.ORDERSDETAILS
( OrderDetailID	 INT PRIMARY KEY,
  OrderID VARCHAR(16777216),
  ProductID	VARCHAR(16777216),
  Quantity VARCHAR(16777216)
);


COPY INTO "W3SCHOOL"."UAT_SCHEMA"."ORDERSDETAILS"
FROM (
    SELECT $1, $2, $3, $4
    FROM '@"W3SCHOOL"."UAT_SCHEMA"."W3_STAGE"'
)
FILES = ('OrderDetails.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=ABORT_STATEMENT;

SELECT * FROM W3SCHOOL.UAT_SCHEMA.ORDERSDETAILS;


Select EMPLOYEES.FIRSTNAME as fname, CATEGORIES.CUSTOMERNAME as c_name from EMPLOYEES INNER JOIN CATEGORIES WHERE CATEGORIES.CUSTOMERID = EMPLOYEES.EMPLOYEEID;


Select FIRSTNAME, count(*) from EMPLOYEES group by FIRSTNAME having count(*) > 1;


