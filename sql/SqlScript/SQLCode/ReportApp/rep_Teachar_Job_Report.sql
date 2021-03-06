USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_Teachar_Job_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[rep_Teachar_Job_Report] 19731
CREATE PROCEDURE [dbo].[rep_Teachar_Job_Report] 
@kid int
AS

BEGIN
	SET NOCOUNT ON
	
	;WITH CET0 AS
	(
		select DISTINCT t.userid, t.title
			from basicdata..teacher t      
				inner join BasicData..[user] u 
					on u.userid = t.userid
					and u.kid = @kid     
			where u.deletetag = 1 
				and u.usertype >= 1 
	),
	CET1 AS
	(
		select d.Caption, d.OrderBy
			from BasicData..dict_xml d 				
			WHERE d.[Catalog] = '任职类别'
	),
	CET AS
	(
		select isnull(d.Caption,'其他')Caption , isnull(d.OrderBy,19)OrderBy, c.userid
			from CET1 d 
				FULL OUTER join CET0 c
					on d.Caption = c.title 
	)
		
	select Caption as lpost, COUNT(userid) job, OrderBy
		from cet
		group by Caption, OrderBy
	union 
	select '合计', COUNT(userid) job,9999
		from cet
		order by OrderBy
    
    
END    


GO
