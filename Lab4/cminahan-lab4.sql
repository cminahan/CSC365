-- Lab 4
-- cminahan
-- May 1, 2022

USE `STUDENTS`;
-- STUDENTS-1
-- Find all students who study in classroom 111. For each student list first and last name. Sort the output by the last name of the student.
select FirstName, LastName from list
where Classroom = 111
order by LastName;


USE `STUDENTS`;
-- STUDENTS-2
-- For each classroom report the grade that is taught in it. Report just the classroom number and the grade number. Sort output by classroom in descending order.
select distinct classroom, grade 
from list
order by Classroom desc;


USE `STUDENTS`;
-- STUDENTS-3
-- Find all teachers who teach fifth grade. Report first and last name of the teachers and the room number. Sort the output by room number.
select distinct First, Last, teachers.Classroom
from teachers inner join list
on list.grade = 5 and teachers.classroom = list.classroom;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all students taught by OTHA MOYER. Output first and last names of students sorted in alphabetical order by their last name.
select distinct FirstName, LastName
from list inner join teachers 
on list.Classroom = teachers.Classroom 
and teachers.First = 'OTHA' and teachers.Last = 'MOYER'
order by LastName;


USE `STUDENTS`;
-- STUDENTS-5
-- For each teacher teaching grades K through 3, report the grade (s)he teaches. Output teacher last name, first name, and grade. Each name has to be reported exactly once. Sort the output by grade and alphabetically by teacher’s last name for each grade.
select distinct Last, First, Grade
from teachers inner join list
on list.grade < 4 and list.Classroom = teachers.Classroom
order by grade, Last;


USE `BAKERY`;
-- BAKERY-1
-- Find all chocolate-flavored items on the menu whose price is under $5.00. For each item output the flavor, the name (food type) of the item, and the price. Sort your output in descending order by price.
select Flavor, Food, Price from goods
where Price < 5.00 and Flavor = 'Chocolate'
order by Price desc;


USE `BAKERY`;
-- BAKERY-2
-- Report the prices of the following items (a) any cookie priced above $1.10, (b) any lemon-flavored items, or (c) any apple-flavored item except for the pie. Output the flavor, the name (food type) and the price of each pastry. Sort the output in alphabetical order by the flavor and then pastry name.
select Flavor, Food, Price from goods
where (Food = 'Cookie' and Price > 1.10)
    or (Flavor = 'Lemon') 
    or (Flavor = 'Apple' and Food != 'Pie')
order by Flavor, Food;


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who made a purchase on October 3, 2007. Report the name of the customer (last, first). Sort the output in alphabetical order by the customer’s last name. Each customer name must appear at most once.
select distinct LastName, FirstName 
from customers inner join receipts
on receipts.SaleDate = '2007-10-03' and receipts.Customer = customers.CId
order by LastName;


USE `BAKERY`;
-- BAKERY-4
-- Find all different cakes purchased on October 4, 2007. Each cake (flavor, food) is to be listed once. Sort output in alphabetical order by the cake flavor.
select distinct Flavor, Food 
from goods
inner join items on goods.Food = 'Cake' and items.Item = goods.GId
inner join receipts on items.Receipt = receipts.RNumber
    and receipts.SaleDate = '2007-10-04'
order by Flavor;


USE `BAKERY`;
-- BAKERY-5
-- List all pastries purchased by ARIANE CRUZEN on October 25, 2007. For each pastry, specify its flavor and type, as well as the price. Output the pastries in the order in which they appear on the receipt (each pastry needs to appear the number of times it was purchased).
select Flavor, Food, Price
from goods
inner join items on (goods.Food = 'Cookie' or goods.Food = 'Tart' 
    or goods.Food = 'Danish') and items.Item = goods.GId
inner join receipts on receipts.RNumber = items.Receipt
    and receipts.SaleDate = '2007-10-25'
inner join customers on receipts.Customer = customers.CId
    and customers.FirstName = 'ARIANE'
    and customers.LastName = 'CRUZEN'
order by items.Ordinal;


USE `BAKERY`;
-- BAKERY-6
-- Find all types of cookies purchased by KIP ARNN during the month of October of 2007. Report each cookie type (flavor, food type) exactly once in alphabetical order by flavor.

