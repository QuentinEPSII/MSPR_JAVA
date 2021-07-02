CREATE VIEW projectCount AS 
SELECT count(*) nombre, year(startDate) année, month(endDate) mois
	FROM Projects p
	GROUP BY year(startDate), month(endDate)

select * from projectCount

-- penser à l'attribuer à 'deskotpApp'