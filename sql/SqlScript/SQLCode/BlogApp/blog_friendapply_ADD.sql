USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendapply_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途： 加为好友申请
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-02 09:57:22
--作者:	along
-- exec [blog_friendapply_ADD] 2,4
------------------------------------
CREATE PROCEDURE [dbo].[blog_friendapply_ADD]
@sourceuserid int,
@targetuserid int
 AS 
	DECLARE @tmp int

	SELECT @tmp = count(1) FROM blog_friendlist
	WHERE (userid=@sourceuserid and frienduserid=@targetuserid) or 
		(frienduserid=@sourceuserid and userid=@targetuserid)
	
	IF (@tmp>0)
	BEGIN
		RETURN(-3) --已经是好友
	END

	SELECT @tmp = count(1) FROM blog_friendapply 
	WHERE targetuserid=@targetuserid and sourceuserid=@sourceuserid and applystatus=0
	
	IF (@tmp>0)
	BEGIN
		RETURN(-2) --已经提交好友申请，不能重复提交
	END

	INSERT INTO blog_friendapply(
	[sourceuserid],[targetuserid],[applystatus],[remark],[invitetime]
	)VALUES(
	@sourceuserid,@targetuserid,0,'你好，交个朋友，好吗？',getdate()
	)
	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN 1
	END








GO
