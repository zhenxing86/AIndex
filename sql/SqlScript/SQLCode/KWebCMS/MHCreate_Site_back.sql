USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MHCreate_Site_back]    Script Date: 05/14/2013 14:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec  [HMCreate_Site] 1026,'liaoxin999','test2','ededede','tddd','httt://dede1DDx.zgyey.net',28,29,'liaoxin',
--'349881223','349881223@qq.com','349881223',33,'liaoxin00000','123212','',''
---------------------------------------------------------
create Procedure [dbo].[MHCreate_Site_back] 
@siteid int,--1026
@name nvarchar(50),
@description nvarchar(300),
@address nvarchar(500),
@copyright nvarchar(1000),
@sitedns nvarchar(100),
@province int,
@city int,
@contractname nvarchar(30),
@qq nvarchar(20),
@Email nvarchar(100),
@phone nvarchar(30),
@themeid int,
@account nvarchar(30),
@password nvarchar(64),
@dict nvarchar(64),
@memo nvarchar(500)
AS
BEGIN
	DECLARE @currentSiteID int
	DECLARE @currentUserID int
	DECLARE @userid int
	DECLARE @tempAlbumTable TABLE
	(
		--定义临时相册表
		oldAlbumID int,
		newAlbumID int
	)
	---------------------------------------------------
	----------------插入数据到相应表中-----------------
	---------------------------------------------------	
	
	INSERT INTO basicdata..[user](
	[account],[password],[usertype],[deletetag],[regdatetime]
	)VALUES(
	@account,@password,98,1,getdate()
	)    
	SET @userid = @@IDENTITY
	INSERT INTO basicdata..[user_baseinfo]([userid],[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic)
    VALUES(@userid,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')


    IF @userid>0
    BEGIN
     --添加幼儿园 
     EXEC  @currentSiteID=basicdata..BasicData_kindergarten_Add @userid,@name,@province,@city,@dict,@phone,@qq
     --更新建站基础信息
     EXEC   basicdata..site_config_update @currentSiteID,'',@memo,10,0,@name,'Default',@contractname,1
    END
    ELSE
    BEGIN
       RETURN -1
    END
    
    
	IF @currentSiteID IS NULL OR @currentSiteID <=0 
	BEGIN
		--ROLLBACK TRANSACTION
		RETURN -1
	END
	
	--默认创建班级
	INSERT INTO Basicdata..class (kid,cname,grade,deletetag,actiondate,iscurrent,subno)
	SELECT @currentSiteID,name,classgrade,1,getdate(),1,0 from    basicdata..Templates_Class --where classgrade=35	

	------------------ site ----------------
	DECLARE @org_id int
	DECLARE @site_instance_id int
	INSERT INTO KWebCMS_Right..sac_org(org_name,create_datetime,up_org_id) VALUES(@name,getdate(),0)
	SELECT @org_id=@@IDENTITY
	INSERT INTO KWebCMS_Right..sac_site_instance(org_id,site_id,site_instance_name,personalized)
	VALUES (@org_id,1,@name+'网站后台',0)
	SELECT @site_instance_id=@@IDENTITY
	DECLARE @manage_role_id int
	INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'管理员')
	SELECT @manage_role_id=@@IDENTITY
	DECLARE @principal_role_id int
	INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'园长')
	SELECT @principal_role_id=@@IDENTITY
	DECLARE @teacher_role_id int
	INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'老师')
	SELECT @teacher_role_id=@@IDENTITY


IF (CharIndex('校讯通',@memo ,1)>0 or CharIndex('园讯通',@memo ,1)>0)
BEGIN
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) SELECT @manage_role_id,t4.right_id FROM site t1 INNER JOIN kwebcms_right..sac_site_instance t2 ON t1.org_id=t2.org_id INNER JOIN kwebcms_right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id WHERE t1.siteid=@siteid and t2.site_id=1 and t3.role_name='管理员' and t4.right_id<>29
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) SELECT @principal_role_id,t4.right_id FROM site t1 INNER JOIN kwebcms_right..sac_site_instance t2 ON t1.org_id=t2.org_id INNER JOIN kwebcms_right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id WHERE t1.siteid=@siteid and t2.site_id=1 and t3.role_name='园长' and t4.right_id<>29
	DECLARE @xxtid int
	INSERT INTO KWebCMS_Right..[sac_right](
	[site_id],[site_instance_id],[up_right_id],[right_name],[right_code]
	)VALUES(
	1,@site_instance_id,1,'园讯通','YEYWZHT_YXT'
	)
	SET @xxtid = @@IDENTITY
	INSERT INTO site_menu(title,url,target,parentid,categoryid,imgpath,orderno,siteid,right_id)
	VALUES('园讯通','http://www.xxt139.com/parent/','_blank',0,0,'bt_xxt',4,@currentSiteID,@xxtid)
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) VALUES(@manage_role_id,@xxtid)
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) VALUES(@principal_role_id,@xxtid)

	insert into appconfig..tem_kidapp(opkid,appid) values(@currentSiteID,29)
