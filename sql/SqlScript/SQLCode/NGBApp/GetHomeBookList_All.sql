USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetHomeBookList_All]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie      
-- Create date: 2014-07-09      
-- Description: 根据kid获取ngbapp..homebook所有的家园联系册      
-- Memo:      
[GetHomeBookList_All] 12511    
*/      
--      
CREATE PROC [dbo].[GetHomeBookList_All]      
 @kid int          
AS      
BEGIN                
 SET NOCOUNT ON       
 select h.hbid, h.term, ca.cname, h.cid,ca.grade gradeid     
 from  HomeBook h      
   left join BasicData..class_all ca   
    on h.cid = ca.cid and h.term = ca.term  and ca.deletetag=1
  where h.kid = @kid          
   order by h.CrtDate desc    
       
END 
GO
