USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_Register]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：博客注册
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 07:16:29
--作者：along
--exec [blog_Register] '751822','801895','1','女',''
------------------------------------
CREATE PROCEDURE [dbo].[blog_Register]
@userid int,
@appuserid int,
@usertype int,
@gender varchar(20),
@nickname varchar(50)
 AS 
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--BEGIN TRANSACTION
	--declare @appuserid int
	DECLARE @rtn int
	declare @exitaccount int
	Declare @messagecontent nvarchar(2500)
	declare @theme int
	
	if(@gender='男')
	begin
		set @theme=3
		--set @theme=4
	end
	else
	begin
		set @theme=2
		--set @theme=4
	end
	

	
	--新增用户
	DECLARE @blogcategoryid1 int --[默认个人日记ID]
	DECLARE @blogcategoryid2 int --[默认教学日记ID]
	DECLARE @album_categoryid int --默认相册分类ID
	DECLARE @album_photoid int --默认相片ID
	DECLARE @blogpostid int --默认日记ID
	DECLARE @blogtype int --博客类型0教师,1宝宝
	DECLARE @blogtypestr nvarchar(50)
	DECLARE @headpic nvarchar(100) --默认头像
	declare @desctitle nvarchar(100)
	
    --select @appuserid=userid from basicdata..user_bloguser where bloguserid=@userid
	
	IF(@usertype=0)
	BEGIN
		SET @messagecontent='<h2>亲爱的'+@nickname+'小朋友：</h2><p class="f13" style="color:#386952">真高兴,咱们幼儿园又多了一位小朋友加入进来了!为了帮助你快速了解小朋友成长档案提供的各项功能, 我们为你提供了详细的功能介绍，详细请点击<a href="http://www.zgyey.com/blogfaq.html" target="_blank" ><font color="red">帮助中心</font></a>。</p><h3>特别提示:</h3><p>如果你在使用中遇到问题, 你可以选择:<br>1.请与在线客服人员联系，<em><strong>在线客服QQ:</strong>847217619, 514634675, 781809764</em> <br>2.发信至中国幼儿园门户<em><strong>客服信箱:</strong> zgyey@126.com</em> <br><font class="f13">别忘了常来到成长档案看看写写哦！</font><br><font class="f13">老师和其他小朋友一起在这里和你分享成长中的趣事！</font><br><font class="f13">我们将为孩子在幼儿园的生活增添更多乐趣和切实的帮助!</font></p></p>'
		set @desctitle='我的成长档案开通啦'
	END
	ELSE
	BEGIN
		SET @messagecontent='<h2>尊敬的'+@nickname+'老师：</h2><p class="f13" style="color:#386952">欢迎你加入到中国幼儿园门户，为本班小朋友建立一个温馨的班级家园！与全国幼教同行们一起沟通交流!</p><p class="f13"style="color:#386952">为了帮助你快速了解中国幼儿园门户老师教学助手提供的各项功能, 我们为你提供了详细的功能介绍，详细请点击<a href="http://www.zgyey.com/blogfaq.html" target="_blank" ><font color="red">帮助中心</font></a>。</p><h3>特别提示:</h3><p>如果你在使用中遇到问题, 你可以选择:<br>1.请与在线客服人员联系，<em><strong>在线客服QQ:</strong>847217619, 514634675, 781809764</em> <br>2.发信至中国幼儿园门户<em><strong>客服信箱:</strong> zgyey@126.com</em> </p><p class="f13">我们会随时准备为你提供帮助,并将以最快的速度加以改进。</p><p class="f13">希望我们能为您提供更多切实的帮助!</p></p>'
		set @desctitle='我的教学助手开通啦'
	END
	
   
--	IF(@usertype<>0)
--	BEGIN		

		--新增默认日志分类[个人日记]
--		INSERT INTO blog_postscategories(
--		[userid],[title],[description],[displayorder],[postcount]
--		)VALUES(
--		@userid,'个人日记','',1,1
--		)
--		SET @blogcategoryid1 = @@IDENTITY
--		
--		INSERT INTO blog_postscategories(
--		[userid],[title],[description],[displayorder],[postcount]
--		)VALUES(
--		@userid,'教育随笔','',2,0
--		)
--		
--		INSERT INTO blog_postscategories(
--		[userid],[title],[description],[displayorder],[postcount]
--		)VALUES(
--		@userid,'经典收藏','',3,0
--		)
--
--		INSERT INTO blog_postscategories(
--		[userid],[title],[description],[displayorder],[postcount]
--		)VALUES(
--		@userid,'资源分享','',4,0
--		)	

		--新增默认日记
