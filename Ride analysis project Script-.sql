
                                               'ASSIGNMENT UBER RIDE INSIGHTS_NAVIGATING MOBILITY DATA'

select * from Passenger_table;
select * from rides_table;
select * from driver_table;


#What are & how many unique pickup locations are there in the dataset?

select count(distinct pickup_location)                       
from rides_table;

select distinct pickup_location,count(pickup_location) as pick
from rides_table
group by pickup_location
order by pickup_location asc ,pick asc;

#What is the total number of rides in the dataset?

select count(ride_id) from rides_table;

#Calculate the average ride duration.

select avg(ride_duration) from rides_table; 

#List the top 5 drivers based on their total earnings.

select driver_id, driver_name ,sum(earnings) as total_earnings
from driver_table
group by driver_id,driver_name 
order by total_earnings desc limit 5;

#Calculate the total number of rides for each payment method.

select payment_method ,count(*) as TOTAL_RIDES
from rides_table
group by payment_method
order by TOTAL_RIDES desc;

#Retrieve rides with a fare amount greater than 20.

select * from rides_table 
where fare_amount > 20;

#Identify the most common pickup location.

select pickup_location ,count(*) as rides
from rides_table
group by pickup_location 
order by rides limit 1;

#Calculate the average fare amount.

select avg(fare_amount) from rides_table 

#List the top 10 drivers with the highest average ratings.

select driver_id ,avg(rating) AVG_RATINGS 
from driver_table
group by driver_id 
order by AVG_RATINGS limit 10;

#Calculate the total earnings for all drivers.

select sum(earnings) from driver_table;

#How many rides were paid using the "Cash" payment method?

select payment_method ,count(ride_id) from rides_table
where payment_method = 'cash'
group by payment_method;

#Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.

select pickup_location ,count(*),avg(ride_distance) 
from rides_table 
where pickup_location = "dhanbad";

#Retrieve rides with a ride duration less than 10 minutes.

select *from rides_table
where ride_duration >10;

#List the passengers who have taken the most number of rides.

select passenger_id ,count(*) as COUNT_RIDES 
from rides_table
group by passenger_id
order by COUNT_RIDES limit 20;

#Calculate the total number of rides for each driver in descending order.

select driver_id ,count(*) as COUNT_RIDES 
from driver_table 
group by driver_id 
order by COUNT_RIDES desc;

#Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.

select distinct payment_method 
from rides_table 
where pickup_location = 'Gandhinagar';

#Calculate the average fare amount for rides with a ride distance greater than 10.

select round(avg(fare_amount))  
from rides_table 
where ride_distance >10;

#List the drivers in descending order accordinh to their total number of rides.

select driver_id,total_rides 
from driver_table   
order by total_rides desc;

#Calculate the percentage distribution of rides for each pickup location
 
select pickup_location ,count(*) as RIDE_COUNT, round(count(*)* 100.0 / (select count(*) from rides_table),2) as PERCENTAGE 
from rides_table 
group by pickup_location 
order by PERCENTAGE;

select round(count(distinct pickup_location)*100/count(pickup_location),2),
pickup_location from rides_table
group by pickup_location; 
















#Retrieve rides where both pickup and dropoff locations are the same.

select * from rides_table 
where pickup_location = dropoff_location;

#List the passengers who have taken rides from at least 300 different pickup locations.

select passenger_id ,count(distinct pickup_location) DISTINCT_PICKUPLOCATION 
from rides_table 
group by passenger_id 
having DISTINCT_PICKUPLOCATION >=300;

#Calculate the average fare amount for rides taken on weekdays.

select avg(fare_amount)
from rides_table
where dayofweek(ride_timestamp);


