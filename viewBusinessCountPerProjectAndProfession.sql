CREATE VIEW businessCountPerProjectAndProfession As
	SELECT p.name, b.profession, count(*) number
	FROM Projects p
		JOIN Worksite w ON w.id = p.idWorksite
		JOIN BusinessProject bp ON bp.idProject = p.id
		JOIN Business b ON b.siret = bp.idBusiness
		GROUP BY p.name, b.profession