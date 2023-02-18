-- Lab 6
-- cminahan
-- May 25, 2022

USE `BAKERY`;
-- BAKERY-1
-- Find all customers who did not make a purchase between October 5 and October 11 (inclusive) of 2007. Output first and last name in alphabetical order by last name.
select firstname, lastname
from customers where firstname not in 
    (select firstname 
    from customers
    join receipts 
    on customer = cid
    where saledate >= '2007-10-05' and saledate <= '2007-10-11');


USE `BAKERY`;
-- BAKERY-2
-- Find the customer(s) who spent the most money at the bakery during October of 2007. Report first, last name and total amount spent (rounded to two decimal places). Sort by last name.
with moneySpent as 
    (select customer, firstname, lastname, sum(price) as priceitem
    from receipts
    join customers on cid = customer
    join items on receipt = rnumber
    join goods on gid = item
    where month(saledate) = 10 and year(saledate) = 2007
    group by customer
),
total as 
(select max(priceitem) as m from moneySpent)
    

select firstname, lastname, round(priceitem, 2)
from moneySpent
where priceitem = (select m from total)
order by lastname;


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who never purchased a twist ('Twist') during October 2007. Report first and last name in alphabetical order by last name.

select firstname, lastname
from customers where firstname not in
    (select firstname from customers
    join receipts on customer = cid
    join items on receipt = rnumber
    join goods on gid = item
    where food = 'Twist' and month(saledate) = 10)
order by lastname;


USE `BAKERY`;
-- BAKERY-4
-- Find the baked good(s) (flavor and food type) responsible for the most total revenue.
with revenue as
(select sum(price) as itemrev, flavor, food
from goods
join items on gid = item
join receipts on receipt = rnumber
group by flavor, food),
maxfood as
(select max(itemrev) as m from revenue)
select flavor, food
from revenue
where itemrev = (select max(m) from maxfood);


USE `BAKERY`;
-- BAKERY-5
-- Find the most popular item, based on number of pastries sold. Report the item (flavor and food) and total quantity sold.
with sold as
(select flavor, food, count(*) as numSold
from goods
join items on gid = item
join receipts on receipt = rnumber
group by food, flavor),
pop as
(select max(numSold) as m from sold)
select flavor, food, numSold
from sold
where numSold = (select max(m) from pop);


USE `BAKERY`;
-- BAKERY-6
-- Find the date(s) of highest revenue during the month of October, 2007. In case of tie, sort chronologically.
with highrev as
(select saledate, sum(price) as rev
from receipts
join items on receipt = rnumber
join goods on item = gid
group by saledate),
maxday as
(select max(rev) as m from highrev)
select saledate
from highrev
where rev = (select max(m) from maxday)
order by saledate;


USE `BAKERY`;
-- BAKERY-7
-- Find the best-selling item(s) (by number of purchases) on the day(s) of highest revenue in October of 2007.  Report flavor, food, and quantity sold. Sort by flavor and food.
with  best as
(select flavor, food, saledate, count(*) as num
from receipts
join items on receipt = rnumber
join goods on item = gid
group by flavor, food, saledate),

highrev as
(select saledate, sum(price) as rev
from receipts
join items on receipt = rnumber
join goods on item = gid
group by saledate),

maxday as
(select food, flavor, num
from best
where saledate = 
    (select saledate from highrev where rev = 
        (select max(rev) from highrev)))
        
select maxday.flavor, maxday.food, num
from maxday
where num = (select max(num) from maxday);


USE `BAKERY`;
-- BAKERY-8
-- For every type of Cake report the customer(s) who purchased it the largest number of times during the month of October 2007. Report the name of the pastry (flavor, food type), the name of the customer (first, last), and the quantity purchased. Sort output in descending order on the number of purchases, then in alphabetical order by last name of the customer, then by flavor.
with cakes as
(select flavor, food, firstname, lastname, customer, count(*) as num
from goods
join items on gid = item
join receipts on receipt = rnumber
join customers on cid = customer
where month(saledate) = 10 and year(saledate) = 2007 and food = 'Cake'
group by customer, flavor, food)

select flavor, food, firstname, lastname, num
from cakes as c1
where num = (select max(num) from cakes as c2 where c1.flavor = c2.flavor)
order by num desc, lastname, flavor;


