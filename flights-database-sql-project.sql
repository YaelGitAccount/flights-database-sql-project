--======================================
-- Database creation
--======================================

CREATE DATABASE Flights_328157276
GO
---
CREATE TABLE Companies_tbl -- Create companies table
(
	CompID varchar(10) primary key, -- Company code
	CompName  varchar(10) -- Name
)
GO
CREATE TABLE Airplanes_tbl -- Create airplanes table
(
	ApID varchar(10) primary key, -- Airplane code
	CompID varchar(10) references Companies_tbl, -- Company code
	Apseats smallint, -- Seat count
)
GO
CREATE TABLE Destinations_tbl -- Create destinations table
(
	DestID varchar(10) primary key, -- Destination code
	DestName varchar(10) -- Destination name
)
GO
CREATE TABLE Flights_tbl -- Create flights table
(
	FlID varchar(10) primary key, -- Flight code
	ApID varchar(10) references Airplanes_tbl, -- Airplane code
	DestID varchar(10) references Destinations_tbl, -- Destination code
	FlPrice smallint, -- Flight price
	FlDate date, -- Flight date
	FlContinue varchar(10) references Flights_tbl -- Connecting flight code
)
GO
CREATE TABLE Passengers_tbl -- Create passengers table
(
	PassID varchar(10) primary key, -- Passenger ID
	PassFirstName varchar(10), -- Passenger first name
	PassLastName varchar(10), -- Passenger last name
	PassPhone varchar(10) -- Passenger phone
)
GO
CREATE TABLE Purchase_tbl -- Create purchases table
(
	PurID varchar(10) primary key, -- Purchase ID
	FlID varchar(10) references Flights_tbl, -- Flight code
	PassID varchar(10) references Passengers_tbl, -- Passenger ID
	PurDate date, -- Purchase date
	PurSeat smallint -- Seat number
)
GO
-- VIP passengers table
CREATE TABLE VIPPassengers_tbl
(
	PassID varchar(10) primary key, -- Passenger ID
	PassFirstName varchar(10), -- Passenger first name
	PassLastName varchar(10), -- Passenger last name
	PassPhone varchar(10) -- Passenger phone
)
GO
ALTER TABLE Airplanes_tbl 
ALTER COLUMN CompID varchar(10) NOT NULL

ALTER TABLE Flights_tbl 
ALTER COLUMN FlPrice varchar(10) NOT NULL

ALTER TABLE Passengers_tbl 
ALTER COLUMN PassPhone varchar(10) NOT NULL

ALTER TABLE Purchase_tbl 
ALTER COLUMN PurSeat varchar(10) NOT NULL

--======================================--
-- Stored Procedures
--======================================--
-- Procedures to populate tables

-- Insert companies
CREATE PROCEDURE InsertCompanies_tbl(@CompID varchar(10), @CompName varchar(10))
AS
	INSERT INTO Companies_tbl(CompID, CompName) VALUES (@CompID, @CompName)
GO
EXECUTE InsertCompanies_tbl '12578', 'ELAL'
EXECUTE InsertCompanies_tbl '12345', 'ISRAIR'
EXECUTE InsertCompanies_tbl '98765', 'SWITCHLAND'
EXECUTE InsertCompanies_tbl '45632', 'EASYJET'
EXECUTE InsertCompanies_tbl '54321', 'FLYTO'

-- Insert airplanes
CREATE PROCEDURE InsertAirplanes_tbl(@ApID varchar(10), @CompID varchar(10), @Apseats smallint)
AS
	INSERT INTO Airplanes_tbl(ApID, CompID, Apseats) VALUES (@ApID, @CompID, @Apseats)
GO
EXECUTE InsertAirplanes_tbl '752', '12345', 730
EXECUTE InsertAirplanes_tbl '863', '12578', 730
EXECUTE InsertAirplanes_tbl '593', '98765', 520
EXECUTE InsertAirplanes_tbl '602', '98765', 612
EXECUTE InsertAirplanes_tbl '745', '54321', 435
EXECUTE InsertAirplanes_tbl '809', '54321', 396
EXECUTE InsertAirplanes_tbl '127', '54321', 12
EXECUTE InsertAirplanes_tbl '329', '12345', 740

