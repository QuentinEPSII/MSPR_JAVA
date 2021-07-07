

-- Autorisations
DECLARE @cookie varbinary(8000);
EXEC sys.sp_setapprole 'worksiteApp',  '(mobileApp)', @fCreateCookie = true, @cookie = @cookie OUTPUT

select * from dbo.getProjects('2021-02-01', '20220101')
EXEC CreateUser 'C', 'nom', 'prenom', 1

EXEC sys.sp_unsetapprole @cookie


DECLARE @cookie2 varbinary(8000);
EXEC sys.sp_setapprole 'desktopApp', '(desktopApp)', @fCreateCookie = true, @cookie = @cookie2 OUTPUT

select * from dbo.getProjects('2021-02-01', '20220101')
EXEC CreateUser 'C', 'nom', 'prenom', 1
Select * FROM Users

EXEC sys.sp_unsetapprole @cookie2

