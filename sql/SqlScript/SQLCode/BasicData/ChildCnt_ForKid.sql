USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE VIEW ChildCnt_ForKid    
AS    
 SELECT kid, count(userid) Totalcnt    
  FROM BasicData.dbo.User_Child    
   where grade <> 38      
 GROUP BY kid    
 GO
