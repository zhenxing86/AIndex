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
CREATE VIEW TeacherCnt_ForKid    
AS    
 SELECT kid, count(userid) Totalcnt    
  FROM BasicData.dbo.User_Teacher  
 GROUP BY kid    
 GO
