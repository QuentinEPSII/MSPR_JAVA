CREATE VIEW projectsAfterDate AS
	SELECT name, startDate, endDate 
		FROM Projects p
		WHERE startDate >= '20210125'

GO 
select * from projectsAfterDate