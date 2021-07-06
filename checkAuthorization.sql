CREATE PROCEDURE checkAuthorization 
    @userName nvarchar(255), 
    @ChantierId int
AS 
DECLARE @authorization bit;
DECLARE @idUserName INT;
SET @authorization = 0;

IF EXISTS (SELECT idUser from dbo.Users_Worksite where idWorksite = @ChantierId and idUser = @userName)
	SET @authorization = 1;

RETURN @authorization;

--DROP Procedure checkAuthorization;