-- 1: infected percentage of people by countries and continent
SELECT 
	location,
    max(population) as population,
	max(total_cases) as TotalCases,
	(max(total_cases)/max(population))*100 as InfectionRate
    #max(total_deaths)
FROM covdeath
where continent like '%Africa%'
group by location
order by infectionrate; 

-- View 1: 
create view InfRateAfrica as
SELECT 
	location,
    max(population) as population,
	max(total_cases) as TotalCases,
	(max(total_cases)/max(population))*100 as InfectionRate
    #max(total_deaths)
FROM covdeath
where continent like '%Africa%'
group by location
order by infectionrate; 

-- 2: Global case and death Numbers by Continent
Select 
	continent,
	max(total_cases) as TotalCases,
    max(total_deaths) as TotalDeath
    #Death percentage
from covdeath
where continent is not null
group by continent;

-- View 2
create view ContinentNumbers as 
Select 
	continent,
	max(total_cases) as TotalCases,
    max(total_deaths) as TotalDeath
    #Death percentage
from covdeath
where continent is not null
group by continent;

-- 3: Daily percentage of infected people
Select 
	location,
    date,
    population,
    total_cases,
    (total_Cases/population)*100 as InfectedPopPercentage
from covdeath
where location like "%states%";

-- View 3
create view infectedAmericans as
Select 
	location,
    date,
    population,
    total_cases,
    (total_Cases/population)*100 as InfectedPopPercentage
from covdeath
where location like "%states%";

-- 4: Mortality rate france
Select 
	location,
    date,
    population,
    total_cases,
    total_deaths,
    (total_deaths/population)*100 as DeathRate
from covdeath
where location like "%france%";

--  5: Global infection rates
Select 
	location,
	population,
    max(total_cases) as TotalCases,
    max((total_cases/population))*100 as GlobalInfectedPop
from covdeath
group by location,population
order by GlobalInfectedpop desc;

-- View 5
create view worldInfectionRates as 
Select 
	location,
	population,
    max(total_cases) as TotalCases,
    max((total_cases/population))*100 as GlobalInfectedPop
from covdeath
group by location,population
order by GlobalInfectedpop desc;


-- 6: Cumulative Death count by country 
Select 
	location,
    max(total_deaths) as DeathCount
from covdeath
where continent is not null 
group by location
order by DeathCount desc;

-- View 6
create view CountryCumulativeDeath as
Select 
	location,
    max(total_deaths) as DeathCount
from covdeath
where continent is not null 
group by location
order by DeathCount desc;

-- 7: Global case and death Numbers by Continent
Select 
	location,
	max(total_cases) as TotalCases,
    max(total_deaths) as TotalDeath
    #Death percentage
from covdeath
where continent is null 
group by location;

-- 8: Global cases, deaths and percentage of cases that didnt survive
select
	sum(new_cases)as GlobalCases,
    sum(new_deaths) as GlobalDeaths,
    (sum(new_deaths)/sum(new_cases))*100 as GlobalDeathPerc
from covdeath
where continent is not null;

-- View 8 

create view LivesLostPercentage as 

select
	sum(new_cases)as GlobalCases,
    sum(new_deaths) as GlobalDeaths,
    (sum(new_deaths)/sum(new_cases))*100 as GlobalDeathPerc
from covdeath
where continent is not null;









