USE mspr_java;

DROP TABLE BusinessIncident;
DROP TABLE Users_Worksite;
DROP TABLE BusinessProject;
DROP TABLE Incident;
DROP TABLE Video;
DROP TABLE Projects;
DROP TABLE Worksite;
DROP TABLE Users;
DROP TABLE Business;

DROP APPLICATION ROLE worksiteApp
DROP APPLICATION ROLE desktopApp 

CREATE TABLE Users (
	login nvarchar(255) PRIMARY KEY,
	firstname nvarchar(255),
	lastname nvarchar(255),
    pwd nvarchar(255),
    rights nvarchar(255),
    isBlocked bit,
    failedConnections smallint NOT NULL,
    yearStart nvarchar(255),   
    lastPwdChange DATE
);

CREATE TABLE Worksite (
	id INT NOT NULL,
	latitude DECIMAL,
    longitude DECIMAL,
    name nvarchar(255),
    startDate DATE,
    endDate DATE,
	PRIMARY KEY(id)
);

CREATE TABLE Projects (
	id INT NOT NULL,
	startDate date,
    endDate date,
	idWorksite INT,
	name nvarchar(255),
	PRIMARY KEY(id),
    CONSTRAINT Project_Worksite_FK FOREIGN KEY (idWorksite) REFERENCES Worksite(id)
);

CREATE TABLE Video (
	id INT NOT NULL,
    idProject INT,
	name nvarchar(255),
    refGant INT,
    indoor bit,
    latitude DECIMAL,
    longitude DECIMAL,
    video nvarchar(255),
    date DATE,
	PRIMARY KEY(id),
    CONSTRAINT Video_Project_FK FOREIGN KEY (idProject) REFERENCES Projects(id)
);

CREATE TABLE Incident (
	id INT IDENTITY(1,1),
    idVideo INT NOT NULL,
    type nvarchar(255),
	description nvarchar(255),
	PRIMARY KEY(id),
    CONSTRAINT Incident_Video_FK FOREIGN KEY (idVideo) REFERENCES Video(id)
);

CREATE TABLE Users_Worksite (
	idWorksite INT NOT NULL,
	idUser nvarchar(255) NOT NULL,
	PRIMARY KEY(idWorksite, idUser),
    CONSTRAINT UserWorksite_User_FK FOREIGN KEY (idUser) REFERENCES Users(login),
    CONSTRAINT UserWorksite_Worksite_FK FOREIGN KEY (idWorksite) REFERENCES Worksite(id)
);

CREATE TABLE Business (
	siret INT NOT NULL,
    profession nvarchar(255),
    name nvarchar(255),
    address nvarchar(255),
    employees INT,
    phone nvarchar(16),
    mail nvarchar(255),
	description nvarchar(255),
	PRIMARY KEY(siret)
);

CREATE TABLE BusinessIncident (
	idIncident INT NOT NULL,
    idBusiness INT NOT NULL,
	PRIMARY KEY(idIncident, idBusiness),
    CONSTRAINT BusinessIncident_Incident_FK FOREIGN KEY (idIncident) REFERENCES Incident(id),
    CONSTRAINT BusinessIncident_Business_FK FOREIGN KEY (idBusiness) REFERENCES Business(siret)
);

CREATE TABLE BusinessProject (
	idBusiness INT NOT NULL,
    idProject INT NOT NULL,
	PRIMARY KEY(idBusiness, idProject),
    CONSTRAINT BusinessProject_Business_FK FOREIGN KEY (idBusiness) REFERENCES Business(siret),
    CONSTRAINT BusinessProject_Project_FK FOREIGN KEY (idProject) REFERENCES Projects(id)
);


--insert into Worksite(latitude, longitude, name, startDate, endDate) values ('-33.867886', '-63.987', 'Guitare', '2012-21-10', '2012-21-12');


insert into Users(login, firstname, lastname, pwd, rights, yearStart, failedConnections) values ('fpouchan', 'Frédéric',  'Pouchan', HASHBYTES('SHA2_256', 'motdepasse'), 'ADMIN', 2012, 0);
insert into Users(login, firstname, lastname, pwd, rights, yearStart, failedConnections) values ('qgeorghioui',  'Quentin', HASHBYTES('SHA2_256', 'motdepasse'), 'GEORGHIOU', 'ADMIN', 2012, 0);
insert into Users(login, firstname, lastname, pwd, rights, yearStart, failedConnections) values ('ngaly', 'Nicolas',  'Galy', HASHBYTES('SHA2_256', 'motdepasse'), 'ADMIN', 2012, 0);
insert into Users(login, firstname, lastname, pwd, rights, yearStart, failedConnections) values ('dcerna', 'David',  'Cerna', HASHBYTES('SHA2_256', 'motdepasse'),'ADMIN', 2012, 0);
insert into Users(login, firstname, lastname, pwd, rights, yearStart, failedConnections) values ('llarbin', 'Larbin', 'larbin', HASHBYTES('SHA2_256', 'motdepasse'), 'USER', 2010, 0);

