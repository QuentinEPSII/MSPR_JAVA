CREATE PROCEDURE affectUser 
    @userName nvarchar(255), 
    @ChantierId int
AS 
INSERT INTO Users_Worksite(idWorksite, idUser) values @ChantierId, @userName);

--DROP Procedure affectUser;