USE `BAKERY`;
-- BAKERY-9
-- Output the names of all customers who made multiple purchases (more than one receipt) on the latest day in October on which they made a purchase. Report names (last, first) of the customers and the *earliest* day in October on which they made a purchase, sorted in chronological order, then by last name.

with earliest as
(select firstname, lastname, customer as c1, min(saledate) as early
from receipts
join customers on cid = customer
join items on rnumber = receipt
join goods on gid = item
group by c1),

latest as 
(select firstname, lastname, customer as c2, max(saledate) as late
from receipts
join customers on cid = customer
join items on rnumber = receipt
join goods on gid = item
group by c2)

select latest.lastname, latest.firstname, early
from receipts
join earliest on c1 = customer
join latest on c2 = customer and late = saledate
group by customer having count(rnumber) >= 2
order by early, lastname;


USE `BAKERY`;
-- BAKERY-10
-- Find out if sales (in terms of revenue) of Chocolate-flavored items or sales of Croissants (of all flavors) were higher in October of 2007. Output the word 'Chocolate' if sales of Chocolate-flavored items had higher revenue, or the word 'Croissant' if sales of Croissants brought in more revenue.

with chocolate as
(select sum(price) as choc
from goods
join items on gid = item
join receipts on receipt = rnumber
where flavor = 'Chocolate'),

croissant as
(select sum(price) as crois
from goods
join items on gid = item
join receipts on receipt = rnumber
where food = 'Croissant')

select case when choc > crois
then "Chocolate"
else "Croissant" 
end
from chocolate join croissant;


USE `INN`;
-- INN-1
-- Find the most popular room(s) (based on the number of reservations) in the hotel  (Note: if there is a tie for the most popular room, report all such rooms). Report the full name of the room, the room code and the number of reservations.

with res as 
(select roomname, room, count(*) as total
from rooms
join reservations on roomcode = room
group by roomname, room),
maxroom as
(select max(total) as m from res)
select roomname, room, total
from res
where total = (select max(m) from maxroom);


USE `INN`;
-- INN-2
-- Find the room(s) that have been occupied the largest number of days based on all reservations in the database. Report the room name(s), room code(s) and the number of days occupied. Sort by room name.
with days as 
(select roomname, room, datediff(checkout, checkin) as occ
from rooms
join reservations on roomcode = room
group by roomname, room, checkout, checkin),
total as
(select roomname, room, sum(occ) as m from days
group by room)
select roomname, room, m
from total 
where m = (select max(m) from total);


USE `INN`;
-- INN-3
-- For each room, report the most expensive reservation. Report the full room name, dates of stay, last name of the person who made the reservation, daily rate and the total amount paid (rounded to the nearest penny.) Sort the output in descending order by total amount paid.
with res as
(select roomname, room, lastname, rate, code, checkin, checkout,
    datediff(checkout, checkin)*rate as total
from rooms
join reservations on roomcode = room
group by code)

select roomname, checkin, checkout, lastname, rate, total
from res as r1
where r1.total = (select max(r2.total) from res as r2
    where r1.room = r2.room)
order by total desc;


USE `INN`;
-- INN-4
-- For each room, report whether it is occupied or unoccupied on July 4, 2010. Report the full name of the room, the room code, and either 'Occupied' or 'Empty' depending on whether the room is occupied on that day. (the room is occupied if there is someone staying the night of July 4, 2010. It is NOT occupied if there is a checkout on this day, but no checkin). Output in alphabetical order by room code. 
with occ as
(select room, roomname, 
case when (checkout > '2010-07-04' and checkin <= '2010-07-04') then
    'Occupied'
else 'Empty'
end as staying
from rooms
join reservations on roomcode = room),

e as 
(select room, roomname, count(*) as unocc
from occ 
where staying = 'Empty'
group by room),

total as
(select room, roomname, count(*) as days
from occ
group by room)

select total.roomname, total.room,
case
when days != unocc or total.room = 'SAY' then
    'Occupied'
else
    'Empty'
end as stay
from total 
left join e on total.room = e.room
order by total.room;