-- Insert destinations
CREATE PROCEDURE Insertdestinations(@DestID varchar(10), @DestName varchar(10)) 
AS
	INSERT INTO destinations_tbl(DestID, DestName) VALUES (@DestID, @DestName)
GO
EXECUTE Insertdestinations '45', 'Caracas'
EXECUTE Insertdestinations '46', 'TelAviv'
EXECUTE Insertdestinations '43', 'Casablanca'
EXECUTE Insertdestinations '41', 'Madrid'
EXECUTE Insertdestinations '47', 'London'
EXECUTE Insertdestinations '49', 'Amsterdam'
EXECUTE Insertdestinations '48', 'Moscow'
EXECUTE Insertdestinations '42', 'Zurich'

-- Insert flights
CREATE PROCEDURE InsertFlights(@FlID varchar(10), @DestName varchar(10), @ApID varchar(10), @FlPrice smallint, @FlDate date, @FlContinue varchar(10)) 
AS
	INSERT INTO Flights_tbl(FlID, ApID, DestID, FlPrice, FlDate, FlContinue) VALUES (@FlID, @DestName, @ApID, @FlPrice, @FlDate, @FlContinue)
GO
EXECUTE InsertFlights '100', '752', '45', 6100, '11/08/2003', NULL
EXECUTE InsertFlights '101', '809', '46', 6200, '01/06/2010', NULL
EXECUTE InsertFlights '102', '593', '42', 6300, '12/31/2023', NULL
EXECUTE InsertFlights '103', '127', '42', 6400, '05/09/2013', NULL
EXECUTE InsertFlights '104', '745', '47', 6500, '01/24/2015', NULL
EXECUTE InsertFlights '105', '329', '45', 6600, '10/15/2019', NULL
EXECUTE InsertFlights '106', '745', '41', 6700, '05/19/2020', NULL
EXECUTE InsertFlights '107', '863', '43', 6800, '08/06/2003', NULL

-- (Connecting flights were inserted directly into the table)

-- Insert passengers
CREATE PROCEDURE InsertPassengers(@PassID varchar(10), @PassFirstName varchar(10), @PassLastName varchar(10), @PassPhone varchar(10)) 
AS
	INSERT INTO Passengers_tbl(PassID, PassFirstName, PassLastName, PassPhone) VALUES (@PassID, @PassFirstName, @PassLastName, @PassPhone)
GO
EXECUTE InsertPassengers '1234568787', 'Sarah', 'Levi', '0509124587'
EXECUTE InsertPassengers '1225889633', 'David', 'Miller', '0526245879'
EXECUTE InsertPassengers '5847897643', 'Vincent', 'Gogh', '0585252158'
EXECUTE InsertPassengers '1561654554', 'Eyal', 'Gilboa', '0563259814'
EXECUTE InsertPassengers '5648476415', 'Eric', 'Sharon', '0548752165'
EXECUTE InsertPassengers '4557878777', 'Rami', 'Levy', '0527666666'
EXECUTE InsertPassengers '4798794656', 'Eliza', 'Bloom', '0529874545'

-- Insert purchases
CREATE PROCEDURE InsertPurchase(@PurID varchar(10), @FlID varchar(10), @PassID varchar(10), @PurDate date, @PurSeat smallint) 
AS
	INSERT INTO Purchase_tbl(PurID, FlID, PassID, PurDate, PurSeat) VALUES (@PurID, @FlID, @PassID, @PurDate, @PurSeat)
GO
EXECUTE InsertPurchase '1', '100', '1234568787', '04/30/2020', '8'
EXECUTE InsertPurchase '2', '107', '5648476415', '04/20/2005', '3'
EXECUTE InsertPurchase '3', '104', '1561654554', '02/26/2005', '4'
EXECUTE InsertPurchase '4', '101', '1225889633', '09/15/2020', '7'
EXECUTE InsertPurchase '5', '104', '1225889633', '06/19/2007', '9'
EXECUTE InsertPurchase '6', '107', '5847897643', '07/22/2022', '2'
EXECUTE InsertPurchase '7', '102', '4798794656', '03/08/2008', '1'
EXECUTE InsertPurchase '8', '102', '5847897643', '03/08/2008', '5'

