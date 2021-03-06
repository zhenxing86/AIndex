USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetSendBoxCount]    Script Date: 05/14/2013 14:54:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到发件箱短信数 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-14 17:30:33
------------------------------------
alter PROCEDURE [dbo].[blog_messagebox_GetSendBoxCount]
@userid int
 AS
 
  
 
DECLARE @messageboxcount int
 SELECT @messageboxcount=count(1) from BasicData.dbo.FriendSMS fs  
   inner join BasicData..[user] u   
    on fs.touserid = u.userid  
   inner join BasicData..user_bloguser ub
    on fs.touserid = ub.userid
  where fs.Userid = @userid
 
 RETURN @messageboxcount
GO
