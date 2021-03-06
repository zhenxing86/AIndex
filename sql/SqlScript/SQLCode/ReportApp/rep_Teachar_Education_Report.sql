USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_Teachar_Education_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-25
-- Description:	
-- Memo:		rep_Teachar_Education_Report 14335,''
*/
CREATE PROCEDURE [dbo].[rep_Teachar_Education_Report]    
	@kid int,
	@job varchar(50)    
AS    
BEGIN
	SET NOCOUNT ON
    
		    
	;WITH CET0 AS
	(
		select DISTINCT t.userid, t.education
			from basicdata..teacher t 
				inner join BasicData..[user] u 
					on u.userid = t.userid 
					and u.kid = @kid   
			where u.deletetag = 1 
				and u.usertype = 1
				and t.title like @job+'%'   
	),
	CET1 AS
	(
		select d.Caption, d.OrderBy
			from BasicData..dict_xml d 				
			WHERE d.[Catalog] = '最高学历'
	),
	CET AS
	(
		select isnull(d.Caption,'其他')Caption , isnull(d.OrderBy,33)OrderBy, c.userid
			from CET1 d 
				FULL OUTER join CET0 c
					on d.Caption = c.education 
	)
	select Caption as lpost, COUNT(userid) job, OrderBy
		from cet 
		group by Caption, OrderBy having COUNT(userid)>0
	union 
	select '合计', COUNT(userid) job,9999
		from cet
		order by OrderBy
    
    
END    

GO
