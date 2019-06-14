USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[questions_GetModel]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
-- exec [questions_GetModel] 1    
CREATE proc [dbo].[questions_GetModel]    
@id int    
as    
begin    
select  q.id,q.title,q.describe,c.categorytitle,q.categoryid  from Questions q left join category c on q.categoryid=c.id where q.id=@id and q.deletetag=1    
end 
GO
