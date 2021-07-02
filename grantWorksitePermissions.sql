GRANT SELECT ON dbo.getProjects TO worksiteApp

EXEC sys.sp_setapprole 'worksiteApp',  '(bisoutoudou)'

select * from dbo.getProjects('2021-02-01', '20220101')