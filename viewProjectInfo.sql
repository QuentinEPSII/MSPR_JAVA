CREATE VIEW projectInfo AS
	SELECT w.name worksiteName, b.name businessName, b.profession businessProfession, v.video
	FROM Projects p
		JOIN Worksite w ON w.id = p.idWorksite
		JOIN BusinessProject bp ON bp.idProject = p.id
		JOIN Business b ON b.siret = bp.idBusiness
		JOIN Video v ON v.idProject = p.id
		WHERE p.id = 2

-- manque la colonne lien vers matterport3D
