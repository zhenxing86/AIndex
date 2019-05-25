USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[push_GetModel]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[push_GetModel]        
@id int        
as        
begin      
       
    select ID,title,describe,addtime,grade,url,( select col1                
    from CommonFun.dbo.fn_MutiSplitTSQL(url,'/',',')  where col1 like 'v%' ) issue,categoryid,pushdatetime from push where id=@id        
end    
GO
