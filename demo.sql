


-- Vues

Select * from projectsAfterDate -- 25 janvier 2021
Select * from projectInfo	-- projet n° 2
Select * from projectCount2021 
Select * from businessCountPerProjectAndProfession 


-- Procédures 

SELECT * FROM Users

EXEC CreateUser 'C', 'Nom', 'Prenom', 1
EXEC CreateUser 'I', 'Name', 'FirstName', 2

SELECT * FROM Users


EXEC ConnectUser 'I2021_FiNa', 'I2021_FiNa'

EXEC ChangePwd 'I2021_FiNa', 'I2021_FiNa', 'P@ssword1'

SELECT * FROM Users WHERE login = 'I2021_FiNa'

EXEC ConnectUser 'I2021_FiNa', 'P@ssword1'
EXEC ConnectUser 'I2021_FiNa', 'wrongPassword'

EXEC UnlockUser 'I2021_FiNa'

Select dbo.checkAuthorization('I2021_FiNa', 1)
Select dbo.checkAuthorization('I2021_FiNa', 2)







-- Fonctions

select * from dbo.getProjects('2021-02-01', '2022-01-01')


-- Trigger

SELECT * From Incident i
JOIN Video v ON i.idVideo = v.id


INSERT INTO Incident(idVideo, description, type) VALUES (3, 'Un café renversé', 1);
INSERT INTO Incident(idVideo, description, type) VALUES (3, 'Un café renversé', 2);









-- Autorisations

DECLARE @cookie varbinary(8000);
EXEC sys.sp_setapprole 'worksiteApp',  '(mobileApp)', @fCreateCookie = true, @cookie = @cookie OUTPUT

select * from dbo.getProjects('2021-02-01', '2022-01-01')
EXEC CreateUser 'C', 'nom', 'prenom', 1

EXEC sys.sp_unsetapprole @cookie


DECLARE @cookie2 varbinary(8000);
EXEC sys.sp_setapprole 'desktopApp', '(desktopApp)', @fCreateCookie = true, @cookie = @cookie2 OUTPUT

select * from dbo.getProjects('2021-02-01', '20220101')
EXEC CreateUser 'C', 'nom', 'prenom', 1
Select * FROM Users

EXEC sys.sp_unsetapprole @cookie2

