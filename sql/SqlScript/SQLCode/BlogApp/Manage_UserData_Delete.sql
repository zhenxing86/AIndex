USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_UserData_Delete]    Script Date: 2014/11/25 11:50:43 ******/
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
CREATE PROCEDURE [dbo].[Manage_UserData_Delete]
@userid int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	--DECLARE @account nvarchar(30)
	--DECLARE @pwd nvarchar(100)
	--DECLARE @kmpuserid INT

	--SELECT @account=account,@pwd=pwd FROM blog_user WHERE userid=@userid
	--SELECT @kmpuserid=id FROM kmp..t_users WHERE loginname=@account and password=@pwd and activity=-1
	
	----删除用户基本配置
	--DELETE blog_baseconfig WHERE userid=@userid
	--DELETE blog_user WHERE userid=@userid	

	----删除心情
	--DELETE blog_breast WHERE userid=@userid

	----删除日记评论	
	----DELETE blog_postscomments WHERE postsid in (SELECT postid FROM blog_posts WHERE userid=@userid )

	----删除日记归类
	--DELETE blog_postsyscategory_relation WHERE postid IN (SELECT postid FROM blog_posts WHERE userid=@userid)
	
	----删除日记
	--DELETE blog_posts WHERE userid=@userid

	----删除日记分类
	--DELETE blog_postscategories WHERE userid=@userid

	----删除串门记录
	--DELETE blog_accesslogs WHERE userid=@userid

	----删除留言薄
	--DELETE blog_messageboard WHERE userid=@userid

	----删除好友申请
	--DELETE blog_friendapply WHERE sourceuserid=@userid OR targetuserid=@userid

	----删除好友列表
	--DELETE blog_friendlist WHERE userid=@userid or frienduserid=@userid 

	----删除消息
	--DELETE blog_messagebox WHERE touserid=@userid OR fromuserid=@userid

	----删除收藏夹
	--DELETE blog_collection	WHERE userid=@userid

	----删除照片评论	
	--DELETE album_comments WHERE photoid in (SELECT photoid FROM album_photos t1,album_categories t2 WHERE t1.categoriesid = t2.categoriesid AND userid=@userid)
	----DELETE album_comments WHERE userid=@userid

	----删除照片
	--DELETE album_photos WHERE photoid in (SELECT photoid FROM album_photos t1,album_categories t2 WHERE t1.categoriesid = t2.categoriesid AND userid=@userid)

	----删除相册分类
	--DELETE album_categories WHERE userid=@userid

	----删除文档评论和附件
	--DELETE thelp_doccomment WHERE docid IN (SELECT docid FROM thelp_documents t1, thelp_categories t2 WHERE t1.categoryid =t2.categoryid AND t2.userid=@userid)
	--DELETE thelp_docattachs WHERE docid IN (SELECT docid FROM thelp_documents t1, thelp_categories t2 WHERE t1.categoryid =t2.categoryid AND t2.userid=@userid)

	----删除文档
	--DELETE thelp_documents WHERE docid IN (SELECT docid FROM thelp_documents t1, thelp_categories t2 WHERE t1.categoryid =t2.categoryid AND t2.userid=@userid)

	----删除文档分类
	--DELETE thelp_categories WHERE userid=@userid

	----删除评语模板
	--DELETE thome_remark_tmp WHERE userid=@userid

	----删除分类项目
	--DELETE thome_categoryitem WHERE userid=@userid

	----删除教师评语
	--DELETE thome_teacherremark WHERE userid=@userid

	----删除家长老师留言
	--DELETE thome_messageboard WHERE userid=@userid	

	----删除幼儿园网站明星老师、明星幼儿
	--DELETE kwebcms..blog_lucidapapoose where userid=@userid
	--DELETE kwebcms..blog_lucidateacher where userid=@userid


	--IF(@kmpuserid is not null and @kmpuserid>0)
	--BEGIN	
	--	DECLARE @kid int	
	--	DECLARE @pid INT 
	--	DECLARE @usertype int
	--	DECLARE @manageruserid INT
		
	--	SELECT @pid=pid FROM KMP..Patriarch WHERE userid=@kmpuserid 
	--	SELECT @usertype=usertype FROM kmp..t_users WHERE id=@kmpuserid
	--	IF(@usertype=1 or @usertype>1)
	--	BEGIN
	--		SELECT @kid=kindergartenid FROM kmp..T_Staffer WHERE userid=@kmpuserid
	--		DELETE kmp..T_Staffer WHERE userid=@kmpuserid
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
	--		DELETE kmp..T_Child WHERE userid=@kmpuserid
	--		IF(@pid is not null)
	--		BEGIN
	--			set @manageruserid=(select top(1) t2.id from kmp..t_staffer t1 inner join kmp..t_users t2 
	--			on t1.userid=t2.id where t1.kindergartenid=@kid and t2.usertype=98 and t2.activity=1 and t1.status=1)
	--			EXEC CancelPatrarchCard @pid,@kid,@manageruserid
	--		END
	--	END	
	--	DELETE kmp..t_users WHERE ID=@kmpuserid

	--END

	----删除博客和kmp关联
	--DELETE bloguserkmpuser WHERE bloguserid=@userid
	

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
