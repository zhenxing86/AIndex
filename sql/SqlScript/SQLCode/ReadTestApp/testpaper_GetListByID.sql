USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpaper_GetListByID]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
-- =============================================      
 
/*      
memo: exec [testpaper_GetListByID] 1
*/      
-- =============================================      
CREATE PROCEDURE [dbo].[testpaper_GetListByID]      
@id int
AS            
BEGIN     
select q.id,q.title,p.title as testpapertitle from Questions q left join TestPager p on q.testid=p.id where p.id=@id and p.deletetag=1 and q.deletetag=1
     
 
 
END 

GO