USE `INN`;
-- INN-5
-- Find the highest-grossing month (or months, in case of a tie). Report the month name, the total number of reservations and the revenue. For the purposes of the query, count the entire revenue of a stay that commenced in one month and ended in another towards the earlier month. (e.g., a September 29 - October 3 stay is counted as September stay for the purpose of revenue computation). In case of a tie, months should be sorted in chronological order.
with res as
(select checkin, checkout, datediff(checkout, checkin) * rate as cost
from reservations),

price as
(select count(*) as num, month(checkin) as month, sum(cost) as totprice
from res
group by month(checkin))

select monthname(str_to_date(month, '%m')), num, totprice
from price
where totprice = (select max(totprice) from price)
order by month;


USE `STUDENTS`;
-- STUDENTS-1
-- Find the teacher(s) with the largest number of students. Report the name of the teacher(s) (last, first) and the number of students in their class.

with teachers as
(select last, first, count(*) as num
from teachers 
join list on list.classroom = teachers.classroom
group by last, first),

maxteach as
(select max(num) as m from teachers)

select last, first, num
from teachers
where num = (select m from maxteach);


USE `STUDENTS`;
-- STUDENTS-2
-- Find the grade(s) with the largest number of students whose last names start with letters 'A', 'B' or 'C' Report the grade and the number of students. In case of tie, sort by grade number.
with grades as
(select grade, count(*) as total
from list
where lastname like 'A%' or lastname like 'B%' or lastname like 'C%'
group by grade),

maxgrade as
(select max(total) as m from grades)

select grade, total
from grades
where total = (select m from maxgrade)
order by grade;


USE `STUDENTS`;
-- STUDENTS-3
-- Find all classrooms which have fewer students in them than the average number of students in a classroom in the school. Report the classroom numbers and the number of student in each classroom. Sort in ascending order by classroom.
with grades as
(select classroom, count(*) as total
from list
group by classroom),

average as
(select sum(total)/count(classroom) as avgnum from grades)

select classroom, total
from grades
where total < (select avgnum from average)
order by classroom;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all pairs of classrooms with the same number of students in them. Report each pair only once. Report both classrooms and the number of students. Sort output in ascending order by the number of students in the classroom.
with class1 as
(select classroom as c1, count(*) as students1
from list
group by classroom),

class2 as
(select classroom as c2, count(*) as students2
from list
group by classroom)

select c2, c1, students1
from class1
join class2 on students1 = students2 and c1 > c2
order by students1;


USE `STUDENTS`;
-- STUDENTS-5
-- For each grade with more than one classroom, report the grade and the last name of the teacher who teaches the classroom with the largest number of students in the grade. Output results in ascending order by grade.
with students as
(select last, first, grade, count(*) as numstudents
from list
join teachers on list.classroom = teachers.classroom
group by last, first, grade),

rooms as 
(select grade, count(distinct teachers.classroom) as classrooms
from list
join teachers on list.classroom = teachers.classroom
group by grade),

morethanone as
(select * from students
where students.grade in
    (select rooms.grade from rooms where classrooms > 1)
)

select m1.grade, m1.last
from morethanone as m1
where m1.numstudents = (select max(m2.numstudents) from morethanone as m2
    where m1.grade = m2.grade)
order by grade;


USE `CSU`;
-- CSU-1
-- Find the campus(es) with the largest enrollment in 2000. Output the name of the campus and the enrollment. Sort by campus name.

select campus, enrolled
from enrollments 
join campuses on id = campusid
where enrollments.year = 2000 
    and enrolled = (select max(enrolled) from enrollments
        where year = 2000);


USE `CSU`;
-- CSU-2
-- Find the university (or universities) that granted the highest average number of degrees per year over its entire recorded history. Report the name of the university, sorted alphabetically.

with camp as
(select campus, sum(degrees) as totdegrees
from degrees
join campuses on id = campusid
group by campus),

maxuni as
(select max(totdegrees) as m from camp)

select campus from camp
where totdegrees = (select m from maxuni)
order by campus;


