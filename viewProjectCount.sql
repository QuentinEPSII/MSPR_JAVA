CREATE VIEW projectCount AS 
SELECT count(*) nombre, year(startDate) ann�e, month(endDate) mois
	FROM Projects p
	GROUP BY year(startDate), month(endDate)

select * from projectCount

-- penser � l'attribuer � 'deskotpApp'