select distinct Flavor, Food from goods
inner join items on items.Item = goods.GID and goods.Food = 'Cookie'
inner join receipts on receipts.RNumber = items.Receipt 
    and month(receipts.SaleDate) = 10
inner join customers on customers.CId = receipts.Customer
    and customers.LastName = 'ARNN' and customers.FirstName = 'KIP'
order by Flavor;


USE `CSU`;
-- CSU-1
-- Report all campuses from Los Angeles county. Output the full name of campus in alphabetical order.
select Campus from campuses
where county = 'Los Angeles'
order by Campus;


USE `CSU`;
-- CSU-2
-- For each year between 1994 and 2000 (inclusive) report the number of students who graduated from California Maritime Academy Output the year and the number of degrees granted. Sort output by year.
select distinct degrees.Year, Degrees from degrees
inner join campuses on campuses.Campus = 'California Maritime Academy'
    and degrees.CampusId = campuses.Id and 1994 <= degrees.Year
    and degrees.Year <= 2000
order by degrees.Year;


USE `CSU`;
-- CSU-3
-- Report undergraduate and graduate enrollments (as two numbers) in ’Mathematics’, ’Engineering’ and ’Computer and Info. Sciences’ disciplines for both Polytechnic universities of the CSU system in 2004. Output the name of the campus, the discipline and the number of graduate and the number of undergraduate students enrolled. Sort output by campus name, and by discipline for each campus.
select campuses.Campus, disciplines.name, discEnr.Gr, discEnr.Ug
from campuses
inner join discEnr on campuses.Id = discEnr.CampusId
    and (campuses.Campus = 'California Polytechnic State University-San Luis Obispo'
    or campuses.Campus = 'California State Polytechnic University-Pomona')
inner join disciplines on disciplines.id = discEnr.Discipline
    and (disciplines.name = 'Mathematics' or disciplines.name = 'Engineering'
    or disciplines.name = 'Computer and Info. Sciences')
order by campuses.Campus, disciplines.name;


USE `CSU`;
-- CSU-4
-- Report graduate enrollments in 2004 in ’Agriculture’ and ’Biological Sciences’ for any university that offers graduate studies in both disciplines. Report one line per university (with the two grad. enrollment numbers in separate columns), sort universities in descending order by the number of ’Agriculture’ graduate students.
select Campus, e1.Gr as Agriculture, e2.Gr as Biology
from campuses
join discEnr as e1 on Id = e1.CampusId and e1.Year = 2004
join discEnr as e2 on Id = e2.CampusId and e2.Year = 2004
join disciplines as d1 on d1.Id = e1.Discipline and d1.Name = 'Agriculture'
    and e1.Gr != 0
join disciplines as d2 on d2.Id = e2.Discipline 
    and d2.Name = 'Biological Sciences' and e2.Gr != 0
order by Agriculture desc;


USE `CSU`;
-- CSU-5
-- Find all disciplines and campuses where graduate enrollment in 2004 was at least three times higher than undergraduate enrollment. Report campus names, discipline names, and both enrollment counts. Sort output by campus name, then by discipline name in alphabetical order.
select Campus, Name, Ug, Gr
from discEnr
inner join campuses on discEnr.CampusId = campuses.Id
    and discEnr.Year = 2004 and Gr >= 3*Ug
inner join disciplines on Discipline = disciplines.Id
order by Campus, Name;


USE `CSU`;
-- CSU-6
-- Report the amount of money collected from student fees (use the full-time equivalent enrollment for computations) at ’Fresno State University’ for each year between 2002 and 2004 inclusively, and the amount of money (rounded to the nearest penny) collected from student fees per each full-time equivalent faculty. Output the year, the two computed numbers sorted chronologically by year.
select distinct enrollments.Year as year, enrollments.FTE*fees.fee as COLLECTED,
    ROUND(((enrollments.FTE*fees.fee)/faculty.FTE), 2) as 'PER FACULTY'
from enrollments
inner join campuses on Campus = 'Fresno State University'
    and campuses.Id = enrollments.CampusId
inner join faculty on enrollments.Year >= 2002 and enrollments.Year <= 2004
    and enrollments.CampusId = faculty.CampusId
    and enrollments.Year = faculty.Year
inner join fees on fees.CampusId = enrollments.CampusId 
    and fees.Year = enrollments.Year
order by Year;