--	INSERT INTO blog_posts(
--	[author],[userid],[postdatetime],[title],[content],[poststatus],[categoriesid],[commentstatus],[IsTop],[IsSoul],[postupdatetime],[commentcount],[viewcounts],[smile]
--	)VALUES(
--	@nickname,@userid,getdate(),'我的教学助手开通啦','我的教学助手开通啦!',1,@blogcategoryid1,1,1,0,getdate(),0,0,'1'
--	)
		
--	END
--	ELSE
	--BEGIN
		--新增默认日志分类[小朋友日记]
--		INSERT INTO blog_postscategories(
--		[userid],[title],[description],[displayorder],[postcount]
--		)VALUES(
--		@userid,'个人日记','',1,1
--		)
--		SET @blogcategoryid1 = @@IDENTITY
--		
--		INSERT INTO blog_postscategories(
--		[userid],[title],[description],[displayorder],[postcount]
--		)VALUES(
--		@userid,'童真童趣','',2,0
--		)
--		
--		INSERT INTO blog_postscategories(
--		[userid],[title],[description],[displayorder],[postcount]
--		)VALUES(
--		@userid,'育儿心得','',3,0
--		)
--
--		INSERT INTO blog_postscategories(
--		[userid],[title],[description],[displayorder],[postcount]
--		)VALUES(
--		@userid,'旅游摄影','',4,0
--		)	

		--新增默认日记
--	INSERT INTO blog_posts(
--	[author],[userid],[postdatetime],[title],[content],[poststatus],[categoriesid],[commentstatus],[IsTop],[IsSoul],[postupdatetime],[commentcount],[viewcounts],[smile]
--	)VALUES(
--	'',@userid,getdate(),'我的成长档案开通啦','我的成长档案开通啦!',1,@blogcategoryid1,1,1,0,getdate(),0,0,'1'
--	)
		
	--END

	

	--新增相册默认分类
--	INSERT INTO album_categories(
--	[userid],[title],[description],[displayorder],[albumdispstatus],[photocount],[createdatetime]
--	)VALUES(
--	@userid,'我的相册','我的相册描述',1,0,0,getdate()
--	)

	SET @album_categoryid = @@IDENTITY

	--新增默认博客留言
--	INSERT INTO blog_messageboard(
--	[userid],[fromuserid],[author],[content],[msgstatus],[msgdatetime],[parentid]
--	)VALUES(
--	@userid,-1,'中国幼儿园门户',@messagecontent,0,getdate(),0
--	)

	IF(@usertype<>0)
	BEGIN
		--新增默认文档目录
		DECLARE @thelp_categoriesid int 
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		0,@userid,'个人文档','个人文档',1,0,getdate()
--		)
		SET @thelp_categoriesid=0
		
		--
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'教学安排','教学安排',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'工作计划','工作计划',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'工作总结','工作总结',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'观察记录','观察记录',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'教学反思','教学反思',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'个案分析','个案分析',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'常用表格','常用表格',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'家长会稿','家长会稿',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'评价评语','评价评语',1,0,getdate()
--		)
--		INSERT INTO docapp..thelp_categories(
--		[parentid],[userid],[title],[description],[status],[documentcount],[createdatetime]
--		)VALUES(
--		@thelp_categoriesid,@appuserid,'其它','其它',1,0,getdate()
--		)
	END

	--新增博客默认配置表

	INSERT INTO blog_baseconfig(
	[userid],[blogtitle],[description],[defaultdispmode],[postdispcount],[themes],[messagepref],[postscount],[albumcount],[photocount],[visitscount],[createdatetime],
	[updatedatetime],[lastposttitle],[lastpostid],[blogtype],[blogurl],[integral],[kininfohide],[posttoclassdefault],[commentpermission],[openblogquestion],[openbloganswer],[messagepermission],[postviewpermission],[albumviewpermission]
	)VALUES(
	@userid,@nickname+'',@nickname+'个人描述',0,5,@theme,0,1,1,0,0,getdate(),getdate(),
	'我的'+@desctitle+'开通了',@blogpostid,@blogtype,'http://blog.zgyey.com/'+rtrim(convert(char(10),@userid))+'/index.html',0,0,0,1,'','',1,0,0
	)

	DECLARE @logdescription nvarchar(300)	
	SET @logdescription='<a href="http://blog.zgyey.com/'+cast(@userid as nvarchar(20))+'/index.html" target="_blank"><<'+@desctitle+'开通了!>></a>'


	IF @@ERROR <> 0 
	BEGIN
	   --ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   --COMMIT TRANSACTION
		--exec sys_actionlogs_ADD @userid,@nickname,@logdescription ,'15',0,0,0
	   RETURN @userid
	END


















GO
