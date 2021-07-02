;CREATE FUNCTION dbo.getProjects (@startDate as DATE, @endDate as DATE)
RETURNS @retProjects TABLE
(
    temporayTableID INT IDENTITY,
    projectName nvarchar(255) NOT NULL,
    businessName nvarchar(255) NOT NULL,
    worksiteLongitude decimal NOT NULL,
    worksiteLatitude decimal NOT NULL,
	projectStartDate DATE NOT NULL,
	projectEndDate DATE
) 
AS
BEGIN
	WITH commonTableExpression 
		AS 
		(
			SELECT p.name projectName, w.longitude worksiteLongitude, w.latitude worksiteLatitude, b.name businessName, p.startDate projectStartDate, p.endDate projectEndDate
			FROM Projects p
				JOIN BusinessProject bp ON p.id = bp.idProject
				JOIN Business b ON b.siret = bp.idBusiness
				JOIN Worksite w ON w.id = p.idWorksite
				WHERE p.startDate >= @startDate AND  p.endDate <= @endDate
		)
		INSERT @retProjects(projectName, businessName, worksiteLongitude, worksiteLatitude, projectStartDate, projectEndDate)
		SELECT projectName, businessName, worksiteLongitude, worksiteLatitude, projectStartDate, projectEndDate
		FROM commonTableExpression

	RETURN
END;


GO
select * from dbo.getProjets('2021-02-01', '20220101')
ORDER BY projectName, projectStartDate


drop function dbo.getProjets;