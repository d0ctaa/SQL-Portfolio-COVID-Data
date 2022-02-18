SELECT 	
	location, 
    date, 
    total_cases, 
    total_deaths,
	(total_deaths/total_cases)*100 as d_percentage
FROM cdata_d d
where location like '%africa%'
order by 1,2;

-- looking at total cases vs population
-- % of infected population

SELECT 	
	location, 
    date,
    population,
    total_cases, 
    total_deaths,
	(total_deaths/population)*100 as infected_percentage
FROM cdata_d d
-- where location like '%africa%'
order by 1,2;

-- countries with highest infection rate
SELECT 	
	location,
    population,
    MAX(total_cases) AS high_infection, 
	MAX((total_cases/population))*100 as infection_percentage
FROM cdata_d d
-- where location like '%togo%'
group by location, population
order by infection_percentage desc;

-- Countries with highest death count per population 
Select
	location,
    MAX(total_deaths) AS death_toll
From cdata_d d
where continent is not null
group by location
order by death_toll desc;

-- breakdown by continent

Select
	location,
    MAX(total_deaths) AS death_toll
From cdata_d d
where continent is not null
group by location
order by death_toll desc;

-- Looking at total population vs vaccinations
-- Use of Common Table Expression (CTE)
-- query for percentage of population vaccinated 

with popvax (continent, location, date, Population, new_vaccinations, SumVax) as 
(
select 
	d.continent,
    d.location,
    d.date,
    d.population,
    vax.new_vaccinations,
	SUM(vax.new_vaccinations) OVER (partition by d.location order by d.location, d.date) AS SumVax					
From cdata_d d
join cdata_Vax vax
	on d.location = vax.location
    and d.date = vax.date
where d.continent is not null ) 
select *, (sumvax/population)*100 as vaxpercent
from popvax;

-- creating views to store data for visualization
-- 1: view for infection rate. 

create view infectionRate as 
SELECT 	
	location,
    population,
    MAX(total_cases) AS high_infection, 
	MAX((total_cases/population))*100 as infection_percentage
FROM cdata_d d
group by location, population
order by infection_percentage desc;

-- 2: View for percentage of vaccinated population 

create view vaccinationRate as 
with popvax (continent, location, date, Population, new_vaccinations, SumVax) as 
(
select 
	d.continent,
    d.location,
    d.date,
    d.population,
    vax.new_vaccinations,
	SUM(vax.new_vaccinations) OVER (partition by d.location order by d.location, d.date) AS SumVax					
From cdata_d d
join cdata_Vax vax
	on d.location = vax.location
    and d.date = vax.date
where d.continent is not null ) 
select *, (sumvax/population)*100 as vaxpercent
from popvax;


