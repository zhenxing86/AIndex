USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetAllReadCount]    Script Date: 05/14/2013 14:54:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------

alter PROCEDURE [dbo].[blog_messagebox_GetAllReadCount]
@userid int
 AS
 
 declare @messageboxcount int
 select @messageboxcount=count(1) from BasicData..FriendSMS fs  
   inner join BasicData..[user] u   
    on fs.userid = u.userid 
   inner join BasicData..user_bloguser ub
    on fs.userid = ub.userid
  where fs.touserid = @userid
    and fs.deletetag = 1
 
 
 
	RETURN @messageboxcount
GO