USE `CSU`;
-- CSU-3
-- Find the university with the lowest student-to-faculty ratio in 2003. Report the name of the campus and the student-to-faculty ratio, rounded to one decimal place. Use FTE numbers for enrollment. In case of tie, sort by campus name.
with stf as
(select campus, round(enrollments.fte/faculty.fte, 1) as ratio
from enrollments
join faculty on faculty.campusid = enrollments.campusid and 
    faculty.year = enrollments.year
join campuses on faculty.campusid = id
where faculty.year = 2003)

select campus, ratio
from stf
where ratio = (select min(ratio) from stf);


USE `CSU`;
-- CSU-4
-- Among undergraduates studying 'Computer and Info. Sciences' in the year 2004, find the university with the highest percentage of these students (base percentages on the total from the enrollments table). Output the name of the campus and the percent of these undergraduate students on campus. In case of tie, sort by campus name.
with cis as
(select campus, round(ug/enrolled*100, 1) as ratio
from campuses
join enrollments on enrollments.campusid = campuses.id
join discEnr on discEnr.campusid = campuses.id
join disciplines on disciplines.id = discipline
where discEnr.year = 2004 and enrollments.year = 2004
    and name = 'Computer and Info. Sciences'
)


select campus, ratio
from cis
where ratio = (select max(ratio) from cis);


USE `CSU`;
-- CSU-5
-- For each year between 1997 and 2003 (inclusive) find the university with the highest ratio of total degrees granted to total enrollment (use enrollment numbers). Report the year, the name of the campuses, and the ratio. List in chronological order.
with dte as
(select enrollments.year, campus, round(degrees/enrollments.enrolled, 4) as ratio
from enrollments
join campuses on id = enrollments.campusid
join degrees on degrees.campusid = id and degrees.year = enrollments.year
where (degrees.year between 1997 and 2003) and 
    enrollments.year between 1997 and 2003)
    
select *
from dte as d1
where d1.ratio = (select max(d2.ratio) from dte d2 where d1.year = d2.year)
order by d1.year;


USE `CSU`;
-- CSU-6
-- For each campus report the year of the highest student-to-faculty ratio, together with the ratio itself. Sort output in alphabetical order by campus name. Use FTE numbers to compute ratios and round to two decimal places.
with stf as
(select campus, enrollments.year, 
    max(round(enrollments.fte/faculty.fte, 2)) as ratio
from campuses
join enrollments on enrollments.campusid = id
join faculty on faculty.campusid = id and faculty.year = enrollments.year
group by campus, enrollments.year)

select s1.campus, s1.year, s1.ratio from stf as s1
where s1.ratio = (select max(s2.ratio) from stf s2 where s2.campus = s1.campus)
order by s1.campus;


USE `CSU`;
-- CSU-7
-- For each year for which the data is available, report the total number of campuses in which student-to-faculty ratio became worse (i.e. more students per faculty) as compared to the previous year. Report in chronological order.

with stf as
(select campus, enrollments.year, max(enrollments.fte/faculty.fte) as ratio
from enrollments
join campuses on enrollments.campusid = id
join faculty on faculty.campusid = id and enrollments.year = faculty.year
group by campus, enrollments.year)

select(s1.year + 1) as year1, count(*)
from stf as s1
where s1.ratio < (select max(s2.ratio) from stf s2 
    where s1.campus = s2.campus and s1.year+1 = s2.year)
group by year1
order by year1;


USE `MARATHON`;
-- MARATHON-1
-- Find the state(s) with the largest number of participants. List state code(s) sorted alphabetically.

with states as
(select state, count(*) as num
from marathon
group by state),

maxstate as
(select max(num) as m from states)

select state from states
where num = (select m from maxstate)
order by state;


USE `MARATHON`;
-- MARATHON-2
-- Find all towns in Rhode Island (RI) which fielded more female runners than male runners for the race. Include only those towns that fielded at least 1 male runner and at least 1 female runner. Report the names of towns, sorted alphabetically.

with females as
(select town, count(*) as f
from marathon
where state = 'RI' and sex = 'F'
group by town),

males as 
(select town, count(*) as m
from marathon where state = 'RI' and sex = 'M'
group by town)

select females.town
from females
join males on females.town = males.town
where f > 0 and m > 0 and f > m
order by females.town;