USE `CSU`;
-- CSU-7
-- Find all campuses where enrollment in 2003 (use the FTE numbers), was higher than the 2003 enrollment in ’San Jose State University’. Report the name of campus, the 2003 enrollment number, the number of faculty teaching that year, and the student-to-faculty ratio, rounded to one decimal place. Sort output in ascending order by student-to-faculty ratio.
select distinct Campus, e.FTE, faculty.FTE, ROUND(e.FTE/faculty.FTE, 1)
from campuses
join enrollments as s on s.Year = 2003 and s.CampusId = 19
join enrollments as e on e.Year = 2003 and e.CampusId != s.CampusId
    and e.CampusId = Id and e.FTE > s.FTE
join faculty on faculty.Year = 2003 and faculty.CampusId = e.CampusId
order by e.FTE/faculty.FTE;


USE `INN`;
-- INN-1
-- Find all modern rooms with a base price below $160 and two beds. Report room code and full room name, in alphabetical order by the code.
select RoomCode, RoomName from rooms
where basePrice < 160 and Beds = 2 and decor = 'modern'
order by RoomCode;


USE `INN`;
-- INN-2
-- Find all July 2010 reservations (a.k.a., all reservations that both start AND end during July 2010) for the ’Convoke and sanguine’ room. For each reservation report the last name of the person who reserved it, checkin and checkout dates, the total number of people staying and the daily rate. Output reservations in chronological order.
select LastName, CheckIn, CheckOut, Adults+Kids as Guests, Rate
from reservations
inner join rooms on reservations.Room = rooms.RoomCode
    and rooms.RoomName = 'Convoke and sanguine'
    and month(reservations.CheckIn) = 7 
    and month(reservations.CheckOut) = 7
order by checkIn;


USE `INN`;
-- INN-3
-- Find all rooms occupied on February 6, 2010. Report full name of the room, the check-in and checkout dates of the reservation. Sort output in alphabetical order by room name.
select roomName, CheckIn, CheckOut
from reservations
inner join rooms on reservations.Room = rooms.roomCode
    and reservations.CheckIn <= '2010-02-06'
    and reservations.CheckOut > '2010-02-06'
order by roomName;


USE `INN`;
-- INN-4
-- For each stay by GRANT KNERIEN in the hotel, calculate the total amount of money, he paid. Report reservation code, room name (full), checkin and checkout dates, and the total stay cost. Sort output in chronological order by the day of arrival.

select Code, roomName, CheckIn, CheckOut, Rate*DATEDIFF(CheckOut, CheckIn) as Paid
from reservations
inner join rooms on rooms.roomCode = reservations.Room
    and LastName = 'KNERIEN' and FirstName = 'GRANT'
order by CheckIn;


USE `INN`;
-- INN-5
-- For each reservation that starts on December 31, 2010 report the room name, nightly rate, number of nights spent and the total amount of money paid. Sort output in descending order by the number of nights stayed.
select roomName as roomname, Rate as rate, 
    datediff(CheckOut, CheckIn) as Nights, 
    Rate*datediff(CheckOut, CheckIn) as Money
from reservations
inner join rooms on Room = RoomCode 
    and CheckIn = '2010-12-31'
order by datediff(CheckOut, CheckIn) desc;


USE `INN`;
-- INN-6
-- Report all reservations in rooms with double beds that contained four adults. For each reservation report its code, the room abbreviation, full name of the room, check-in and check out dates. Report reservations in chronological order, then sorted by the three-letter room code (in alphabetical order) for any reservations that began on the same day.
select distinct Code, RoomCode, roomName, CheckIn, CheckOut
from reservations
inner join rooms on Room = RoomCode and bedType = 'double' 
    and Adults = 4 and Kids = 0
order by CheckIn, RoomCode;


USE `MARATHON`;
-- MARATHON-1
-- Report the overall place, running time, and pace of TEDDY BRASEL.
select Place, RunTime, Pace
from marathon
where FirstName = 'TEDDY' and LastName = 'BRASEL';


USE `MARATHON`;
-- MARATHON-2
-- Report names (first, last), overall place, running time, as well as place within gender-age group for all female runners from QUNICY, MA. Sort output by overall place in the race.
select FirstName, LastName, Place, RunTime, GroupPlace
from marathon 
where Sex = 'F' and Town = 'QUNICY' and State = 'MA'
order by Place;


