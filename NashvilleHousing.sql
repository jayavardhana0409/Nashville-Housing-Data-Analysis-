-- Extracting SaleDate and converting it to Date format
select saleDate, CONVERT(Date,SaleDate)
from NashvilleHousing;

-- Updating SaleDate column with the converted Date values
update NashvilleHousing
set SaleDate = CONVERT(Date,SaleDate);

-- Adding a new column SaleDateConverted to store the converted Date values
alter table NashvilleHousing
add SaleDateConverted Date;

-- Updating the new column with the converted Date values
update NashvilleHousing
set SaleDateConverted = CONVERT(Date,SaleDate);

-- Finding duplicate values based on ParcelID and updating NULL PropertyAddress values
select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress 
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
where a.PropertyAddress is Null;

-- Updating NULL PropertyAddress values with corresponding duplicate values
update a
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
where a.PropertyAddress is Null;

-- Dividing PropertyAddress into Address and City
alter table NashvilleHousing
add PropertyAddressUpdate nvarchar(255);

-- Updating new columns with separated Address and City values
update NashvilleHousing
set PropertyAddressUpdate = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1);

alter table NashvilleHousing
add PropertyAddressCity nvarchar(255);

update NashvilleHousing
set PropertyAddressCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress));

-- Extracting components from OwnerAddress and storing in separate columns
alter table NashvilleHousing
add OwnerStreetAdress nvarchar(255);

update NashvilleHousing
set OwnerStreetAdress = PARSENAME(REPLACE(OwnerAddress,',','.'),3);

alter table NashvilleHousing
add OwnerCity nvarchar(255);

update NashvilleHousing
set OwnerCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2);

alter table NashvilleHousing
add OwnerState nvarchar(255);

update NashvilleHousing
set OwnerState = PARSENAME(REPLACE(OwnerAddress,',','.'),1);

-- Standardizing SoldASVacant values
update NashvilleHousing
set SoldASVacant = case when SoldASVacant = 'Y' then 'Yes'
			when SoldASVacant = 'N' then 'No'
		else
			SoldASVacant
		end;

-- Removing duplicate rows based on certain columns
with RowNumCTE as (
    select *,
	    row_number() over (
	    partition by ParcelID,
				     PropertyAddress,
				     SalePrice,
				     SaleDate,
				     LegalReference
				     order by
				     UniqueID
				     ) row_num
    from NashvilleHousing
)
-- Selecting and deleting duplicate rows
delete from RowNumCTE
where row_num > 1;

-- Dropping unused columns
alter table NashvilleHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate;

select * from NashvilleHousing