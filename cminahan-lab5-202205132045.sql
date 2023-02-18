-- Lab 5
-- cminahan
-- May 13, 2022

USE `AIRLINES`;
-- AIRLINES-1
-- Find all airports with exactly 17 outgoing flights. Report airport code and the full name of the airport sorted in alphabetical order by the code.
select code, name 
from airports 
join flights on source = code
group by source having count(*) = 17
order by code;


USE `AIRLINES`;
-- AIRLINES-2
-- Find the number of airports from which airport ANP can be reached with exactly one transfer. Make sure to exclude ANP itself from the count. Report just the number.
select count(distinct f2.source)
from flights f1
join flights f2 on f1.source = f2.destination and f1.destination = 'ANP'
    and f2.source != 'ANP';


USE `AIRLINES`;
-- AIRLINES-3
-- Find the number of airports from which airport ATE can be reached with at most one transfer. Make sure to exclude ATE itself from the count. Report just the number.
select count(distinct f2.source)
from flights f1
join flights f2 on (f1.source = f2.destination and f1.destination = 'ATE'
    and f2.source != 'ATE') or (f2.destination = 'ATE');


USE `AIRLINES`;
-- AIRLINES-4
-- For each airline, report the total number of airports from which it has at least one outgoing flight. Report the full name of the airline and the number of airports computed. Report the results sorted by the number of airports in descending order. In case of tie, sort by airline name A-Z.
select name, count(distinct source) as Airports
from airlines
join flights on id = airline
group by name
order by Airports desc, name;


USE `BAKERY`;
-- BAKERY-1
-- For each flavor which is found in more than three types of items offered at the bakery, report the flavor, the average price (rounded to the nearest penny) of an item of this flavor, and the total number of different items of this flavor on the menu. Sort the output in ascending order by the average price.
select flavor, round(avg(price), 2) as AveragePrice, count(*)
from goods
group by flavor having count(*) > 3
order by AveragePrice;


USE `BAKERY`;
-- BAKERY-2
-- Find the total amount of money the bakery earned in October 2007 from selling eclairs. Report just the amount.
select sum(price) from items
join goods on GId = item
join receipts on Receipt = RNumber and Food = 'Eclair'
    and month(saledate) = 10;


USE `BAKERY`;
-- BAKERY-3
-- For each visit by NATACHA STENZ output the receipt number, sale date, total number of items purchased, and amount paid, rounded to the nearest penny. Sort by the amount paid, greatest to least.
select rnumber, saledate, count(*), round(sum(price), 2) as CheckAmount
from customers
join receipts on cid = customer and firstname = 'NATACHA' 
    and lastname = 'STENZ'
join items on rnumber = receipt
join goods on gid = item
group by rnumber, saledate
order by CheckAmount desc;


USE `BAKERY`;
-- BAKERY-4
-- For the week starting October 8, report the day of the week (Monday through Sunday), the date, total number of purchases (receipts), the total number of pastries purchased, and the overall daily revenue rounded to the nearest penny. Report results in chronological order.
select dayname(saledate) as Day, saledate, count(distinct receipt), count(*), 
    round(sum(price), 2)
from receipts
join items on receipt = rnumber 
    and saledate < '2007-10-15' and saledate > '2007-10-07'
join goods on gid = item
group by Day, saledate
order by saledate;


USE `BAKERY`;
-- BAKERY-5
-- Report all dates on which more than ten tarts were purchased, sorted in chronological order.
select saledate from receipts
join items on receipt = rnumber
join goods on gid = item and food = 'Tart'
group by saledate having count(*) > 10
order by saledate;


USE `CSU`;
-- CSU-1
-- For each campus that averaged more than $2,500 in fees between the years 2000 and 2005 (inclusive), report the campus name and total of fees for this six year period. Sort in ascending order by fee.
select distinct campus, sum(fee)
from campuses
join fees on campusid = id and fees.year between 2000 and 2005
group by campus having avg(fee) > 2500
order by sum(fee);


USE `CSU`;
-- CSU-2
-- For each campus for which data exists for more than 60 years, report the campus name along with the average, minimum and maximum enrollment (over all years). Sort your output by average enrollment.
select campus, avg(enrollments.enrolled), min(enrollments.enrolled),
    max(enrollments.enrolled)
from enrollments
join campuses on id = campusid
group by campus having count(enrollments.year) > 60
order by max(enrollments.enrolled);


