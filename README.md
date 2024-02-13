# Nashville Housing Data Cleaning

## Overview

This script is designed to clean and preprocess data in the NashvilleHousing table. It performs various operations, including extracting and converting dates, updating null values, splitting and standardizing address fields, and removing duplicate rows.

Certainly! You can provide a detailed explanation of what each section of the SQL script does in the README. Here's an example:

# Nashville Housing Data Cleaning Script

## Overview

This script is designed to clean and preprocess data in the NashvilleHousing table. It performs various operations, including extracting and converting dates, updating null values, splitting and standardizing address fields, and removing duplicate rows.

## SQL Script Explanation

1. **Extracting and Converting Dates:**
   - Extracts the SaleDate column and converts it to the Date format.
   - Updates the SaleDate column with the converted Date values.
   - Adds a new column, SaleDateConverted, to store the converted Date values.
   - Updates the new column with the converted Date values.

2. **Handling Null Values:**
   - Finds duplicate values based on ParcelID and updates NULL PropertyAddress values with corresponding duplicate values.

3. **Splitting Address Fields:**
   - Divides the PropertyAddress column into Address and City.
   - Updates new columns with separated Address and City values.

4. **Extracting Components from OwnerAddress:**
   - Extracts components (street address, city, state) from OwnerAddress and stores them in separate columns.

5. **Standardizing SoldASVacant Values:**
   - Standardizes SoldASVacant values to 'Yes' or 'No'.

6. **Removing Duplicate Rows:**
   - Removes duplicate rows based on specific columns using a Common Table Expression (CTE).

7. **Dropping Unused Columns:**
   - Drops unused columns, including OwnerAddress, TaxDistrict, PropertyAddress, and SaleDate.

## Notes

- Backup your data before running this script, as it modifies the existing table.
- Review the script and adapt it to your specific database structure and requirements.
