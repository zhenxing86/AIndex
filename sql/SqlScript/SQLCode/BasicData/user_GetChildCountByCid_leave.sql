USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildCountByCid_leave]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
/*      
-- Author:      Master谭      
-- Create date: 2013-08-01      
-- Description:  得到幼儿列表     
-- Memo:      
user_GetChildByCid_leave 46144    
*/    
------------------------------------    
--用途：得到幼儿数     
--项目名称：    
--说明：    
--时间：2011-5-20 16:57:46    
------------------------------------    
CREATE PROCEDURE [dbo].[user_GetChildCountByCid_leave]    
@cid int    
 AS     
 declare @count int    
 SELECT    
  @count=COUNT(1)    
 FROM    
  [user] t1     
  left join leave_user_class t3 on t1.userid=t3.userid    
 WHERE    
  t1.usertype=0   and t3.cid=@cid    
  and t3.userid is not null    
  and t1.deletetag=1    
 RETURN @count 
GO
