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
				VALUES (@login, @Prenom, @Nom, @login, 0, @annee);
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


--EXEC CreateUser 'C', 'Galy', 'Nicolas', 2;