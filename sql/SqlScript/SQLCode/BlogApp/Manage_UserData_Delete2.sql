USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_UserData_Delete2]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：删除用户资料
--项目名称：zgyeyblog
--说明：
--时间：2008-12-16 13:55:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_UserData_Delete2]
@userid INT
AS
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	--DECLARE @kmpuserid INT
	--DECLARE @kid int
	--SELECT @kmpuserid=kmpuserid,@kid=kid FROM bloguserkmpuser WHERE bloguserid=@userid

	----删除幼儿园网站明星老师、明星幼儿
	--DELETE kwebcms..blog_lucidapapoose where userid=@userid
	--DELETE kwebcms..blog_lucidateacher where userid=@userid
	--IF(@kmpuserid is not null)
	--BEGIN		
	--	UPDATE kmp..t_users SET activity=-1 WHERE ID=@kmpuserid
	--	DECLARE @pid INT 
	--	DECLARE @usertype int
	--	DECLARE @manageruserid INT		
	--	SELECT @pid=pid FROM KMP..Patriarch WHERE userid=@kmpuserid 
	--	SELECT @usertype=usertype FROM kmp..t_users WHERE id=@kmpuserid

	--	IF(@usertype=1 or @usertype>1)
	--	BEGIN
	--		SELECT @kid=kindergartenid FROM kmp..T_Staffer WHERE userid=@kmpuserid
	--		UPDATE kmp..T_Staffer set status=-1 WHERE userid=@kmpuserid
	--		IF(@pid is not null)
	--		BEGIN
	--			set @manageruserid=(select top(1) t2.id from kmp..t_staffer t1 inner join kmp..t_users t2 
	--			on t1.userid=t2.id where t1.kindergartenid=@kid and t2.usertype=98 and t2.activity=1 and t1.status=1)
	--			EXEC CancelTeacherCard @kmpuserid,@kid,@manageruserid
	--		END
	--	END
	--	ELSE
	--	BEGIN
	--		SELECT @kid=kindergartenid FROM kmp..T_Child WHERE userid=@kmpuserid
	--		UPDATE kmp..T_Child set status=-1 WHERE userid=@kmpuserid
	--		IF(@pid is not null)
	--		BEGIN
	--			set @manageruserid=(select top(1) t2.id from kmp..t_staffer t1 inner join kmp..t_users t2 
	--			on t1.userid=t2.id where t1.kindergartenid=@kid and t2.usertype=98 and t2.activity=1 and t1.status=1)
	--			EXEC CancelPatrarchCard @pid,@kid,@manageruserid
	--		END
	--	END	
	--END

	--UPDATE blog_user SET activity=-1 WHERE userid=@userid
	
		UPDATE t1 set t1.deletetag=0 from basicdata.dbo.[user] t1 inner join basicdata.dbo.user_bloguser t2 on t1.userid=t2.userid where t2.bloguserid=@userid

	
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
