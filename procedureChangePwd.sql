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
	IF NOT EXISTS (SELECT 1 FROM Users WHERE login = @userName AND pwd = @oldPwd)
		THROW 60000, 'Old password is wrong', 1;
	UPDATE Users 
	SET pwd =  @newPwd, lastPwdChange = GETDATE(), failedConnections = 0
	WHERE login = @userName

GO


