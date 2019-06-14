USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetTermList_All]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie      
-- Create date: 2014-07-09      
-- Description: 根据kid获取所有的学期     
-- Memo:      
[GetTermList_All] 12511    
*/      
--      
CREATE PROC [dbo].[GetTermList_All]      
 @kid int          
AS      
BEGIN                
 SET NOCOUNT ON       
 select distinct term 
 from BasicData..class_all
  where kid = @kid  
  order by term desc        
       
END 


GO
