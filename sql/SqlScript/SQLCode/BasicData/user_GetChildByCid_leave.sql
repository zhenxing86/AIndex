USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildByCid_leave]    Script Date: 2014/11/24 21:18:47 ******/
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
CREATE PROCEDURE [dbo].[user_GetChildByCid_leave]  
 @cid int  
AS  
BEGIN    
 SET NOCOUNT ON  
 SELECT u.userid, u.account, u.name, u.gender, u.mobile ,lk.leavereason   
  FROM [user] u  
   left join leave_kindergarten lk on u.userid = lk.userid  
   left join leave_user_class luc on u.userid = luc.userid
  WHERE u.usertype = 0    
   and luc.cid = @cid   
   and lk.userid is not null  
   and u.deletetag=1  
  ORDER BY u.userid DESC  
END  
GO
