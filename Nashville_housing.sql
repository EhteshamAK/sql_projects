select * from sql_project.dbo.NashvilleHousing;


--delete column saleDate
alter table sql_project.dbo.NashvilleHousing
drop column SaleDate;

-- Break down the Owner Address Column into Street, City and State Column
alter table sql_project.dbo.NashvilleHousing
add Street varchar(30);

update   sql_project.dbo.NashvilleHousing
set Street =  SUBSTRING(OwnerAddress, 1, CHARINDEX(',',OwnerAddress)-1);

alter table sql_project.dbo.NashvilleHousing
add City varchar(30);

update   sql_project.dbo.NashvilleHousing
set City =  SUBSTRING(OwnerAddress, CHARINDEX(',',OwnerAddress)+ 1, len(OwnerAddress));

alter table sql_project.dbo.NashvilleHousing
add States varchar(70);

update sql_project.dbo.NashvilleHousing
set States = SUBSTRING(City, CHARINDEX(',',City)+1,len(City));

alter table NashvilleHousing
add Cities varchar(100);

update NashvilleHousing
set Cities = SUBSTRING(City, 1,CHARINDEX(',',City)-1)


--delete column OwnerAddress, City

alter table sql_project.dbo.NashvilleHousing
drop column OwnerAddress;

alter table sql_project.dbo.NashvilleHousing
drop column City;

--change column name of cities to city,  States to State, SaleDateConverted to SaleDate

sp_rename 'sql_project.dbo.NashvilleHousing.Cities','City';
--

sp_rename 'sql_project.dbo.NashvilleHousing.States','State';

--

sp_rename 'sql_project.dbo.NashvilleHousing.SaleDateConverted', 'SaleDate';

-- change y to Yes and N to No in soldAsVacant

-- check how many values are in No and Yes column
select SoldAsVacant, COUNT(SoldAsVacant)
from sql_project.dbo.NashvilleHousing
group by SoldAsVacant
order by 2;


--- update the y to yes and n to no
update sql_project.dbo.NashvilleHousing
set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes' 
                   When SoldAsVacant = 'N' Then 'No'
				   Else SoldAsVacant
				   End

select * from sql_project.dbo.NashvilleHousing;

--delete unused columns

alter table sql_project.dbo.NashvilleHousing
drop column TaxDistrict,PropertyAddress;

