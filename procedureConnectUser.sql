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

	IF DATEDIFF(month, @lastchange, GETDATE()) >= 2
		THROW 50000, 'Password needs to be changed', 1
	-- En cas de succès
	--TODO encryption
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


DECLARE @moncul smallint;
EXECUTE @moncul = dbo.ConnectUser 'ngaly', 'motdepasse'
SELECT @moncul