USE `CSU`;
-- CSU-3
-- For each campus in LA and Orange counties report the campus name and total number of degrees granted between 1998 and 2002 (inclusive). Sort the output in descending order by the number of degrees.

select campus, sum(degrees)
from campuses
join degrees on campusid = id and (degrees.year between 1998 and 2002)
    and (county = 'Los Angeles' or county = 'Orange')
group by campus
order by sum(degrees) desc;


USE `CSU`;
-- CSU-4
-- For each campus that had more than 20,000 enrolled students in 2004, report the campus name and the number of disciplines for which the campus had non-zero graduate enrollment. Sort the output in alphabetical order by the name of the campus. (Exclude campuses that had no graduate enrollment at all.)
select campus, count(*)
from campuses
join enrollments on enrollments.campusid = id and enrolled > 20000
    and enrollments.year = 2004
join discEnr on discEnr.campusid = id and gr > 0
group by campus
order by campus;


USE `INN`;
-- INN-1
-- For each room, report the full room name, total revenue (number of nights times per-night rate), and the average revenue per stay. In this summary, include only those stays that began in the months of September, October and November of calendar year 2010. Sort output in descending order by total revenue. Output full room names.
select roomname, sum(rate*datediff(checkout, checkin)), 
    round(avg(rate*datediff(checkout, checkin)), 2)
from rooms
join reservations on roomcode = room and year(checkin) = 2010
    and month(checkin) between 9 and 11
    
group by roomname
order by sum(rate*datediff(checkout, checkin)) desc;


USE `INN`;
-- INN-2
-- Report the total number of reservations that began on Fridays, and the total revenue they brought in.
select count(*), sum(rate*datediff(checkout, checkin))
from rooms
join reservations on roomcode = room and dayname(checkin) = 'Friday';


USE `INN`;
-- INN-3
-- List each day of the week. For each day, compute the total number of reservations that began on that day, and the total revenue for these reservations. Report days of week as Monday, Tuesday, etc. Order days from Sunday to Saturday.
select dayname(checkin) as DAY, count(*), sum(rate*datediff(checkout, checkin))
from rooms
join reservations on roomcode = room
group by dayname(checkin)
order by field(DAY, 'Sunday', 'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday');


USE `INN`;
-- INN-4
-- For each room list full room name and report the highest markup against the base price and the largest markdown (discount). Report markups and markdowns as the signed difference between the base price and the rate. Sort output in descending order beginning with the largest markup. In case of identical markup/down sort by room name A-Z. Report full room names.
select roomname, max(rate - baseprice), min(rate - baseprice)
from rooms 
join reservations on roomcode = room
group by roomname 
order by max(rate - baseprice) desc, roomname;


USE `INN`;
-- INN-5
-- For each room report how many nights in calendar year 2010 the room was occupied. Report the room code, the full name of the room, and the number of occupied nights. Sort in descending order by occupied nights. (Note: this should be number of nights during 2010. Some reservations extend beyond December 31, 2010. The ”extra” nights in 2011 must be deducted).
select roomcode, roomname, sum(daysoccupied)
from (
    select roomcode, roomname, case
        when year(checkin) = 2009 and year(checkout) = 2011
            then 365
        when year(checkin) = 2010 and year(checkout) = 2010
            then datediff(checkout, checkin)
        when year(checkin) = 2010 and year(checkout) = 2011
            then datediff('2010-12-31', checkin)
    end as daysoccupied
    
    from reservations
    join rooms on room = roomcode
    where (year(checkin) <= 2010 and year(checkout) >=2011) 
        or (year(checkin) <= 2010 and year(checkout) >= 2010)
) as t1
group by roomcode, roomname
order by sum(daysoccupied) desc;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- For each performer, report first name and how many times she sang lead vocals on a song. Sort output in descending order by the number of leads. In case of tie, sort by performer first name (A-Z.)
select firstname, count(*)
from Band
join Vocals on bandmate = id and vocaltype = 'Lead'
group by firstname
order by count(*) desc, firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- Report how many different instruments each performer plays on songs from the album 'Le Pop'. Include performer's first name and the count of different instruments. Sort the output by the first name of the performers.
select firstname, count(distinct Instruments.instrument)
from Band
join Instruments on bandmate = id
join Tracklists on Tracklists.song = Instruments.song
join Albums on aid = album and title = 'Le Pop'
group by firstname
order by firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List each stage position along with the number of times Turid stood at each stage position when performing live. Sort output in ascending order of the number of times she performed in each position.