USE `MARATHON`;
-- MARATHON-3
-- For each state, report the gender-age group with the largest number of participants. Output state, age group, gender, and the number of runners in the group. Report only information for the states where the largest number of participants in a gender-age group is greater than one. Sort in ascending order by state code, age group, then gender.
with gagroup as
(select state, agegroup, sex, count(*) as num
from marathon
group by state, agegroup, sex)

select g1.* from gagroup g1
where g1.num = (select max(g2.num) from gagroup g2 where g1.state = g2.state)
    and g1.num > 1
order by g1.state, g1.agegroup, g1.sex;


USE `MARATHON`;
-- MARATHON-4
-- Find the 30th fastest female runner. Report her overall place in the race, first name, and last name. This must be done using a single SQL query (which may be nested) that DOES NOT use the LIMIT clause. Think carefully about what it means for a row to represent the 30th fastest (female) runner.
select m1.place, m1.firstname, m1.lastname
from marathon m1
where m1.sex = 'F' 
    and 29 = (select count(*) from marathon m2 where sex = 'F' 
    and m2.place < m1.place)
group by m1.place;


USE `MARATHON`;
-- MARATHON-5
-- For each town in Connecticut report the total number of male and the total number of female runners. Both numbers shall be reported on the same line. If no runners of a given gender from the town participated in the marathon, report 0. Sort by number of total runners from each town (in descending order) then by town.

with men as
(select town, count(*) as m
from marathon
where state = 'CT' and sex = 'M'
group by town),

total as 
(select town, count(*) as tot
from marathon
where state = 'CT'
group by town)

select total.town,
case
    when m is null then 0
    else m
end as Men,
case
    when m is null then tot
    else tot - m
end as Women
from men
right join total on men.town = total.town
order by tot desc, total.town;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report the first name of the performer who never played accordion.

select firstname
from Band
where firstname not in
    (select firstname from Band
    join Instruments on id = bandmate
    where instrument = 'accordion');


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- Report, in alphabetical order, the titles of all instrumental compositions performed by Katzenjammer ("instrumental composition" means no vocals).

select title
from Songs
where songid not in (select song from Vocals);


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- Report the title(s) of the song(s) that involved the largest number of different instruments played (if multiple songs, report the titles in alphabetical order).
with titles as
(select title, songid, count(instrument) as num
from Instruments
join Songs on song = songid
group by song)

select title
from titles
where num = (select max(num) from titles)
order by title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find the favorite instrument of each performer. Report the first name of the performer, the name of the instrument, and the number of songs on which the performer played that instrument. Sort in alphabetical order by the first name, then instrument.

with fav as
(select firstname, id, instrument, count(*) as num
from Band
join Instruments on bandmate = id
group by id, instrument)

select b1.firstname, b1.instrument, b1.num
from fav b1
where b1.num = (select max(b2.num) from fav b2 where b1.id = b2.id)
order by b1.firstname, b1.instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments played ONLY by Anne-Marit. Report instrument names in alphabetical order.
select instrument from Instruments
where instrument not in 
    (select instrument from Instruments
    join Band on id = bandmate
    where firstname != 'Anne-Marit');


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Report, in alphabetical order, the first name(s) of the performer(s) who played the largest number of different instruments.

with dif as
(select firstname, id, count(distinct instrument) as num
from Instruments 
join Band on bandmate = id
group by id),

maxin as
(select max(num) as m from dif)

select firstname from dif
where num = (select m from maxin)
order by firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Which instrument(s) was/were played on the largest number of songs? Report just the names of the instruments, sorted alphabetically (note, you are counting number of songs on which an instrument was played, make sure to not count two different performers playing same instrument on the same song twice).
with inst as
(select instrument, count(distinct song) as num
from Instruments
group by instrument),

maxin as 
(select max(num) as m from inst)

select instrument
from inst
where num = (select m from maxin);


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Who spent the most time performing in the center of the stage (in terms of number of songs on which she was positioned there)? Return just the first name of the performer(s), sorted in alphabetical order.

with cent as
(select firstname, count(distinct song) as num
from Band
join Performance on bandmate = id
where stageposition = 'center'
group by firstname),

maxcent as
(select max(num) as m from cent)

select firstname
from cent
where num = (select m from maxcent)
order by firstname;


