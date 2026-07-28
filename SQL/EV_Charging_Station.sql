use project;
select * from ev_charging_station;
select count(*) from ev_charging_station;

select count(*) as Total_Charging_Sessions from ev_charging_station;

select
sum(case when city is null then 1 else 0 end) as Missing_City,
sum(case when vehicle_type is null then 1 else 0 end) as Missing_Vehicle,
sum(case when payment_method is null then 1 else 0 end) as Missing_Payment
from ev_charging_station;

select station_id, count(*) from ev_charging_station
group by station_id having count(*)>1;


-- KPI's 

-- Total Revenue
select 
sum(cost_inr) as Total_Revenue from ev_charging_station;

-- Total Energy Consumed
select
round(sum(energy_consumed_kwh),2) as Total_Energy from ev_charging_station;

-- Average Charging Cost
select
round(avg(cost_inr),2) as Avg_Cost from ev_charging_station;

-- Average Energy Per Session
select
round(avg(energy_consumed_kwh),2) as Avg_Energy from ev_charging_station;

-- Revenue by City
select city,
sum(cost_inr) as Total_Revenue from ev_charging_station group by city order by Total_Revenue desc;

--  Charging Session by Vehicle Type
select vehicle_type,
count(*) as Charging_Sessions from ev_charging_station group by vehicle_type order by Charging_Sessions desc;

-- Revenue by Payment Method
select payment_method,
sum(cost_inr) as Total_Revenue from ev_charging_station group by payment_method order by Total_Revenue desc;

-- Energy Consumption by City
select city,
round(sum(energy_consumed_kwh),1) as Total_Energy from ev_charging_station group by city order by Total_Energy desc;

-- Charging sessions by Hour(Peak Hours)
select hour(charging_start_time) as Charging_hour,
count(*) as Charging_Sessions from ev_charging_station
group by Charging_Hour order by charging_hour;

-- Top 5 Revenue Generating Cities
select city,
sum(cost_inr) as Total_Revenue from ev_charging_station
group by city order by Total_Revenue desc limit 5;

-- Top 3 Highest Energy Consumption Cities
select city,
round(sum(energy_consumed_kwh),2) as Total_Energy from ev_charging_station
group by city order by Total_Energy desc limit 3;

-- City Revenue( with - CTE )
with CityRevenue as( select city,
sum(cost_inr) as Total_Revenue from ev_charging_station
group by city )
select * from CityRevenue where Total_Revenue > 25000; 

-- Complete Business Summery
select
count(*) as Total_Sessions,
sum(cost_inr) as total_Revenue,
round(sum(energy_consumed_kwh),2) as Total_Energy,
round(avg(cost_inr),2) as Avg_Cost,
round(avg(energy_consumed_kwh),2) as Avg_Energy
from ev_charging_station;