SELECT AVG(fare_amount)
FROM rides_table 
WHERE DAYOFWEEK(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i'))>5;


select ride_timestamp, (STR_TO_DATE(ride_timestamp)) from rides_table;

SELECT DATE_FORMAT("2017-06-15", "%M %d %Y");
SELECT DATE_FORMAT("2017-06-15", "%W %M %e %Y");

#Identify the drivers who have taken rides with distances greater than 19.

select distinct driver_id,ride_distance
from rides_table 
where ride_distance >19;

'Calculate the total earnings for drivers who have completed more than 100 rides'.

select distinct driver_id,driver_name ,sum(earnings) as TOTAL_EARNING 
from driver_table 
group by driver_id,driver_name
having driver_id >100;

# Retrieve rides where the fare amount is less than the average fare amount.

select ride_id,fare_amount from rides_table
where fare_amount < (select avg(fare_amount) from rides_table);



select * from rides_table 
where fare_amount < (select avg(fare_amount) from rides_table)

'Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods'.

select driver_id ,avg(rating) from driver_table
where driver_id in
(select driver_id from rides_table 
where payment_method in ('credit card','cash'))
group by driver_id;


select driver_id ,avg(rating) as AVG_RATING from driver_table 
where driver_id in (select driver_id from rides_table 
where payment_method in ('credit card','cash')
group by driver_id 
having count(distinct payment_method) =2)
group by driver_id;

'List the top 3 passengers with the highest total spending'.

select passenger_id,passenger_name,sum(total_spent) as COUNT_SPENT from passenger_table
group by passenger_id,passenger_name 
order by COUNT_SPENT desc 
limit 3;

select p.passenger_id,p.passenger_name ,round(sum(r.fare_amount),0) as TOTAL_SPENDING 
from passenger_table p
join rides_table r 
on p.passenger_id = r.passenger_id 
group by p.passenger_id,p.passenger_name 
order by TOTAL_SPENDING desc
limit 3;

'Calculate the average fare amount for rides taken during different months of the year'.

select distinct ride_timestamp,round(avg(fare_amount),0) 
from rides_table
group by ride_timestamp;

SELECT MONTH(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i')) AS month_of_year, AVG(fare_amount) 
FROM rides_table 
GROUP BY month_of_year;

#Identify the most common pair of pickup and dropoff locations.

SELECT pickup_location, dropoff_location, COUNT(*) AS ride_count
FROM rides_table
GROUP BY pickup_location, dropoff_location
order by ride_count desc 
limit 1;

#Calculate the total earnings for each driver and order them by earnings in descending order.

select driver_id ,sum(earnings) as total_earnings
from driver_table 
group by driver_id 
order by total_earnings desc;

#List the passengers who have taken rides on their signup date.

select p.passenger_id ,p.passenger_name 
from passenger_table p
join rides_table r
on p.passenger_id = r.passenger_id 
where p.signup_date = r.ride_timestamp; 

# Calculate the average earnings for each driver and order them by earnings in descending order.

select driver_id ,avg(earnings) as AVG_EARNINGS 
from driver_table
group by driver_id 
order by AVG_EARNINGS desc;

#Retrieve rides with distances less than the average ride distance.

select ride_id ,avg(ride_distance)  
from rides_table 
where ride_distance < (select avg(ride_distance) from rides_table) 
group by ride_id;

# List the drivers who have completed the least number of rides.

select driver_name ,count(driver_id) as COUNT_RIDE
from driver_table
group by driver_name 
order by COUNT_RIDE;

#Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.

select avg(fare_amount) 
from rides_table
where passenger_id in (select passenger_id 
from rides_table
group by passenger_id 
having count(*) >= 20);

#Identify the pickup location with the highest average fare amount. 

select pickup_location ,avg(fare_amount) as AVG_FAREAMOUNT
from rides_table
group by pickup_location 
order by AVG_FAREAMOUNT desc
limit 1;

#Calculate the average rating of drivers who completed at least 100 rides.

select * from driver_table dt 
 
select * from rides_table rt 

select * from passenger_table pt 


select avg(rating) as AVG_RATING
from driver_table
where driver_id in (select driver_id from rides_table group by driver_id 
having count(*) >=100); 

select d.driver_id,avg(rating) as AVG_RATING
from driver_table d
inner join rides_table r
on d.driver_id = r.ride_id 
group by d.driver_id
having avg(rating) <= 100;

#List the passengers who have taken rides from at least 5 different pickup locations.

select r.passenger_id,pickup_location 
from rides_table r
inner join passenger_table p
on r.passenger_id = p.passenger_id 
group by r.passenger_id,pickup_location
having count(*) >=5;


SELECT passenger_id,pickup_location, COUNT(DISTINCT pickup_location) AS distinct_locations
FROM rides_table 
GROUP BY passenger_id,pickup_location 
HAVING COUNT(DISTINCT pickup_location) >= 5;

SELECT passenger_id
FROM rides_table 
GROUP BY passenger_id
HAVING COUNT(DISTINCT pickup_location) >= 5

SELECT r.passenger_id
FROM rides_table r
WHERE r.passenger_id IN (
  SELECT r.passenger_id
  FROM passenger_table p
  GROUP BY r.passenger_id
  HAVING COUNT(DISTINCT r.pickup_location) >= 5);

SELECT r.*
FROM rides_table r
WHERE r.passenger_id IN (
  SELECT r.passenger_id
  FROM passenger_table p
  GROUP BY r.passenger_id
  HAVING COUNT(DISTINCT r.pickup_location) >= 5);

#Calculate the average fare amount for rides taken by passengers with ratings above 4.


select avg(fare_amount) from rides_table rt
where passenger_id in (select passenger_id from passenger_table pt where rating >4);  


SELECT AVG(r.fare_amount) AS average_fare
FROM rides_table r
JOIN passenger_table p ON r.passenger_id = p.passenger_id
WHERE p.rating > 4;


#Retrieve rides with the shortest ride duration in each pickup location.

select * from rides_table r where ride_id = 
(select ride_id, pickup_location, 
MIN(ride_duration) AS min_duration FROM rides_table r)
GROUP BY ride_id,pickup_location;


SELECT r1.* FROM rides_table r1 
inner join 
(select pickup_location, min(ride_duration) from rides_table r group by pickup_location)
r2 on r1.pickup_location = r2.pickup_location;

select ride_id, ride_duration, pickup_location from rides_table rt where ride_duration=
(select min(ride_duration) from rides_table);


select pickup_location, MIN(ride_duration) AS min_duration FROM rides_table  GROUP BY pickup_location;


#List the drivers who have driven rides in all pickup locations.

select driver_id from driver_table 
where driver_id not in (select distinct driver_id from rides_table 
where pickup_location not in (select distinct pickup_location from rides_table));

select distinct driver_id,pickup_location 
from rides_table 
where pickup_location in 
(select distinct pickup_location from rides_table);

SELECT d.*
FROM driver_table d 
WHERE d.driver_id IN (
  SELECT r.driver_id
  FROM rides_table r
  GROUP BY r.driver_id
  HAVING COUNT(DISTINCT r.pickup_location) = (SELECT COUNT(DISTINCT pickup_location) FROM rides_table r)
);
 


#Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.

select avg(fare_amount),ride_id from rides_table  
where passenger_id in (select passenger_id from passenger_table 
where total_spent >300)
group by ride_id;

# List the bottom 5 drivers based on their average earnings.

select driver_id,avg(earnings) as AVG_EARNINGS
from driver_table dt 
group by driver_id 
order by AVG_EARNINGS asc 
limit 5;

#Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.

select sum(fare_amount) from rides_table rt 
where passenger_id in (select passenger_id from rides_table 
group by passenger_id 
having count(distinct payment_method) >1);

# Retrieve rides where the fare amount is significantly above the average fare amount.

select ride_id,fare_amount from rides_table rt 
where fare_amount >(select avg(fare_amount) from rides_table rt2)
order by ride_id ,fare_amount desc;

select * from rides_table rt 
where fare_amount > (select avg(fare_amount) from rides_table rt2); 


#List the drivers who have completed rides on the same day they joined.

select d.driver_id,d.driver_name 
from driver_table d 
join rides_table r
on d.driver_id = r.driver_id 
where d.join_date = r.ride_timestamp
group by d.driver_id,d.driver_name 
having count(r.ride_id) >1; 

select d.driver_id,d.driver_name 
from driver_table d 
join rides_table r
on d.driver_id = r.driver_id 
where d.join_date = r.ride_timestamp

#Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.

select avg(fare_amount) from rides_table rt 
where passenger_id in (select passenger_id from rides_table 
group by passenger_id 
having count(distinct payment_method) >1);

#Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.


select pickup_location ,avg(fare_amount) as AVG_FAREAMOUNT
from rides_table 
group by pickup_location;
order by AVG_FAREAMOUNT desc
limit 1;


SELECT pickup_location, AVG(fare_amount) AS avg_fare,
       (AVG(fare_amount) - (SELECT AVG(fare_amount) from rides_table rt2)) * 100.0 / (SELECT AVG(fare_amount) FROM rides_table rt3) AS percentage_increase
FROM rides_table rt 
GROUP BY pickup_location
ORDER BY percentage_increase desc
LIMIT 1;

#Retrieve rides where the dropoff location is the same as the pickup location.

select distinct * from rides_table 
where pickup_location = dropoff_location;

#Calculate the average rating of drivers who have driven rides with varying pickup locations.

select avg(rating) from driver_table d  
where driver_id in (select distinct driver_id from rides_table r
group by driver_id 
having count(distinct pickup_location) >1);





select passenger_id, count(distinct pickup_location) from uber3 u 

group by passenger_id 

having count(distinct pickup_location)> 300;



select avg(fare_amount) from uber3 u 

where dayofweek(ride_timestamp)>5;



select driver_id, ride_distance from uber3 u 

where ride_distance > 19;



select sum(earnings), driver_name, driver_id from uber1_driver ud 

where driver_id in (select distinct driver_id from uber3)

group by driver_name, driver_id ;





select ride_id, avg(fare_amount), fare_amount from uber3 u 

group by ride_id, fare_amount 

having fare_amount<avg(fare_amount);



select * from uber3 u 

where fare_amount < (select avg(fare_amount) from uber3);





select driver_id, avg(rating), driver_name from uber1_driver ud 

where driver_id in (select driver_id from uber3 where payment_method in('cash', 'credit card') 

group by driver_id)

group by driver_id, driver_name;



select passenger_id, sum(fare_amount) total from uber3 u 

group by passenger_id

order by total

limit 3;



select avg(fare_amount), month(ride_timestamp) as Months from uber3

group by months;



select pickup_location, dropoff_location, count(ride_id) from uber3 u 

group by pickup_location, dropoff_location 

order by count(ride_id)  desc

limit 3;



select sum(earnings), driver_id from uber1_driver ud 

group by driver_id 

order by sum(earnings) desc; 



select u2.passenger_name,u2.signup_date, u3.ride_timestamp from uber2_passenger u2

join uber3 u3 on u2.passenger_id =u3.passenger_id 

where day(u2.signup_date) = day(u3.ride_timestamp);



select * from uber3 

where ride_distance < (select avg(ride_distance) from uber3);

select avg(ride_distance)

from uber3;



select count(ride_id), driver_id from uber3 

group by driver_id 

order by count(ride_id) asc

limit 10; 



select avg(fare_amount), passenger_id from uber3

where passenger_id in (select passenger_id from uber3

group by passenger_id 

having count(ride_id)>= 20)

group by passenger_id;

select count(ride_id), passenger_id from uber3

group by passenger_id 

having count(ride_id)> 20; 



select round(avg(fare_amount),2), pickup_location from uber3 u 

group by pickup_location 

order by avg(fare_amount) desc

limit 1;



select avg(rating), driver_id from uber1_driver ud 

where driver_id in (select driver_id from uber3 group by driver_id having count(ride_id)>=100)

group by driver_id;



select driver_id from uber3 group by driver_id having count(ride_id)>=100;

select distinct driver_id from uber3;



select passenger_id, count(distinct pickup_location) total_pickup from uber3 u 

group by passenger_id 

having total_pickup >= 5;



select avg(fare_amount), passenger_id from uber3 

where passenger_id in (select passenger_id from uber2_passenger up where rating > 4)

group by passenger_id;



select min(ride_duration), pickup_location from uber3 

group by pickup_location

having min(ride_duration);



#advance Level



#1



select count(distinct driver_id), pickup_location from uber3 u 

group by pickup_location;



select driver_id, count(distinct pickup_location) total_drive_loc from uber3 u 

group by driver_id 

having total_drive_loc =316 ;



 #2

select avg(fare_amount), driver_id from uber3 u

where fare_amount > 300

group by driver_id;



select distinct passenger_id from uber2_p up 

where total_spent >300;



#2-original

select distinct driver_id from uber3 

where passenger_id in (select distinct passenger_id from uber2_p up 

where total_spent >300);



#4

select sum(fare_amount), driver_id from uber3 u

where passenger_id in (select passenger_id from uber3 

group by passenger_id having count(payment_method)>1)

group by driver_id ;



select sum(fare_amount), driver_id from uber3 

group by driver_id ;





select passenger_id, count(payment_method) from uber3 

group by passenger_id 

having count(payment_method)>1;


















