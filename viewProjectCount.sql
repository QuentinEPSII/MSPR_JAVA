CREATE VIEW projectCount2021 AS 
SELECT count(*) nombre
	FROM Projects p
	WHERE year(p.startDate) = 2021
	

GO
select * from projectCount2021

-- penser à l'attribuer à 'deskotpApp'