select distinct stageposition, count(*)
from Performance
join Band on bandmate = id and firstname = 'Turid'
group by stageposition
order by count(*);


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Report how many times each performer (other than Anne-Marit) played bass balalaika on the songs where Anne-Marit was positioned on the left side of the stage. List performer first name and a number for each performer. Sort output alphabetically by the name of the performer.

select firstname, count(*)
from (
    select distinct firstname, instrument, Performance.song
    from Performance
    join Instruments on Instruments.song = Performance.song
    join Band on id = Instruments.bandmate and firstname != 'Anne-Marit' and instrument = 'bass balalaika') as p1
    join (
    select Performance.song
    from Performance
    join Band on id = Performance.bandmate and stageposition = 'left' and firstname = 'Anne-Marit') as p2
    on p2.song = p1.song
group by firstname
order by firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Report all instruments (in alphabetical order) that were played by three or more people.
select distinct instrument
from Instruments
group by instrument having count(distinct bandmate) > 2
order by instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- For each performer, list first name and report the number of songs on which they played more than one instrument. Sort output in alphabetical order by first name of the performer
select firstname, count(*)
from Band
join (
    select bandmate from Instruments
    group by bandmate, song having count(instrument) > 1) as b1
    on id = bandmate
group by id 
order by firstname;


USE `MARATHON`;
-- MARATHON-1
-- List each age group and gender. For each combination, report total number of runners, the overall place of the best runner and the overall place of the slowest runner. Output result sorted by age group and sorted by gender (F followed by M) within each age group.
select agegroup, sex, count(*), min(place), max(place)
from marathon 
group by agegroup, sex
order by agegroup, sex;


USE `MARATHON`;
-- MARATHON-2
-- Report the total number of gender/age groups for which both the first and the second place runners (within the group) are from the same state.
select count(*)
from (
    select count(*) from marathon
    where groupplace = 1 or groupplace = 2
    group by state having count(*) > 1) as race;


USE `MARATHON`;
-- MARATHON-3
-- For each full minute, report the total number of runners whose pace was between that number of minutes and the next. In other words: how many runners ran the marathon at a pace between 5 and 6 mins, how many at a pace between 6 and 7 mins, and so on.
select minute(pace), count(*)
from marathon 
group by minute(pace);


USE `MARATHON`;
-- MARATHON-4
-- For each state with runners in the marathon, report the number of runners from the state who finished in top 10 in their gender-age group. If a state did not have runners in top 10, do not output information for that state. Report state code and the number of top 10 runners. Sort in descending order by the number of top 10 runners, then by state A-Z.
select distinct state, count(*) over(partition by state) as NumberOfTop10
from marathon where groupplace < 11
order by NumberOfTop10 desc;


USE `MARATHON`;
-- MARATHON-5
-- For each Connecticut town with 3 or more participants in the race, report the town name and average time of its runners in the race computed in seconds. Output the results sorted by the average time (lowest average time first).
select town, round(avg(time_to_sec(runtime)), 1)
from marathon
where state = 'CT'
group by town having count(*) > 2
order by round(avg(time_to_sec(runtime)), 2);


USE `STUDENTS`;
-- STUDENTS-1
-- Report the last and first names of teachers who have between seven and eight (inclusive) students in their classrooms. Sort output in alphabetical order by the teacher's last name.
select last, first
from teachers 
join list on teachers.classroom = list.classroom
group by last, first having count(*) between 7 and 8
order by last;


USE `STUDENTS`;
-- STUDENTS-2
-- For each grade, report the grade, the number of classrooms in which it is taught, and the total number of students in the grade. Sort the output by the number of classrooms in descending order, then by grade in ascending order.

select grade, count(distinct list.classroom), count(*)
from list
group by grade
order by count(distinct list.classroom) desc, grade;


USE `STUDENTS`;
-- STUDENTS-3
-- For each Kindergarten (grade 0) classroom, report classroom number along with the total number of students in the classroom. Sort output in the descending order by the number of students.
select classroom, count(*)
from list
where grade = 0
group by classroom 
order by count(*) desc;


USE `STUDENTS`;
-- STUDENTS-4
-- For each fourth grade classroom, report the classroom number and the last name of the student who appears last (alphabetically) on the class roster. Sort output by classroom.
select classroom, max(lastname)
from list
where grade = 4
group by classroom;


