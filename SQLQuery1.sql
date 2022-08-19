-- to open a particular dataset:
select * from dbo.['2018$'];

-- If we open multiple tables, all of them will open simultaneously:
select * from dbo.['2018$'];
select * from dbo.['2019$'];
select * from dbo.['2020$'];

-- Lets combine the data from 2018, 2019 and 2020 table into 1 dataset:
with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select * from hotels;

-- We want to analyse if the hotel revenue is growing by year. We dont have a revenue column.
-- But we have adr - average daily rate, and stays in week nights and stays in weekday nights.
-- Create a new column to indicate revenue, group by year and analyze



with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select 
arrival_date_year,
sum((stays_in_week_nights+stays_in_weekend_nights)*adr) as revenue
from hotels
group by arrival_date_year;

-- When we run the above query, we see that in 2018, the revenue is approx 4M, in 2019 its 20M and in 2020 it is 14M. Therefore, revenue is growing by year.

-- We also want to see the revenue growth by hotel type:
with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select 
arrival_date_year, hotel,
round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr), 0) as revenue
from hotels
group by arrival_date_year, hotel;

-- We also have some discounts applied in the market segment table as well as meal cost in meal table. Lets analyze by joining that table ot our hotels:

with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select * from hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join
dbo.meal_cost$
on meal_cost$.meal = hotels.meal

-- Now we have a combined table with revenue column as well as columns from market segment and meal table. Use the above query to Load the data into power bi







