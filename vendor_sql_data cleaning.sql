CREATE DATABASE vendor_performance_analysis;
USE vendor_performance_analysis;
#BEFORE CLEANING THE DATA TABLE purchases
#to see the table 
SELECT *
FROM purchases

#to see the total no.of rows
SELECT COUNT(*) AS total_rows
FROM purchases;

# to see the total no.of coln
SELECT COUNT(*) AS total_columns 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'vendor_performance_analysis'
AND TABLE_NAME = 'purchases';

#DATA CLEANING
#1. Check the NULL_VALUES
SELECT 
SUM(CASE WHEN InventoryId IS NULL THEN 1 ELSE 0 END)AS InventoryId_NULL,
SUM(CASE WHEN Store IS NULL THEN 1 ELSE 0 END) AS Store_NULL,
SUM(CASE WHEN Brand IS NULL THEN 1 ELSE 0 END) AS Brand_NULL,
SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS Description_NULL,
SUM(CASE WHEN Size IS NULL THEN 1 ELSE 0 END) AS Size_NULL,
SUM(CASE WHEN VendorNumber IS NULL THEN 1 ELSE 0 END) AS VendorNumber_NULL,
SUM(CASE WHEN VendorName IS NULL THEN 1 ELSE 0 END) AS VendorName_NULL,
SUM(CASE WHEN PONumber IS NULL THEN 1 ELSE 0 END) AS PONumber_NULL,
SUM(CASE WHEN PODate IS NULL THEN 1 ELSE 0 END) AS PODate_NULL,
SUM(CASE WHEN ReceivingDate IS NULL THEN 1 ELSE 0 END) AS ReceivingDate_NULL,
SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS InvoiceDate_NULL,
SUM(CASE WHEN PayDate IS NULL THEN 1 ELSE 0 END) AS PayDate_NULL,
SUM(CASE WHEN PurchasePrice IS NULL THEN 1 ELSE 0 END) AS PurchasePrice_NULL,
SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_NULL,
SUM(CASE WHEN Dollars IS NULL THEN 1 ELSE 0 END) AS Dollars_NULL,
SUM(CASE WHEN Classification IS NULL THEN 1 ELSE 0 END) AS Classification_NULL
FROM purchases;

#2. Check Blank or Empty_Values
SELECT
    SUM(CASE WHEN InventoryId = '' THEN 1 ELSE 0 END) AS InventoryId_blank,
    SUM(CASE WHEN Store = '' THEN 1 ELSE 0 END) AS Store_blank,
    SUM(CASE WHEN Brand = '' THEN 1 ELSE 0 END) AS Brand_blank,
    SUM(CASE WHEN Description = '' THEN 1 ELSE 0 END) AS Description_blank,
    SUM(CASE WHEN Size = '' THEN 1 ELSE 0 END) AS Size_blank,
    SUM(CASE WHEN VendorNumber = '' THEN 1 ELSE 0 END) AS VendorNumber_blank,
    SUM(CASE WHEN VendorName = '' THEN 1 ELSE 0 END) AS VendorName_blank,
    SUM(CASE WHEN PONumber = '' THEN 1 ELSE 0 END) AS PONumber_blank,
    SUM(CASE WHEN PODate = '' THEN 1 ELSE 0 END) AS PODate_blank,
    SUM(CASE WHEN ReceivingDate = '' THEN 1 ELSE 0 END) AS ReceivingDate_blank,
    SUM(CASE WHEN InvoiceDate = '' THEN 1 ELSE 0 END) AS InvoiceDate_blank,
    SUM(CASE WHEN PayDate = '' THEN 1 ELSE 0 END) AS PayDate_blank,
    SUM(CASE WHEN PurchasePrice = '' THEN 1 ELSE 0 END) AS PurchasePrice_blank,
    SUM(CASE WHEN Quantity = '' THEN 1 ELSE 0 END) AS Quantity_blank,
    SUM(CASE WHEN Dollars = '' THEN 1 ELSE 0 END) AS Dollars_blank,
    SUM(CASE WHEN Classification = '' THEN 1 ELSE 0 END) AS Classification_blank
FROM purchases;

