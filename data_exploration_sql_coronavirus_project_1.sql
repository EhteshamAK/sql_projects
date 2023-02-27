select * from covid_deaths
where continent is not null;

-- total cases vs total deaths
-- shows liklehood of dying if contract covid in your country

select location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 as infected_person_percentage 
from covid_deaths 
order by 1,2 desc;

-- show what percentage of population got covid

select location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 as infected_person_percentage 
from covid_deaths where location like '%states%'
order by 1,2 desc;


-- countries with highest infection rate as compared to population

select location,  population, max(total_cases) as highest_infection_count,
 MAX(total_cases/population) as percent_population_infected
from covid_deaths 
group by location, population
order by percent_population_infected desc;


-- showing countries with highest death count per population

select 
   location, MAX(total_deaths) as total_death_count
from
  covid_deaths
where continent is not null
group by 
   location
order by 
  total_death_count desc;

-- Lets break things down by continent

select continent, MAX(total_deaths ) as total_death_count from covid_deaths
where continent is not null
group by continent 
order by total_death_count desc;
  

-- Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From covid_deaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2;


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From covid_deaths dea
Join covid_vaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;

-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From covid_deaths dea
Join covid_vaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



