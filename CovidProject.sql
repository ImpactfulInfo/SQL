Select *
From CovidProject.. CovidDeaths
Order By 3,4;


Select *
From CovidProject.. CovidVaccinations
Order By 3,4;


-- get percentages & do equations in Query

Select location, date, Total_cases, Total_deaths,  (Total_deaths/total_cases)*100 as DeathPercentage
From CovidProject.. CovidDeaths
 Order By 1,2;


--looking at total cases vs deaths
-- shows likelihood of dying in your country if you get covid

Select location, date, Total_cases, Total_deaths,  (Total_deaths/total_cases)*100 as DeathPercentage
From CovidProject.. CovidDeaths
where location like '%states%'
Order By 1,2;

--looking at total cases vs Pop

-- shows percentage of population with covid
Select location, date, Population, total_cases,  (total_cases/population)*100 as InfectionPercent
From CovidProject.. CovidDeaths
where location like '%states%'
Order By 1,2;



-- loooking at countries with the highest infection rate compared to population


Select location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as InfectionPercent
From CovidProject.. CovidDeaths
where location like '%states%'
group by location, population
Order By InfectionPercent desc;

--Showing Countries with the highest deathcount per population

Select location,population, Max(cast (total_deaths as int)) as TotalDeathCount
From CovidProject.. CovidDeaths
--where location like '%states%'
where continent is not null
group by location, population
Order By TotalDeathCount desc;
 
 -- Doing it by continent

 Select location, Max(cast (total_deaths as int)) as TotalDeathCount
From CovidProject.. CovidDeaths
--where location like '%states%'
where continent is null
group by location
Order By TotalDeathCount desc;

--

-- showing countries with the highest death count

Select location, Max(cast (total_deaths as int)) as TotalDeathCount
From CovidProject.. CovidDeaths
--where location like '%states%'
where continent is not null
group by location
Order By TotalDeathCount desc;
 
 --Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(Cast(new_deaths as int))/Sum(new_cases)*100
as rollingdeathpercent
from CovidProject..CovidDeaths
where continent is not null
--group by date
order by 1,2;


--- Joining Vaccination Table
--Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Cast(vac.new_vaccinations as int)) over (partition by dea.location order by        --Sum(convert(int,vac.new_vaccinations as int))
dea.location, dea.date) as RollingPeopleVacc
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null 
Order by 2,3;



--USE CTE for^

With PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVacc)
as (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Cast(vac.new_vaccinations as int)) over (partition by dea.location order by        --Sum(convert(int,vac.new_vaccinations as int))
dea.location, dea.date) as RollingPeopleVacc
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null 
--Order by 2,3
)
Select * , (RollingPeopleVacc/Population)*100
From PopvsVac;


-- creating Temp Table
Drop Table if exists #PercentPopulationVacc
create table #PercentPopulationVacc
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccination numeric,
RollingpeopleVacc Numeric
)

insert into #PercentPopulationVacc
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Cast(vac.new_vaccinations as int)) over (partition by dea.location order by        --Sum(convert(int,vac.new_vaccinations as int))
dea.location, dea.date) as RollingPeopleVacc
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null 
--Order by 2,3;


Select * , (RollingPeopleVacc/Population)*100 as RollingvaccPerc
From #PercentPopulationVacc;



--Creating View for later visualization

Create View PercentPopulationVacc as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Cast(vac.new_vaccinations as int)) over (partition by dea.location order by        --Sum(convert(int,vac.new_vaccinations as int))
dea.location, dea.date) as RollingPeopleVacc
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null 
--Order by 2,3;

Select * 
from PercentPopulationVacc;



-- 
