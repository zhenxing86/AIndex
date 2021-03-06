USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_blog_new]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[user_blog_new]
@userid int,
@usertype int,
@gender int,
@nickname varchar(50)
as 

if(not exists(select 1 from BlogApp..blog_postscategories where userid=@userid))
begin


declare @theme int
set @theme=@gender	


Declare @messagecontent nvarchar(2500)
declare @desctitle nvarchar(100)

	--新增用户
	DECLARE @blogcategoryid1 int --[默认个人日记ID]
	DECLARE @blogcategoryid2 int --[默认教学日记ID]
	DECLARE @album_categoryid int --默认相册分类ID
	DECLARE @album_photoid int --默认相片ID
	DECLARE @blogpostid int --默认日记ID
	DECLARE @blogtype int --博客类型0教师,1宝宝
	DECLARE @blogtypestr nvarchar(50)
	DECLARE @headpic nvarchar(100) --默认头像
	
IF(@usertype=0)
	BEGIN
		SET @messagecontent='<h2>亲爱的'+@nickname+'小朋友：</h2><p class="f13" style="color:#386952">真高兴,咱们幼儿园又多了一位小朋友加入进来了!为了帮助你快速了解小朋友成长档案提供的各项功能, 我们为你提供了详细的功能介绍，详细请点击<a href="http://www.zgyey.com/blogfaq.html" target="_blank" ><font color="red">帮助中心</font></a>。</p
><h3>特别提示:</h3><p>如果你在使用中遇到问题, 你可以选择:<br>1.请与在线客服人员联系，<em><strong>在线客服QQ:</strong>4006011063</em> <br>2.发信至中国幼儿园门户<em><strong>客服信箱:</strong> zgyey@zgyey.com</em> <br><font class="f13">别忘了常来到成长档案看看写写哦！</font><br><font class="f13">老师和其他小朋友一起在这里和你分享成长中的趣事！</
font><br><font class="f13">我们将为孩子在幼儿园的生活增添更多乐趣和切实的帮助!</font></p></p>'
		set @desctitle='我的成长档案开通啦'
	END
	ELSE
	BEGIN
		SET @messagecontent='<h2>尊敬的'+@nickname+'老师：</h2><p class="f13" style="color:#386952">欢迎你加入到中国幼儿园门户，为本班小朋友建立一个温馨的班级家园！与全国幼教同行们一起沟通交流!</p><p class="f13"style="color:#386952">为了帮助你快速了解中国幼儿园门户老师教学助手提供的各项功能, 我们为你提供了详细的功能介绍，详细请点击<a href="http://www.zgyey.com
/blogfaq.html" target="_blank" ><font color="red">帮助中心</font></a>。</p><h3>特别提示:</h3><p>如果你在使用中遇到问题, 你可以选择:<br>1.请与在线客服人员联系，<em><strong>在线客服QQ:</strong>4006011063</em> <br>2.发信至中国幼儿园门户<em><strong>客服信箱:</strong> zgyey@zgyey.com</em> </p><p class="f13">我们会随时
准备为你提供帮助,并将以最快的速度加以改进。</p><p class="f13">希望我们能为您提供更多切实的帮助!</p></p>'
		set @desctitle='我的教学助手开通啦'
	END
	
--初始化列表	


INSERT INTO BlogApp..blog_postscategories([userid],[title],[description],[displayorder],[postcount])
VALUES(@userid,'个人日记','',1,1)
SET @blogcategoryid1 = @@IDENTITY

if(@usertype>0)
begin
insert into BlogApp..blog_posts([author],[userid],[postdatetime],[title],[content],[poststatus],[categoriesid],[commentstatus],[IsTop],[IsSoul],[postupdatetime],[commentcount],[viewcounts],[smile])
VALUES(@nickname,@userid,getdate(),'我的教学助手开通啦','我的教学助手开通啦!',1,@blogcategoryid1,1,1,0,getdate(),0,0,'1')
end
else 
begin
insert into BlogApp..blog_posts([author],[userid],[postdatetime],[title],[content],[poststatus],[categoriesid],[commentstatus],[IsTop],[IsSoul],[postupdatetime],[commentcount],[viewcounts],[smile])
VALUES('',@userid,getdate(),'我的成长档案开通啦','我的成长档案开通啦!',1,@blogcategoryid1,1,1,0,getdate(),0,0,'1')
end
--插入除了个人日志以外的信息
insert into BlogApp..blog_postscategories([userid],[title],[description],[displayorder],[postcount])
select @userid,title,[description],displayorder,status from user_add_dict 
where [catalog]='blog_postscategories' and usertype=@usertype and displayorder<>1


--新增相册默认分类
INSERT INTO BlogApp..album_categories(
[userid],[title],[description],[displayorder],[albumdispstatus],[photocount],[createdatetime]
)VALUES(@userid,'我的相册','我的相册描述',1,0,0,getdate())

SET @album_categoryid = @@IDENTITY


--新增默认博客留言
INSERT INTO BlogApp..blog_messageboard(
[userid],[fromuserid],[author],[content],[msgstatus],[msgdatetime],[parentid]
)VALUES(@userid,-1,'中国幼儿园门户',@messagecontent,0,getdate(),0)

--新增博客默认配置表

if Not Exists (Select * From BlogApp..blog_baseconfig Where userid = @userid)
  INSERT INTO BlogApp..blog_baseconfig(
  [userid],[blogtitle],[description],[defaultdispmode],[postdispcount],[themes],[messagepref],[postscount],[albumcount],[photocount],[visitscount],[createdatetime],
  [updatedatetime],[lastposttitle],[lastpostid],[blogtype],[blogurl],[integral],[kininfohide],[posttoclassdefault],[commentpermission],[openblogquestion],[openbloganswer],[messagepermission],[postviewpermission],[albumviewpermission]
  )VALUES(
  @userid,@nickname+'',@nickname+'个人描述',0,5,@theme,0,1,1,0,0,getdate(),getdate(),
  '我的'+@desctitle+'开通了',@blogpostid,@blogtype,'http://blog.zgyey.com/'+rtrim(convert(char(10),@userid))+'/index.html',0,0,0,1,'','',1,0,0
  )

DECLARE @logdescription nvarchar(300)	
SET @logdescription='<a href="http://blog.zgyey.com/'+cast(@userid as nvarchar(20))+'/index.html" target="_blank"><<'+@desctitle+'开通了!>></a>'


end

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