USE `MARATHON`;
-- MARATHON-3
-- Find the results for all 34-year old female runners from Connecticut (CT). For each runner, output name (first, last), town and the running time. Sort by time.
select FirstName, LastName, Town, RunTime
from marathon
where Age = 34 and sex = 'F' and State = 'CT'
order by RunTime;


USE `MARATHON`;
-- MARATHON-4
-- Find all duplicate bibs in the race. Report just the bib numbers. Sort in ascending order of the bib number. Each duplicate bib number must be reported exactly once.
select distinct m1.BibNumber
from marathon as m1 join marathon as m2 
on m1.BibNumber = m2.BibNumber and m1.place != m2.place
order by m1.BibNumber;


USE `MARATHON`;
-- MARATHON-5
-- List all runners who took first place and second place in their respective age/gender groups. List gender, age group, name (first, last) and age for both the winner and the runner up (in a single row). Order the output by gender, then by age group.
select f.Sex, f.AgeGroup, f.FirstName, f.LastName, f.Age, 
    s.FirstName, s.LastName, s.Age
from marathon as f join marathon as s
on f.GroupPlace = 1 and s.GroupPlace = 2 and f.AgeGroup = s.AgeGroup 
    and f.Sex = s.Sex
order by f.Sex, f.AgeGroup;


USE `AIRLINES`;
-- AIRLINES-1
-- Find all airlines that have at least one flight out of AXX airport. Report the full name and the abbreviation of each airline. Report each name only once. Sort the airlines in alphabetical order.
select distinct Name, Abbr
from airlines
join flights on Airline = Id and flights.Source = 'AXX'
order by Name;


USE `AIRLINES`;
-- AIRLINES-2
-- Find all destinations served from the AXX airport by Northwest. Re- port flight number, airport code and the full name of the airport. Sort in ascending order by flight number.

select FlightNo, Destination, airports.Name
from flights
join airports on Destination = Code and Source = 'AXX'
join airlines on Id = Airline and airlines.Name = 'Northwest Airlines'
order by FlightNo;


USE `AIRLINES`;
-- AIRLINES-3
-- Find all *other* destinations that are accessible from AXX on only Northwest flights with exactly one change-over. Report pairs of flight numbers, airport codes for the final destinations, and full names of the airports sorted in alphabetical order by the airport code.
select f1.FlightNo, f2.FlightNo, f2.Destination, airports.Name
from flights as f1
join flights as f2 on f1.Airline = f2.Airline and f1.Source = 'AXX' 
    and f1.Destination = f2.Source and f2.Destination != 'AXX'
join airlines on Id = f1.Airline and airlines.Abbr = 'Northwest'
join airports on f2.Destination = Code
order by f1.Source;


USE `AIRLINES`;
-- AIRLINES-4
-- Report all pairs of airports served by both Frontier and JetBlue. Each airport pair must be reported exactly once (if a pair X,Y is reported, then a pair Y,X is redundant and should not be reported).
select distinct f2.Source, f2.Destination
from flights as f1
join airlines as a1 on f1.Airline = a1.Id and a1.Abbr = 'Frontier'
join airlines as a2 on a2.Abbr = 'JetBlue'
join flights as f2 on f2.Airline = a2.Id and f1.Source = f2.Source
    and f1.Destination = f2.Destination and f1.Source < f2.Destination;


USE `AIRLINES`;
-- AIRLINES-5
-- Find all airports served by ALL five of the airlines listed below: Delta, Frontier, USAir, UAL and Southwest. Report just the airport codes, sorted in alphabetical order.
select distinct f5.Source from flights as f1
join airlines as a1 on a1.Id = f1.Airline and a1.Abbr = 'Delta'
join flights as f2 on f1.Source  = f2.Source
join airlines as a2 on a2.Id = f2.Airline and a2.Abbr = 'Frontier'
join flights as f3 on f3.Source  = f2.Source
join airlines as a3 on a3.Id = f3.Airline and a3.Abbr = 'USAir'
join flights as f4 on f4.Source  = f3.Source
join airlines as a4 on a4.Id = f4.Airline and a4.Abbr = 'UAL'
join flights as f5 on f5.Source  = f4.Source
join airlines as a5 on a5.Id = f5.Airline and a5.Abbr = 'Southwest'
order by f5.Source;