insert into Worksite(id, latitude, longitude, name, startDate, endDate) values (1, '45.186973698061685', '5.7770144356323145', 'EPSI GRENOBLE', '2013-07-05', '2014-11-14');
insert into Worksite(id, latitude, longitude, name, startDate, endDate) values (2, '33.747252', '112.633853', 'Triangle', '2012-10-10', '2012-11-10');
insert into Worksite(id, latitude, longitude, name, startDate, endDate) values (3, '-33.867886', '-63.987', 'Guitare', '2012-12-21', '2012-12-27');

insert into Projects(id, startDate, endDate, idWorksite, name) values (1, '2021-01-01', '2021-12-31', 1, 'Projet N°1');
insert into Projects(id, startDate, endDate, idWorksite, name) values (2, '2021-02-01', '2021-12-31', 2, 'Projet N°2');
insert into Projects(id, startDate, endDate, idWorksite, name) values (3, '2021-03-01', '2021-12-31', 3, 'Projet N°3');
insert into Projects(id, startDate, endDate, idWorksite, name) values (4, '2020-01-01', '2020-12-31', 1, 'Projet N°4');
insert into Projects(id, startDate, endDate, idWorksite, name) values (5, '2019-02-14', '2020-10-10', 2, 'Projet N°5');
insert into Projects(id, startDate, endDate, idWorksite, name) values (6, '2020-03-03', '2021-08-01', 3, 'Projet N°6');
insert into Projects(id, startDate, endDate, idWorksite, name) values (7, '2017-01-05', '2018-12-31', 1, 'Projet N°7');
insert into Projects(id, startDate, endDate, idWorksite, name) values (8, '2020-02-13', '2021-12-04', 2, 'Projet N°8');
insert into Projects(id, startDate, endDate, idWorksite, name) values (9, '2013-03-20', '2021-02-25', 3, 'Projet N°9'); 

insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (1, 1, 'Video test N°1 EPSI GRENOBLE', 42, 1, '45.186973698061685', '5.7770144356323145', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (2, 1, 'Video test N°2 Triangle', 27, 0, '33.747252', '112.633853', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (3, 3, 'Video test N°3 Guitare', 12, 1, '-33.867886', '-63.987', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (4, 3, 'Video test N°4 Rien de fou', 12, 1, '-33.867886', '-63.987', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
insert into Video(id, idProject, name, refGant, indoor, latitude, longitude, video) values (5, 2, 'Video test N°5 Toujours rien de fou', 12, 1, '-33.867886', '-63.987', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');

INSERT INTO Incident(idVideo, description) VALUES (1, 'Une description où je ne sais pas vraiment quoi dire');
INSERT INTO Incident(idVideo, description) VALUES (2, 'Il y a eu un gros incident la wow');
INSERT INTO Incident(idVideo, description) VALUES (3, 'Un café renversé');

insert into Users_Worksite(idWorksite, idUser) values (1, 'fpouchan');
insert into Users_Worksite(idWorksite, idUser) values (2, 'qgeorghioui');
insert into Users_Worksite(idWorksite, idUser) values (3, 'ngaly');

insert into Business(siret, name, address, employees, phone, mail, description) values (123456789, 'Business N°1', '42 rue de la vérité', 125, '+33654124152', 'emaildetest@test.com', 'Super business qui rapporte beaucoup de thunes');
insert into Business(siret, name, address, employees, phone, mail, description) values (987654321, 'Business N°2', '4h20 rue du plaisir', 142, '+33420420420', 'emaildetest2@test.com', 'Business qui respect ses employés');
insert into Business(siret, name, address, employees, phone, mail, description) values (123456780, 'Business N°3', '69 j''ai plus d''inspi', 158, '+33654124152', 'emaildetest3@test.com', 'Super business qui rapporte beaucoup de thunes');

INSERT INTO BusinessProject VALUES (123456789, 1)
INSERT INTO BusinessProject VALUES (123456789, 3)
INSERT INTO BusinessProject VALUES (987654321, 3)
INSERT INTO BusinessProject VALUES (987654321, 2)
INSERT INTO BusinessProject VALUES (123456780, 2)

insert into BusinessIncident(idIncident, idBusiness) values (1, 123456789);
insert into BusinessIncident(idIncident, idBusiness) values (2, 987654321);
insert into BusinessIncident(idIncident, idBusiness) values (3, 123456780);


GO
----------------------------- Vues -------------------------------
CREATE OR ALTER VIEW projectsAfterDate AS
	SELECT name, startDate, endDate 
		FROM Projects p
		WHERE startDate >= '20210125';

GO

CREATE OR ALTER VIEW projectInfo AS
	SELECT w.name worksiteName, b.name businessName, b.profession businessProfession, v.video
	FROM Projects p
		JOIN Worksite w ON w.id = p.idWorksite
		JOIN BusinessProject bp ON bp.idProject = p.id
		JOIN Business b ON b.siret = bp.idBusiness
		JOIN Video v ON v.idProject = p.id
		WHERE p.id = 2
GO

CREATE OR ALTER VIEW projectCount2021 AS 
SELECT count(*) nombre
	FROM Projects p
	WHERE year(p.startDate) = 2021
	
GO
CREATE OR ALTER VIEW businessCountPerProjectAndProfession As
	SELECT p.name, b.profession, count(*) number
	FROM Projects p
		JOIN Worksite w ON w.id = p.idWorksite
		JOIN BusinessProject bp ON bp.idProject = p.id
		JOIN Business b ON b.siret = bp.idBusiness
		GROUP BY p.name, b.profession
GO


----------------------------- Fonctions -------------------------------

CREATE OR ALTER FUNCTION dbo.getProjects (@startDate as DATE, @endDate as DATE)
RETURNS @retProjects TABLE
(
    temporayTableID INT IDENTITY,
    projectName nvarchar(255) NOT NULL,
    businessName nvarchar(255) NOT NULL,
    worksiteLongitude decimal NOT NULL,
    worksiteLatitude decimal NOT NULL,
	projectStartDate DATE NOT NULL,
	projectEndDate DATE
) 
AS
BEGIN
	WITH commonTableExpression 
		AS 
		(
			SELECT p.name projectName, w.longitude worksiteLongitude, w.latitude worksiteLatitude, b.name businessName, p.startDate projectStartDate, p.endDate projectEndDate
			FROM Projects p
				JOIN BusinessProject bp ON p.id = bp.idProject
				JOIN Business b ON b.siret = bp.idBusiness
				JOIN Worksite w ON w.id = p.idWorksite
				WHERE p.startDate >= @startDate AND  p.endDate <= @endDate
		)
		INSERT @retProjects(projectName, businessName, worksiteLongitude, worksiteLatitude, projectStartDate, projectEndDate)
		SELECT projectName, businessName, worksiteLongitude, worksiteLatitude, projectStartDate, projectEndDate
		FROM commonTableExpression

	RETURN
END;

GO

CREATE OR ALTER FUNCTION checkPwd (@password nvarchar(255))
RETURNS BIT
AS
BEGIN 
-- TODO implement other rules
	IF LEN(@password) < 8
		RETURN 1
	RETURN 0
END;

GO



----------------------------- Procédures ------------------------------

CREATE OR ALTER PROCEDURE CreateUser 
	@CodeApplication char(1),
	@Nom nvarchar(255),
	@Prenom nvarchar(255),
	@ChantierId int
AS
	SET NOCOUNT ON;
	DECLARE @login NVARCHAR(50), @annee INT;
	SET @annee = YEAR(GETDATE())
	SET @login = CONCAT(@CodeApplication, @annee , '_', SUBSTRING(@Prenom, 1, 2), SUBSTRING(@Nom, 1, 2));
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Users (login, firstname, lastname, pwd, failedConnections, yearStart)
				VALUES (@login, @Prenom, @Nom, HASHBYTES('SHA2_256', @login), 0, @annee);
			INSERT INTO Users_Worksite (idUser, idWorksite)
				VALUES(@login, @ChantierId)
		COMMIT
		RETURN 1
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK
		RETURN 0
	END CATCH;

GO

CREATE OR ALTER PROCEDURE ConnectUser 
	@username nvarchar(255),
	@pwd nvarchar(255)
AS
	DECLARE @lastchange Date, 
		@isBlocked bit, 
		@password nvarchar(255), 
		@failedConnections smallint;

	SELECT @lastChange= lastPwdChange, @isBlocked = isBlocked, @password = pwd, @failedConnections = failedConnections
	FROM Users WHERE @username = login

	IF @isBlocked = 1
		THROW 50000, 'Account is blocked. Please contact an administrator', 1
		
	IF DATEDIFF(month, @lastchange, GETDATE()) >= 2
		THROW 50000, 'Password needs to be changed', 1


	-- En cas de succès
	IF HASHBYTES('SHA2_256', @pwd) = @password
		BEGIN
		UPDATE Users
		SET failedConnections = 0
		WHERE login = @username
		RETURN 0
		END;
	-- En cas d'échec
	ELSE
		BEGIN
		UPDATE Users 
		SET failedConnections = failedConnections + 1
		WHERE login = @username
		IF (SELECT failedConnections FROM Users WHERE @username = login) >= 3
			UPDATE Users
			SET isBlocked = 1
			WHERE login = @username
		RETURN 1;
		END;

GO

CREATE OR ALTER PROCEDURE checkAuthorization 
    @userName nvarchar(255), 
    @ChantierId int
AS 
DECLARE @authorization bit;
DECLARE @idUserName INT;
SET @authorization = 0;

IF EXISTS (SELECT idUser from dbo.Users_Worksite where idWorksite = @ChantierId and idUser = @userName)
	SET @authorization = 1;

RETURN @authorization;


GO

CREATE OR ALTER PROCEDURE UnlockUser (@username nvarchar)
AS
	UPDATE Users
	SET isBlocked = 0, failedConnections = 0
	WHERE login = @username

GO

CREATE OR ALTER FUNCTION checkPwd (@password nvarchar(255))
RETURNS BIT
AS
BEGIN 
-- TODO implement other rules
	IF LEN(@password) < 8
		RETURN 1
	RETURN 0
END;

GO

CREATE OR ALTER PROCEDURE UnlockUser (@username nvarchar(255))
AS
	UPDATE Users
	SET isBlocked = 0, failedConnections = 0
	WHERE login = @username

GO


CREATE OR ALTER FUNCTION checkPwd (@password nvarchar(255))
RETURNS BIT
AS
BEGIN 
-- TODO implement other rules
	IF LEN(@password) < 8
		RETURN 1
	RETURN 0
END;

GO

CREATE OR ALTER PROCEDURE UnlockUser (@username nvarchar)
AS
	UPDATE Users
	SET isBlocked = 0, failedConnections = 0
	WHERE login = @username

GO


CREATE OR ALTER PROCEDURE ChangePwd @userName nvarchar(255), @oldPwd nvarchar(255), @newPwd nvarchar(255)
AS 
	IF @newPwd = @userName
		THROW 60000, 'Password and login shouldn''t be identical', 1;
	IF @newPwd = @oldPwd
		THROW 60000, 'new and old passwords shouldn''t be identical', 1;
	IF dbo.checkPwd(@newPwd) = 1
		THROW 60000, 'Password is too weak', 1;
	IF NOT EXISTS (SELECT 1 FROM Users WHERE login = @userName AND pwd =  HASHBYTES('SHA2_256', @oldPwd))
		THROW 60000, 'Old password is wrong', 1;
	UPDATE Users 
	SET pwd =  HASHBYTES('SHA2_256', @newPwd), lastPwdChange = GETDATE(), failedConnections = 0
	WHERE login = @userName

GO
CREATE OR ALTER PROCEDURE affectUser 
    @userName nvarchar(255), 
    @ChantierId int
AS 
INSERT INTO Users_Worksite(idWorksite, idUser) values (@ChantierId, @userName);

GO



----------------------------- Triggers --------------------------------

CREATE OR ALTER TRIGGER IncidentUniqueTrigger ON dbo.Incident
INSTEAD OF INSERT  
AS  

DECLARE @typeInsert nvarchar(255);
DECLARE @DateInsert Date;
DECLARE @DateCastInsert nvarchar(255);

SET @TypeInsert = (SELECT type from inserted);
SET @DateInsert = (SELECT date from dbo.Video where id = (SELECT idVideo from inserted));
SET @DateCastInsert = CAST(@DateInsert as nvarchar(255));

IF EXISTS (SELECT type from dbo.Incident i join dbo.Video v ON v.id = i.idVideo where type = @TypeInsert and v.date = @DateInsert)
	BEGIN

	RAISERROR ('Attention, un incident du type '' %s '' a déjà été renseigné pour à la date suivante : %s ', 16, 1, @TypeInsert, @DateCastInsert);  
	RETURN;
	END;
ELSE
	BEGIN
	INSERT INTO dbo.Incident(idVideo, type, description) SELECT idVideo, type, description from inserted
	END;
GO 



----------------------------- Application roles --------------------------------
GO
CREATE APPLICATION ROLE worksiteApp WITH PASSWORD = '(mobileApp)'
CREATE APPLICATION ROLE desktopApp WITH PASSWORD = '(desktopApp)'





----------------------------- Permissions --------------------------------
GRANT SELECT ON dbo.getProjects TO worksiteApp
