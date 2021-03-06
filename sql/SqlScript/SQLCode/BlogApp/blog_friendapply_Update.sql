USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendapply_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：修改好友申请记录 (通过，不通过)
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-02 09:57:22
--作者：along  select * from blog_friendapply where sourceuserid=141274
------------------------------------
CREATE PROCEDURE [dbo].[blog_friendapply_Update]
@friendapplyid int,
@applystatus int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	
	DECLARE @userid int
	DECLARE @frienduserid int

	SELECT @userid=targetuserid,@frienduserid=sourceuserid 
	FROM blog_friendapply
	WHERE friendapplyid=@friendapplyid

	UPDATE blog_friendapply SET 
	[applystatus] = @applystatus
	WHERE friendapplyid=@friendapplyid 
	
	IF (@applystatus=1)
	BEGIN
		IF not EXISTS(SELECT * FROM blog_friendlist WHERE userid=@userid AND frienduserid=@frienduserid)
		begin
			INSERT INTO blog_friendlist(
			[userid],[frienduserid],[updatetime]
			)VALUES(
			@userid,@frienduserid,getdate()
			)			
		end

		IF not EXISTS(SELECT * FROM blog_friendlist WHERE userid=@frienduserid AND frienduserid=@userid)
		begin
			INSERT INTO blog_friendlist(
			[userid],[frienduserid],[updatetime]
			)VALUES(
			@frienduserid,@userid,getdate()
			)			
		end
		--EXEC sys_actionlogs_ADD @frienduserid,@friendname,@description2 ,'6',0,0,0
		
	END
	ELSE
	BEGIN
		DELETE blog_friendlist
		WHERE userid=@userid and frienduserid=@frienduserid 

		DELETE blog_friendlist
		WHERE userid=@frienduserid and frienduserid=@userid
	END

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END







GO