#3. Check the DUPLICATE_ROWS
SELECT
    InventoryId,
    Store,
    Brand,
    Description,
    Size,
    VendorNumber,
    VendorName,
    PONumber,
    PODate,
    ReceivingDate,
    InvoiceDate,
    PayDate,
    PurchasePrice,
    Quantity,
    Dollars,
    Classification,
    COUNT(*) AS duplicate_count
FROM purchases
GROUP BY
    InventoryId,
    Store,
    Brand,
    Description,
    Size,
    VendorNumber,
    VendorName,
    PONumber,
    PODate,
    ReceivingDate,
    InvoiceDate,
    PayDate,
    PurchasePrice,
    Quantity,
    Dollars,
    Classification
HAVING COUNT(*) > 1;

#4. Data Type Cleaning
# To check the data type of ecah columns 
DESCRIBE purchases;

# Change the datatype
SELECT
    PODate,
    ReceivingDate,
    InvoiceDate,
    PayDate
FROM purchases;

ALTER TABLE purchases
    MODIFY PODate DATE,
    MODIFY ReceivingDate DATE,
    MODIFY InvoiceDate DATE,
    MODIFY PayDate DATE;

DESCRIBE purchases;

#5. Check the TRIM the extra space
UPDATE purchases
SET VendorName = TRIM(VendorName);

SELECT VendorName
FROM purchases;

#6. Text standardization
SELECT VendorName, COUNT(*) AS occurrence_count
FROM purchases
GROUP BY VendorName
ORDER BY VendorName;

#BEFORE CLEANING THE DATA TABLE begin_inventory
# Check the loaded data, total rows, and total columns in begin_inventory

SELECT *
FROM begin_inventory;

#total rows
SELECT COUNT(*) AS total_rows
FROM begin_inventory;

#total columns in begin_inventory
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'begin_inventory';

#1.Check NULL values in all columns of begin_inventory
SELECT
    SUM(InventoryId IS NULL) AS InventoryId_null,
    SUM(Store IS NULL) AS Store_null,
    SUM(City IS NULL) AS City_null,
    SUM(Brand IS NULL) AS Brand_null,
    SUM(Description IS NULL) AS Description_null,
    SUM(Size IS NULL) AS Size_null,
    SUM(onHand IS NULL) AS onHand_null,
    SUM(Price IS NULL) AS Price_null,
    SUM(startDate IS NULL) AS startDate_null
FROM begin_inventory;

#2.Check blank values in all text columns of begin_inventory
SELECT
    SUM(InventoryId = '') AS InventoryId_blank,
    SUM(City = '') AS City_blank,
    SUM(Description = '') AS Description_blank,
    SUM(Size = '') AS Size_blank
FROM begin_inventory;

#3.Check for completely duplicate rows in begin_inventory
SELECT
    InventoryId,
    Store,
    City,
    Brand,
    Description,
    Size,
    onHand,
    Price,
    startDate,
    COUNT(*) AS duplicate_count
FROM begin_inventory
GROUP BY
    InventoryId,
    Store,
    City,
    Brand,
    Description,
    Size,
    onHand,
    Price,
    startDate
HAVING COUNT(*) > 1;

#4.Check the current data types of all columns in begin_inventory
DESCRIBE begin_inventory;
# Change startDate from TEXT to DATE in begin_inventory
ALTER TABLE begin_inventory
MODIFY startDate DATE;

#5.Check for leading/trailing spaces in text columns of begin_inventory
SELECT
    SUM(InventoryId <> TRIM(InventoryId)) AS InventoryId_spaces,
    SUM(City <> TRIM(City)) AS City_spaces,
    SUM(Description <> TRIM(Description)) AS Description_spaces,
    SUM(Size <> TRIM(Size)) AS Size_spaces
FROM begin_inventory;

# Data cleaninging end_inventory
SELECT *
FROM end_inventory;

# Check total number of rows
SELECT COUNT(*) AS total_rows
FROM end_inventory;

# Check total number of columns
SELECT COUNT(*) AS total_columns 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'vendor_performance_analysis'
AND TABLE_NAME = 'end_inventory';