END
ELSE
BEGIN
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) SELECT @manage_role_id,t4.right_id FROM site t1 INNER JOIN kwebcms_right..sac_site_instance t2 ON t1.org_id=t2.org_id INNER JOIN kwebcms_right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id WHERE t1.siteid=@siteid and t2.site_id=1 and t3.role_name='管理员'
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) SELECT @principal_role_id,t4.right_id FROM site t1 INNER JOIN kwebcms_right..sac_site_instance t2 ON t1.org_id=t2.org_id INNER JOIN kwebcms_right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id WHERE t1.siteid=@siteid and t2.site_id=1 and t3.role_name='园长'
END
 
	if(@siteid<>1026)
	begin
		INSERT INTO t_dictionarysetting (kid,dic_id) SELECT @currentSiteID,ClassGrade FROM KMP..Templates_Class
	end

	INSERT INTO site(siteid,name,description,address,sitedns,provice,city,regdatetime,contractname,qq,phone,accesscount,status,email,dict,org_id,keyword) 
    VALUES(@currentSiteID,@name,@description,@address,@sitedns,@province,@city,GETDATE(),@contractname,@qq,@phone,1,1,@Email,@dict,@org_id,@name)
	--------------- site_themesetting ----------------
	DECLARE @themeid2 int
	--SELECT TOP(1) @themeid2=themeid FROM site_themelist WHERE siteid=-1 Order By NewID()
	set @themeid2=203
	INSERT INTO site_themesetting(siteid,themeid,iscurrent,styleid,themeid2) VALUES(@currentSiteID,@themeid,1,0,@themeid2)

	--------------- site_domain ----------------
	INSERT INTO site_domain VALUES(@currentSiteID,@sitedns)

	--------------- site_user ------------------
	DECLARE @right_userid INT
	INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status)
	VALUES(@account,@password,'网站管理员',getdate(),@org_id,1)
	SELECT @right_userid=@@IDENTITY
	INSERT INTO KWebCMS_Right..sac_user_role(user_id,role_id) values(@right_userid,@manage_role_id)

	INSERT INTO site_user(siteid,account,password,name,createdatetime,usertype,UID,appuserid) VALUES(@currentSiteID,@account,@password,'网站管理员',GETDATE(),98,@right_userid,@userid)
	SELECT @currentUserID=@@IDENTITY

	DECLARE @csnr_siteid int
	SET @csnr_siteid=14499--1026
	------------ kin_friendhref ----------------
	INSERT INTO kin_friendhref(caption,href,siteid,orderno)
	SELECT caption,href,@currentSiteID,orderno FROM kin_friendhref WHERE siteid=@csnr_siteid ORDER BY id
	------------ kin_friendhref ----------------
	----------------- cms_content -----------------	
	INSERT INTO cms_content(categoryid,[content],title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,orderno,commentstatus,ispageing,status,siteid,viewcount,commentcount) 
	SELECT t1.categoryid,t1.content,t1.title,t1.titlecolor,t1.author,getdate(),t1.searchkey,t1.searchdescription,t1.browsertitle,t1.orderno,t1.commentstatus,t1.ispageing,t1.status,@currentSiteID,t1.viewcount,t1.commentcount FROM Templates_cms_content t1
	----------------- cms_content -----------------60
	----------------- cms_album -----------------
	declare @cmsalbumid int
	INSERT INTO cms_album(categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime,siteid)
	SELECT t1.categoryid,t1.title,t1.searchkey,t1.searchdescription,t1.photocount,t1.cover,t1.orderno,getdate(),@currentSiteID 
	FROM Templates_cms_album t1 where categoryid=17104

	set @cmsalbumid=@@IDENTITY	
	----------------- cms_photo -----------------
	INSERT INTO cms_photo(categoryid,albumid,title,[filename],filepath,filesize,orderno,commentcount,indexshow,flashshow,createdatetime,siteid)
	SELECT t1.categoryid,@cmsalbumid,t1.title,t1.[filename],t1.filepath,t1.filesize,t1.orderno,t1.commentcount,t1.indexshow,t1.flashshow,t1.createdatetime,@currentSiteID 
	FROM Templates_cms_photo t1  where categoryid=17104	

	INSERT INTO cms_album(categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime,siteid)
	SELECT t1.categoryid,t1.title,t1.searchkey,t1.searchdescription,t1.photocount,t1.cover,t1.orderno,getdate(),@currentSiteID 
	FROM Templates_cms_album t1 where categoryid=17106

	set @cmsalbumid=@@IDENTITY	
	----------------- cms_photo -----------------
	INSERT INTO cms_photo(categoryid,albumid,title,[filename],filepath,filesize,orderno,commentcount,indexshow,flashshow,createdatetime,siteid)
	SELECT t1.categoryid,@cmsalbumid,t1.title,t1.[filename],t1.filepath,t1.filesize,t1.orderno,t1.commentcount,t1.indexshow,t1.flashshow,t1.createdatetime,@currentSiteID 
	FROM Templates_cms_photo t1  where categoryid=17106


	----------------- cms_photo -----------------17
	----------------- cms_contentattachs -----------------	
	INSERT INTO cms_contentattachs(categoryid,contentid,title,filepath,[filename],filesize,viewcount,createdatetime,attachurl,isdefault,siteid)
	SELECT categoryid,contenid,title,filepath,[filename],filesize,viewcount,createdatetime,attachurl,isdefault,@currentSiteID FROM Templates_cms_contentattachs

	----------------- cms_contentattachs -----------------13

	IF @city=246
	BEGIN
		insert  into  blogapp..permissionsetting (ptype,kid) values(3,@currentSiteID)
	END
	IF @@ERROR <> 0
	BEGIN
		--ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		--COMMIT TRANSACTION
		
		if(@province!=179)
		begin
		DECLARE @SMSContent VARCHAR(500)
        set @SMSContent ='幼儿园:' +@name+ '电话:' +@phone +  '联系人:' +@contractname+ 'Q:' +@qq
		
		exec  sms..kindergarten_register_sms_ADD  @SMSContent
		end
		--exec ossapp..[init_kinbaseinfo]
		RETURN @currentSiteID		
	END

	----------------- 更新 site_menu -----------------
END
GO