USE `AIRLINES`;
-- AIRLINES-6
-- Find all airports that are served by at least three Southwest flights. Report just the three-letter codes of the airports — each code exactly once, in alphabetical order.
select distinct f1.Source from flights as f1
join airlines as a1 on a1.Id = f1.Airline and a1.Abbr = 'Southwest'
join flights as f2 on f1.Source = f2.Source and f1.Destination != f2.Destination
join airlines as a2 on a2.Id = f2.Airline and a2.Abbr = 'Southwest'
join flights as f3 on f3.Source = f2.Source and f3.Destination != f2.Destination
    and f1.Source = f3.Source and f1.Destination != f3.Destination
join airlines as a3 on a3.Id = f3.Airline and a3.Abbr = 'Southwest'
order by f1.Source;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report, in order, the tracklist for ’Le Pop’. Output just the names of the songs in the order in which they occur on the album.
select Songs.Title from Songs
join Tracklists on SongId = Song
join Albums on AId = Album and Albums.Title = 'Le Pop'
order by Position;


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- List the instruments each performer plays on ’Mother Superior’. Output the first name of each performer and the instrument, sort alphabetically by the first name.
select FirstName, Instrument from Band
join Instruments on Id = Bandmate
join Songs on Instruments.Song = Songs.SongId
    and Songs.Title = 'Mother Superior'
order by FirstName;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List all instruments played by Anne-Marit at least once during the performances. Report the instruments in alphabetical order (each instrument needs to be reported exactly once).
select distinct Instrument from Instruments
join Band on Bandmate = Id and FirstName = 'Anne-Marit'
order by Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find all songs that featured ukalele playing (by any of the performers). Report song titles in alphabetical order.
select distinct Title from Songs
join Instruments on Song = SongId and Instrument = 'ukalele'
order by Title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments Turid ever played on the songs where she sang lead vocals. Report the names of instruments in alphabetical order (each instrument needs to be reported exactly once).
select distinct Instrument from Instruments
join Band on Instruments.Bandmate = Id and FirstName = 'Turid'
join Vocals on Vocals.Bandmate = Id and 
    Vocals.Song = Instruments.Song and VocalType = 'lead'
order by Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Find all songs where the lead vocalist is not positioned center stage. For each song, report the name, the name of the lead vocalist (first name) and her position on the stage. Output results in alphabetical order by the song, then name of band member. (Note: if a song had more than one lead vocalist, you may see multiple rows returned for that song. This is the expected behavior).
select Songs.Title, FirstName, StagePosition from Songs
join Performance on Performance.Song = Songs.SongId and StagePosition != 'center'
join Vocals on Vocals.Song = Songs.SongId and VocalType = 'lead'
join Band on Band.Id = Performance.Bandmate and Band.Id = Vocals.Bandmate
order by Songs.Title, FirstName;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Find a song on which Anne-Marit played three different instruments. Report the name of the song. (The name of the song shall be reported exactly once)
select distinct Title from Songs
join Instruments as i1 on i1.Song = SongId
join Instruments as i2 on i1.Song = i2.Song 
    and i2.Instrument != i1.Instrument
join Instruments as i3 on i3.Song = i2.Song
    and i3.Instrument != i1.Instrument and i3.Instrument != i2.Instrument
join Band on FirstName = 'Anne-Marit' and Id = i1.Bandmate
    and Id = i2.Bandmate and Id = i3.Bandmate;


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Report the positioning of the band during ’A Bar In Amsterdam’. (just one record needs to be returned with four columns (right, center, back, left) containing the first names of the performers who were staged at the specific positions during the song).
select b1.FirstName as 'Right', b2.FirstName as 'Center',
    b3.FirstName as 'Back', b4.FirstName as 'Left'
from Performance as s1
join Performance as s2 on s1.StagePosition = 'right'
    and s2.StagePosition = 'center' and s1.Song = s2.Song 
join Performance as s3 on s3.StagePosition = 'back'
    and s3.Song = s2.Song
join Performance as s4 on s4.StagePosition = 'left'
    and s4.Song = s3.Song
join Songs on SongId = s1.Song and Title = 'A Bar In Amsterdam'
join Band as b1 on b1.Id = s1.Bandmate
join Band as b2 on b2.Id = s2.Bandmate
join Band as b3 on b3.Id = s3.Bandmate
join Band as b4 on b4.Id = s4.Bandmate;


