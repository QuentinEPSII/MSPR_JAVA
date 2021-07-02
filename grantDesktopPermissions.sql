GRANT SELECT ON dbo.getProjects TO desktopApp
EXEC sys.sp_setapprole 'desktopApp', '(calincoquin)'

select * from dbo.getProjects('2021-02-01', '20220101')