#1.Check NULL values in all columns
SELECT
    SUM(InventoryId IS NULL) AS InventoryId_null,
    SUM(Store IS NULL) AS Store_null,
    SUM(City IS NULL) AS City_null,
    SUM(Brand IS NULL) AS Brand_null,
    SUM(Description IS NULL) AS Description_null,
    SUM(Size IS NULL) AS Size_null,
    SUM(onHand IS NULL) AS onHand_null,
    SUM(Price IS NULL) AS Price_null,
    SUM(endDate IS NULL) AS endDate_null
FROM end_inventory;

#2.Check blank values in text columns
SELECT
    SUM(InventoryId = '') AS InventoryId_blank,
    SUM(City = '') AS City_blank,
    SUM(Description = '') AS Description_blank,
    SUM(Size = '') AS Size_blank
FROM end_inventory;

#3.Check duplicate rows
SELECT
    InventoryId,
    Store,
    City,
    Brand,
    Description,
    Size,
    onHand,
    Price,
    endDate,
    COUNT(*) AS duplicate_count
FROM end_inventory
GROUP BY
    InventoryId,
    Store,
    City,
    Brand,
    Description,
    Size,
    onHand,
    Price,
    endDate
HAVING COUNT(*) > 1;

#4.Check data types
DESCRIBE end_inventory;
# Change endDate from TEXT to DATE
ALTER TABLE end_inventory
MODIFY endDate DATE;

#5.Check leading and trailing spaces
SELECT
    SUM(InventoryId <> TRIM(InventoryId)) AS InventoryId_spaces,
    SUM(City <> TRIM(City)) AS City_spaces,
    SUM(Description <> TRIM(Description)) AS Description_spaces,
    SUM(Size <> TRIM(Size)) AS Size_spaces
FROM end_inventory;

# Data cleaninging with purchase_prices
# Check loaded data
SELECT *
FROM purchase_prices;

# Check total number of rows
SELECT COUNT(*) AS total_rows
FROM purchase_prices;

# Check total number of columns
SELECT COUNT(*) AS total_columns 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'vendor_performance_analysis'
AND TABLE_NAME = 'purchase_prices';

#1.Check NULL values in all columns
SELECT
    SUM(Brand IS NULL) AS Brand_null,
    SUM(Description IS NULL) AS Description_null,
    SUM(Price IS NULL) AS Price_null,
    SUM(Size IS NULL) AS Size_null,
    SUM(Volume IS NULL) AS Volume_null,
    SUM(Classification IS NULL) AS Classification_null,
    SUM(PurchasePrice IS NULL) AS PurchasePrice_null,
    SUM(VendorNumber IS NULL) AS VendorNumber_null,
    SUM(VendorName IS NULL) AS VendorName_null
FROM purchase_prices;

#2.Check blank values in text columns
SELECT
    SUM(Description = '') AS Description_blank,
    SUM(Size = '') AS Size_blank,
    SUM(VendorName = '') AS VendorName_blank
FROM purchase_prices;

#3.Check duplicate rows
SELECT
    Brand,
    Description,
    Price,
    Size,
    Volume,
    Classification,
    PurchasePrice,
    VendorNumber,
    VendorName,
    COUNT(*) AS duplicate_count
FROM purchase_prices
GROUP BY
    Brand,
    Description,
    Price,
    Size,
    Volume,
    Classification,
    PurchasePrice,
    VendorNumber,
    VendorName
HAVING COUNT(*) > 1;

#4.Check data types
DESCRIBE purchase_prices;

#5.Check leading and trailing spaces
SELECT
    SUM(Description <> TRIM(Description)) AS Description_spaces,
    SUM(Size <> TRIM(Size)) AS Size_spaces,
    SUM(VendorName <> TRIM(VendorName)) AS VendorName_spaces
FROM purchase_prices;

# Data Cleaning in sales
SELECT *
FROM sales;

# Check total number of rows
SELECT COUNT(*) AS total_rows
FROM sales;

# Check total number of columns
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'sales';

# Check column names and data types
DESCRIBE sales;

