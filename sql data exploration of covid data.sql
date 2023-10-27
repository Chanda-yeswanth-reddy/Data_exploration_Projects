SELECT * FROM portfolio ..CovidDeaths
where continent is not null
ORDER BY 3,4

SELECT Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as
 Deathpercent from portfolio
..CovidDeaths 
where location like '%states%'
order by 1,2


--Percentage of population who got covid
SELECT Location,date,total_cases,total_deaths,population ,(total_cases/population)*100 as
 Deathpercent from portfolio
..CovidDeaths 
where location like 'India'
order by 1,2

--counties with highest infection rate
SELECT Location,population ,max(total_cases) as Highestinfection_rate,max((total_cases/population))*100 as
 percentPopulation_infected from portfolio
..CovidDeaths 
where continent is not null
group by location,population
order by  percentPopulation_infected desc

--countries with high death count
SELECT Location,max(cast (total_deaths as int))as TotalDeathCount from portfolio..CovidDeaths 
where continent is not null
group by location
order by TotalDeathCount desc

--continent wise
SELECT continent,max(cast (total_deaths as int))as TotalDeathCount from portfolio..CovidDeaths 
where continent is not null
group by continent
order by TotalDeathCount desc

--Globaly
SELECT date,sum(new_cases) as total_Cases,sum(cast (new_deaths as int)) as total_deaths,sum(cast (new_deaths as int))/sum(new_cases)*100 as death_Percent
from portfolio..CovidDeaths 
where continent is not null
group by date
order by 1,2


select d.continent,d.location,d.date,d.population,v.new_vaccinations ,
sum(cast(v.new_vaccinations as int)) over (partition by d.location order by d.location,d.date) as peopleVaccinated from portfolio..CovidDeaths d
join portfolio..CovidVaccinations v on d.location=v.location and
d.date=v.date
where d.continent is not null
order by 2,3
