
Select * from ..['Covid Deaths$']
where continent is not null
Order by 3,4
-- Sort Out UseFul Data   
select [location],[date],[total_cases],[new_cases],[total_deaths] from ['Covid Deaths$']
Order By 1,2

-- Total_Cases Vs Total_Deaths 
--Death Percentage Rate

Select location,date,total_cases,new_cases,total_deaths,(total_Deaths/total_cases) *100 as Deaths_Percentage     
from [dbo].['Covid Deaths$']
where location like '%Africa'
Order By 1,2 ASC
Select * from ['Covid Vaccination$']
-- Total Cases Vs Population
Select Continent,location,date,total_cases,(total_cases/population)* 100 as Population_Percentage
from ['Covid Vaccination$']
Order By 1,2 Asc    

-- Countries with the highest infection
Select Location,continent,max(Total_Cases) as HighestInfection,Max((total_deaths/Total_Cases))* 100 as Population_Percentage   
From ['Covid Deaths$'] 
Group By location,continent
Order By Population_Percentage Desc

----- Countries with the Lowest Infection
select Location,Continent,Min(Total_Cases) as LowestInfection,Min((Total_Deaths/Total_Cases))* 100 as LowestPopulation_Percentage
from ['Covid Deaths$']
Group By location,continent 
Order By LowestPopulation_Percentage Desc

Select * from ['Covid Deaths$']

-- Show Countries With Highest Death Count 
Select Location,Max(Total_Deaths) as TotalDeathsCount 
from ['Covid Deaths$']
Group By location
Order By location,TotalDeathsCount  Desc

-- TotalDeathsCounts By Continent
select continent,max(cast(Total_Deaths as int)) as TotalDeathsCount 
from ['Covid Deaths$']
Where continent is not null
Group By Continent
Order BY TotalDeathsCount Desc
			Select * from ['Covid Deaths$']

--Global Numbers By Dates 
Select Date, sum(New_cases) as NewCases,sum(cast(Total_Deaths as int)) as TotalDeathCount,sum(cast(new_Deaths as int)) /sum(New_cases) * 100 as DeathsPercentage
from ['Covid Deaths$']
where continent is not null
Group By date
Order By 1,2 Asc

-- Total NewCases,Deaths & Death_Percentage      
Select sum(new_cases) as Newcases,sum(cast(Total_Deaths as int)) as TotalDeaths,sum(cast(new_deaths as int))/sum(new_cases)* 100 as Death_Percentage
From ['Covid Deaths$']
where continent is  not null 
Order By 1,2 Asc


 --Total Population Vs TotalDeaths
/*Drop Table iF Exists #DeathsVsPopulation
Create Table #DeathsVsPopulation
(
continent Nvarchar(255),
Location Nvarchar(255),
Population Float,
Date Nvarchar(255),
RollingVaccinatedPeople numeric(18,3),
New_Deaths int
)
Insert Into  #DeathsVsPopulation*/


-- Using Temporary_Table CTE 
-- Finding Total Percentage Gdp_Per_Capita By Location
with DeathVsPop ( Continent,Location,Date,Gdp_Per_Capita,population)
as 
(
select a.Continent,a.Location,a.date,b.population,sum(cast(b.Gdp_Per_Capita as Float)) Over (Partition By a.Location
Order By a.Continent) as Total_Gdp_Per_Capita
from ['Covid Deaths$']a
Inner Join ['Covid Vaccination$']b on a.location=b.location
Where a.continent is not Null 
--Order By 2,3
)
Select *,(Gdp_Per_Capita/Population)*100 as Gdp_Per_Capita_Percentage
from DeathVsPop



--Option 2 
Drop Table If Exists  #Gdp_Per_CapitaPop 
Create Table #Gdp_Per_CapitaPop
(
Continent Varchar(255),
Location Nvarchar(255),
Date DateTime,
Population Float,
Gdp_per_Capita Float
)
Insert Into #Gdp_Per_CapitaPop
select a.Continent,a.Location,a.date,b.population,sum(cast(b.Gdp_Per_Capita as Float)) Over (Partition By a.Location
Order By a.Continent) as Total_Gdp_Per_Capita
from ['Covid Deaths$']a
Inner Join ['Covid Vaccination$']b on a.location=b.location
Where a.continent is not Null 
--Order By 2,3

Select *,(Gdp_Per_Capita/Population)*100 as Gdp_Per_Capita_Percentage
from #Gdp_Per_CapitaPop

-- Creating a view for existing Table /Option 3   
Create view Gdp_Per_CapitaPop as 
select a.Continent,a.Location,a.date,b.population,sum(cast(b.Gdp_Per_Capita as Float)) Over (Partition By a.Location
Order By a.Continent) as Total_Gdp_Per_Capita
from ['Covid Deaths$']a
Inner Join ['Covid Vaccination$']b on a.location=b.location
Where a.continent is not Null 
--Order By 2,3

Select * from [dbo].['Covid Vaccination$']

--Total Cases By Continents
 select sum(Total_cases) as TotalCases,Continent 
 from ['Covid Vaccination$']
 where continent is not Null
 Group By Continent  
 Order By 1 Desc

 -- Highest Deaths By  Location 
 Select Location,Max(Total_Deaths) as OverallDeaths
 from ['Covid Deaths$']
 where location is not null 
 Group By Location 
 Order By 2 Descs




