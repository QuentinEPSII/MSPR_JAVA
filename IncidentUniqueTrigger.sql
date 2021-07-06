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


--Drop Trigger IncidentUniqueTrigger;