#1.Check NULL values in all columns
SELECT
    SUM(InventoryId IS NULL) AS InventoryId_null,
    SUM(Store IS NULL) AS Store_null,
    SUM(Brand IS NULL) AS Brand_null,
    SUM(Description IS NULL) AS Description_null,
    SUM(Size IS NULL) AS Size_null,
    SUM(SalesQuantity IS NULL) AS SalesQuantity_null,
    SUM(SalesDollars IS NULL) AS SalesDollars_null,
    SUM(SalesPrice IS NULL) AS SalesPrice_null,
    SUM(SalesDate IS NULL) AS SalesDate_null,
    SUM(Volume IS NULL) AS Volume_null,
    SUM(Classification IS NULL) AS Classification_null,
    SUM(ExciseTax IS NULL) AS ExciseTax_null,
    SUM(VendorNo IS NULL) AS VendorNo_null,
    SUM(VendorName IS NULL) AS VendorName_null
FROM sales;

#2.Check blank values in text columns
SELECT
    SUM(InventoryId = '') AS InventoryId_blank,
    SUM(Description = '') AS Description_blank,
    SUM(Size = '') AS Size_blank,
    SUM(VendorName = '') AS VendorName_blank
FROM sales;

#3.Check duplicate rows
SELECT
    InventoryId,
    Store,
    Brand,
    Description,
    Size,
    SalesQuantity,
    SalesDollars,
    SalesPrice,
    SalesDate,
    Volume,
    Classification,
    ExciseTax,
    VendorNo,
    VendorName,
    COUNT(*) AS duplicate_count
FROM sales
GROUP BY
    InventoryId,
    Store,
    Brand,
    Description,
    Size,
    SalesQuantity,
    SalesDollars,
    SalesPrice,
    SalesDate,
    Volume,
    Classification,
    ExciseTax,
    VendorNo,
    VendorName
HAVING COUNT(*) > 1;

#4.Check data types
DESCRIBE sales;
# Change SalesDate from TEXT to DATE
ALTER TABLE sales
MODIFY SalesDate DATE;

#5.Check leading and trailing spaces in text columns
SELECT
    SUM(InventoryId <> TRIM(InventoryId)) AS InventoryId_spaces,
    SUM(Description <> TRIM(Description)) AS Description_spaces,
    SUM(Size <> TRIM(Size)) AS Size_spaces,
    SUM(VendorName <> TRIM(VendorName)) AS VendorName_spaces
FROM sales;

# Remove trailing spaces from VendorName and verify the result
UPDATE sales
SET VendorName = RTRIM(VendorName);

SELECT
    SUM(LENGTH(VendorName) <> LENGTH(RTRIM(VendorName))) AS VendorName_spaces
FROM sales;

# Display all data from vendor_invoice
SELECT *
FROM vendor_invoice;

# Check total number of rows
SELECT COUNT(*) AS total_rows
FROM vendor_invoice;

# Check total number of columns
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'vendor_invoice';

#1.Check NULL values in all columns
SELECT
    SUM(VendorNumber IS NULL) AS VendorNumber_null,
    SUM(VendorName IS NULL) AS VendorName_null,
    SUM(InvoiceDate IS NULL) AS InvoiceDate_null,
    SUM(PONumber IS NULL) AS PONumber_null,
    SUM(PODate IS NULL) AS PODate_null,
    SUM(PayDate IS NULL) AS PayDate_null,
    SUM(Quantity IS NULL) AS Quantity_null,
    SUM(Dollars IS NULL) AS Dollars_null,
    SUM(Freight IS NULL) AS Freight_null
FROM vendor_invoice;

#2.Check blank values in text columns
SELECT
    SUM(InvoiceDate = '') AS InvoiceDate_blank
FROM vendor_invoice;

#3.Check duplicate rows
SELECT
    VendorNumber,
    VendorName,
    InvoiceDate,
    PONumber,
    PODate,
    PayDate,
    Quantity,
    Dollars,
    Freight,
    COUNT(*) AS duplicate_count
FROM vendor_invoice
GROUP BY
    VendorNumber,
    VendorName,
    InvoiceDate,
    PONumber,
    PODate,
    PayDate,
    Quantity,
    Dollars,
    Freight
HAVING COUNT(*) > 1;

#4.Check data types
DESCRIBE vendor_invoice;
# Change the three date columns from TEXT to DATE
SELECT DISTINCT
    PODate,
    PayDate,
    InvoiceDate
FROM vendor_invoice
ORDER BY PODate, PayDate, InvoiceDate;

#5.Check leading and trailing spaces
SELECT
    SUM(InvoiceDate <> TRIM(InvoiceDate)) AS InvoiceDate_spaces
FROM vendor_invoice;