--=========================
-- Create an additional procedure
--=========================
-- Copy passengers with >= 2 purchases into VIPPassengers_tbl
CREATE PROCEDURE RemoveVIPPassengers
AS
	INSERT INTO VIPPassengers_tbl
	SELECT PassID, PassFirstName, PassLastName, PassPhone 
	FROM Passengers_tbl
	WHERE PassID IN (
		SELECT DISTINCT PassID 
		FROM Purchase_tbl 
		GROUP BY PassID 
		HAVING COUNT(*) >= 2
	)
GO
EXECUTE RemoveVIPPassengers

---------------	
-- Create VIEW
---------------	
CREATE VIEW UsefullAirplaneDetails -- Show airplane details (only airplanes that appear in Flights)
AS
	SELECT DISTINCT *
	FROM Airplanes_tbl 
	WHERE ApID IN (SELECT ApID FROM Flights_tbl) 
GO

CREATE VIEW CustomerDetails -- Show customer details with their purchase details
AS
	SELECT Pa.*, Pu.PurID, Pu.FlID, Pu.PurDate, PurSeat,
	       ROW_NUMBER() OVER(PARTITION BY Pu.PassID ORDER BY Pu.PassID DESC) AS AmountOfPurchases
	FROM Passengers_tbl Pa 
	JOIN Purchase_tbl Pu ON Pa.PassID = Pu.PassID		
GO

-------------------	
-- Create functions
-------------------
GO
CREATE FUNCTION GetAvgPrice(@minCost smallint) -- Returns average ticket price for flights costing more than the given parameter
RETURNS FLOAT
AS
	BEGIN
		DECLARE @avg float
		SELECT @avg = Avg(FlPrice*1.0) 
		FROM Flights_tbl
		WHERE FlPrice > @minCost 
		RETURN @avg
	END
GO
PRINT dbo.GetAvgPrice(2)		

GO
CREATE FUNCTION GetDetails (@year smallint) -- Details of flights that have a connecting flight + the connecting flight date for the given year
RETURNS @t TABLE(FlID varchar(10), DestName varchar(10), ApID varchar(10), FlPrice smallint, FlDate date, FlContinue varchar(10), DateOfCont date)
AS
	BEGIN
		INSERT INTO @t 
		SELECT F1.*, F2.FlDate AS DateOfCont
		FROM Flights_tbl F1 
		JOIN Flights_tbl F2 -- F1 = flights, F2 = connecting flights
		     ON Year(F1.FlDate) > @year AND F2.FlID = F1.FlContinue
		WHERE F2.FlContinue IS NOT NULL 
		RETURN 
	END
GO
SELECT * FROM GetDetails(2015)

-------------------	
-- Create trigger
-------------------

-- When a buyer attempts to change a flight on a specific date,
-- if the original flight code is 100 (an expensive flight), changes are not allowed.
CREATE TRIGGER ChangeCard ON purchase_tbl
FOR UPDATE
AS
BEGIN
	PRINT 'Trigger fired'
	IF UPDATE(FlID)
	BEGIN
		PRINT 'Ticket holder attempts to change their flight'
		DECLARE @oldDest varchar(15)
		DECLARE @newDest varchar(15)
		SELECT @oldDest = FlID FROM deleted 
		SELECT @newDest = FlID FROM inserted 
		IF @oldDest = '100' OR @newDest = '100' 
		BEGIN
			PRINT 'Ticket holder is not allowed to change their flight'
			ROLLBACK
		END
	END
END

UPDATE purchase_tbl SET FlID = '100' WHERE purDate = '2005-02-26' -- Not allowed to change
UPDATE purchase_tbl SET FlID = '102' WHERE purDate = '2005-02-26' -- Allowed to change
UPDATE purchase_tbl SET FlID = '105' WHERE purDate = '2005-02-26' -- Allowed to change
