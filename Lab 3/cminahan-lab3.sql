-- Lab 3
-- cminahan
-- Apr 25, 2022

USE `cminahan`;
-- BAKERY-1
-- Using a single SQL statement, reduce the prices of Lemon Cake and Napoleon Cake by $2.
UPDATE goods
SET price = price - 2
WHERE Food = 'Cake' and (Flavor = 'Lemon' or Flavor = 'Napoleon');


USE `cminahan`;
-- BAKERY-2
-- Using a single SQL statement, increase by 15% the price of all Apricot or Chocolate flavored items with a current price below $5.95.
UPDATE goods 
SET price = price*1.15
WHERE (Flavor = 'Apricot' or Flavor = 'Chocolate') and price < 5.95;


USE `cminahan`;
-- BAKERY-3
-- Add the capability for the database to record payment information for each receipt in a new table named payments (see assignment PDF for task details)
drop table if exists payments;

CREATE TABLE payments(
    Receipt INTEGER NOT NULL,
    Amount NUMERIC(10, 2) NOT NULL,
    PaymentSettled DATETIME,
    PaymentType VARCHAR(50) NOT NULL,
    primary key(Receipt, Amount, PaymentSettled, PaymentType),
    foreign key (Receipt) references receipts(RNumber)
);


USE `cminahan`;
-- BAKERY-4
-- Create a database trigger to prevent the sale of Meringues (any flavor) and all Almond-flavored items on Saturdays and Sundays.
create trigger weekend before insert on items
for each row
begin
    declare item_type char(50);
    declare item_flavor char(50);
    declare day date;
    declare day_name char(50);
    select Food into item_type from goods where GId = NEW.Item;
    select Flavor into item_flavor from goods where GId = NEW.Item;
    select SaleDate into day from receipts where RNumber = NEW.Receipt;
    if ((dayname(day) = "Sunday" or dayname(day) = 'Saturday')
    and (item_type = 'Meringue' or item_flavor = 'Almond')) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No meringues on weekends';
    end if;
end;


USE `cminahan`;
-- AIRLINES-1
-- Enforce the constraint that flights should never have the same airport as both source and destination (see assignment PDF)
create trigger verify_flight before insert on flights
for each row
begin
    if (NEW.DestAirport = NEW.SourceAirport) then
        signal sqlstate '45000'
        set message_text = 'Invalid flight';
    end if;
end;


USE `cminahan`;
-- AIRLINES-2
-- Add a "Partner" column to the airlines table to indicate optional corporate partnerships between airline companies (see assignment PDF)
alter table airlines
drop column Partner;

drop trigger if exists no_self;
drop trigger if exists duplicate;

alter table airlines 
add Partner char(50) unique;

select * from airlines;

create trigger no_self before insert on airlines
for each row
begin
    if (NEW.Abbreviation = NEW.Partner) then
        signal sqlstate '45000'
        set message_text = 'No self partner';
    end if;
end;

create trigger duplicate before insert on airlines
for each row
begin
    if((new.Partner is not null) and 
    (select count(*) from airlines where new.Partner = Abbreviation) = 0) then
        signal sqlstate '45000'
        set message_text = 'No partner';
    end if;
end;


select * from airlines


update airlines
set Partner = 'JetBlue' 
where Abbreviation = 'Southwest';

update airlines
set Partner = 'Southwest'
where Abbreviation = 'JetBlue';


USE `cminahan`;
-- KATZENJAMMER-1
-- Change the name of two instruments: 'bass balalaika' should become 'awesome bass balalaika', and 'guitar' should become 'acoustic guitar'. This will require several steps. You may need to change the length of the instrument name field to avoid data truncation. Make this change using a schema modification command, rather than a full DROP/CREATE of the table.
update Instruments
set Instrument = 'awesome bass balalaika'
where Instrument = 'bass balalaika';

update Instruments
set Instrument = 'acoustic guitar'
where Instrument = 'guitar';


USE `cminahan`;
-- KATZENJAMMER-2
-- Keep in the Vocals table only those rows where Solveig (id 1 -- you may use this numeric value directly) sang, but did not sing lead.
delete from Vocals 
where `Type` = 'lead';


