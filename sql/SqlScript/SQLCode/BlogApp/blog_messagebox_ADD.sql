USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：增加短消息 
--项目名称：zgyeyblog
--说明：
--时间：2008-11-4 17:19:51
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_ADD]
@touserid int,
@fromuserid int,
@msgtitle nvarchar(30),
@msgcontent ntext,
@viewstatus int

 AS 

	declare @btouserid int
    declare @bfromuserid int

    select @btouserid=userid from basicdata..user_bloguser where bloguserid=@touserid
	select @bfromuserid=userid from basicdata..user_bloguser where bloguserid=@fromuserid
  
  --Insert Into basicdata.[dbo].[FriendSMS](userid, touserid, msgtype, msgcon, crtdate, isread, deletetag)
  --  Select @bfromuserid, @btouserid, 2, @msgcontent, getdate(), 0, 1

	INSERT INTO msgapp..blog_messagebox(
	[touserid],[fromuserid],[msgtitle],[msgcontent],[sendtime],[viewstatus],parentid,deletetag,deletetagmy
	)VALUES(
	@btouserid,@bfromuserid,@msgtitle,@msgcontent,getdate(),@viewstatus,0,1,1
	)
	DECLARE @messageboxid int
	SET @messageboxid=@@identity
	
	
	--DECLARE @fromname nvarchar(50),@toname nvarchar(50),@description nvarchar(300)
	--SELECT @fromname=nickname FROM blog_user WHERE userid=@fromuserid
	--SELECT @toname=nickname FROM blog_user WHERE userid=@touserid
	--SET @description='给<a href="http://blog.zgyey.com/'+CAST(@touserid AS nvarchar(20))+'/index.html" target="_blank">'+@toname+'</a> 发了短信 "'+@msgtitle+'"'

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
		--EXEC sys_actionlogs_ADD @fromuserid,@fromname,@description ,'8',0,0,0
	   RETURN (@messageboxid)
	END


--
--select * from msgapp..blog_messagebox where parentid is null order by messageboxid desc
--
--update msgapp..blog_messagebox set parentid=0,deletetag=1 ,deletetagmy=1 where parentid is null


GO
