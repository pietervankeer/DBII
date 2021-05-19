-- 1. Create a database named Game_db, then refresh your object explorer in SQL Management Studio so that the database is visible. 
-- Then execute the statement USE Game_db to make the database active as the default database.
IF EXISTS DROP DATABASE Game_db

CREATE DATABASE Game_db
USE Game_db

Drop table Game
-- 2. Create the Game table.
CREATE TABLE Game(
		name varchar(20) primary key not null
	)
-- 3. Create the Goalcard table.
CREATE TABLE Goalcard(
		Id varchar(5) not null,
		name varchar(20) null
		)

-- 4. Create the Hallcard table.
CREATE TABLE Hallcard(
		Id varchar(5) not null,
		Type varchar(8) null,
		Treasure varchar(20) null
		)
-- 5. Create the Player table 
	-- The Id column is automagically determined by the database engine
    -- Make sure to add a constraint called CH_Player_Colors so that the Player can only choose a red or black color.
	CREATE TABLE Player(
		Id int identity primary key not null,
		Name varchar(100) not null,
		Birthyear int null,
		Color varchar(10) null,
		CurrentSquare varchar(20) null,
		IsTurnPlayer bit null,
		GameName varchar(20) null,

		constraint CH_Player_Colors check (Color in ('Red', 'Black'))
		)
-- 6. Create the Game_Hallcard table.
	CREATE TABLE Game_Hallcard(
		GameName varchar(20) not null,
		CardId varchar(5) not null,
		Direction varchar(20) null,
		Color varchar(20) null

		constraint PK_GameHallcard primary key(GameName, CardId)
		)
-- 7. Create the Player_Goalcard table.
	CREATE TABLE Player_Goalcard(
		PlayerId int not null,
		GoalId int not null,
		[Order] int null

		constraint PK_GameHallcard primary key(PlayerId, GoalId)
		)
-- 8. Add an extra column Email to the Player entitytype, which is a VARCHAR of max. 50 characters long.
ALTER TABLE Player 
ADD Email varchar(50) NULL
-- 9. Adjust the column Email from the Player entity type to a maximum length of 100 characters.
ALTER TABLE Player
MODIFY COLUMN Email varchar(100) NULL
-- 10. Add an extra column Phonenumber to the Player entity type, which entitytype would be a good fit?
ALTER TABLE Player 
ADD Phonenumber varchar(15) NULL
-- 11. Remove the column Phonenumber fron the Player entity type since we don't need it anymore.
ALTER TABLE Player 
DROP COLUMN Phonenumber