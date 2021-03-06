USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpaper_GetModel]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [testpaper_GetModel] 2  
CREATE proc [dbo].[testpaper_GetModel]        
@id int        
as        
begin        
select  t.id,t.title,p.describe,t.grade,precontent,p.pushdatetime,  
( select col1                
    from CommonFun.dbo.fn_MutiSplitTSQL(url,'/',',')  where col1 like 'v%' ) issue  
 from TestPager t   
left join push p on t.id=p.testid  
 where t.id=@id and t.deletetag=1        
end 
GO
