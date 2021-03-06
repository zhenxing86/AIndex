USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_GetUserRelation]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：判断第二用户是不是第一个用户的本园老师、本班老师、本园家长、本班家长
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-11-24 17:30:07
------------------------------------
CREATE PROCEDURE [dbo].[blog_GetUserRelation]
@firstuserid int,
@seconduserid int,
@type int
 AS
--RETURN (0)


	IF (NOT EXISTS(SELECT 1 FROM BasicData.dbo.user_bloguser WHERE bloguserid=@firstuserid) or NOT EXISTS(SELECT 1 FROM BasicData.dbo.user_bloguser WHERE bloguserid=@seconduserid))
	BEGIN
		RETURN (0)
	END
	IF(@firstuserid=@seconduserid)
	BEGIN
		RETURN (1)
	END

	DECLARE @returnvalue int
	DECLARE @kid int
	DECLARE @firstkmpuserid int
	DECLARE @secondkmpuserid int
	DECLARE @firstusertype int
	DECLARE @secondusertype int
	DECLARE @classid int
	SELECT @firstusertype=t1.usertype,@firstkmpuserid=t1.userid 
	FROM BasicData.dbo.[user] t1 
	inner join BasicData.dbo.user_bloguser t2 
	on t1.userid=t2.userid 
	WHERE t2.bloguserid=@firstuserid
	SELECT @secondusertype=t1.usertype,@secondkmpuserid=t1.userid FROM BasicData.dbo.[user] t1 inner join BasicData.dbo.user_bloguser t2 on t1.userid=t2.userid WHERE t2.bloguserid=@seconduserid

	select @kid=kid from BasicData.dbo.[user] where userid=@firstkmpuserid
	select top 1 @classid=cid from BasicData.dbo.user_class where userid=@firstkmpuserid
	

	IF(@type=1)
	BEGIN
		IF EXISTS(SELECT * FROM BasicData.dbo.[user] t1
		                   WHERE userid=@secondkmpuserid
		                     AND kid=@kid
		                     and usertype>0)	
		BEGIN
			SET @returnvalue=1
		END
		ELSE
		BEGIN
			SET @returnvalue=0
		END
	END
	ELSE IF(@type=2)
	BEGIN
		IF(@firstusertype>0)
		BEGIN
			IF EXISTS(SELECT 1 FROM BasicData.dbo.user_class t1 inner join BasicData.dbo.user_class t2 on t1.cid=t2.cid inner join BasicData.dbo.[user] t3 on t1.userid=t3.userid  WHERE t1.userid=@secondkmpuserid and t2.userid=@firstkmpuserid and t3.usertype>0 )
			BEGIN
				SET @returnvalue=1
			END
			ELSE
			BEGIN
				SET @returnvalue=0
			END
		END
		ELSE
		BEGIN
			IF EXISTS(SELECT 1 FROM BasicData.dbo.user_class t1 inner join BasicData.dbo.[user] t2 on t1.userid=t2.userid WHERE t1.userid=@secondkmpuserid and t1.cid=@classid and t2.usertype>0)
			BEGIN
				SET @returnvalue=1
			END
			ELSE
			BEGIN
				SET @returnvalue=0
			END
		END
	END
	ELSE IF(@type=3)
	BEGIN
		IF EXISTS(SELECT 1 FROM BasicData.dbo.[user] t1 WHERE userid=@secondkmpuserid and usertype=0 AND kid=@kid)	
		BEGIN
			SET @returnvalue=1
		END
		ELSE
		BEGIN
			SET @returnvalue=0
		END
	END
	ELSE 
	BEGIN
		IF(@firstusertype>0)
		BEGIN
			IF EXISTS(SELECT 1 FROM BasicData.dbo.[user] t1 inner join BasicData.dbo.user_class t2 on t1.userid=t2.userid inner join BasicData.dbo.user_class t3 on t2.cid=t3.cid WHERE t1.userid=@secondkmpuserid and t1.usertype=0 and t3.userid=@firstkmpuserid)
			BEGIN
				SET @returnvalue=1
			END
			ELSE
			BEGIN
				SET @returnvalue=0
			END
		END
		ELSE
		BEGIN
			IF EXISTS(SELECT 1 FROM BasicData.dbo.[user] t1 inner join BasicData.dbo.user_class t2 on t1.userid=t2.userid WHERE t1.userid=@secondkmpuserid and t2.cid=@classid and t1.usertype=0)
			BEGIN
				SET @returnvalue=1
			END
			ELSE
			BEGIN
				SET @returnvalue=0
			END
		END
	END
	RETURN @returnvalue

GO
