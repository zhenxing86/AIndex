USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[A_MHCreate_Site]    Script Date: 05/14/2013 14:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec  [HMCreate_Site] 1026,'liaoxin999','test2','ededede','tddd','httt://dede1DDx.zgyey.net',28,29,'liaoxin',
--'349881223','349881223@qq.com','349881223',33,'liaoxin00000','123212','',''
---------------------------------------------------------
CREATE Procedure [dbo].[A_MHCreate_Site] 
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
	
	---------------------------------------------------
	----------------插入数据到相应表中-----------------
	---------------------------------------------------	
	--创建用户与用户基本资料
	INSERT INTO basicdata..[user]([account],[password],[usertype],[deletetag],[regdatetime])VALUES(@account,@password,98,1,getdate())    
	SET @userid = @@IDENTITY
	INSERT INTO basicdata..[user_baseinfo]([userid],[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic)
    VALUES(@userid,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')
    
    IF @userid>0
    BEGIN
     --添加幼儿园 
			--创建幼儿园表
      INSERT INTO basicdata..kindergarten(kname,privince,city,area,actiondate,telephone,qq) VALUES (@name,@province,@city,0,GETDATE(),@phone,@qq)
      SET @currentSiteID=@@IDENTITY
     --创建幼儿园与用户关系表    
      INSERT INTO basicdata..user_kindergarten VALUES (@userid,@currentSiteID)           
     --创建幼儿园配置表                
      INSERT INTO [KWebCMS].[dbo].[site_config]([siteid],[shortname],[code],[memo],[smsnum],[ispublish],[isportalshow],[kindesc],[copyright],
      [guestopen],[isnew],[ptshotname],[isvip],[isvipcontrol],[ispersonal],[denycreateclass],[classtheme],[kinlevel],[kinimgpath],[theme],
      [bbzxaccount],[bbzxpassword],[classphotowatermark],[linkman],[status])
      VALUES(@currentSiteID,@name,'',@memo,10,0,0,'','',0,0,@name,0,0,0,0,'','','',@themeid,'','','',@contractname,1)


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
	

    --创建网站表
    INSERT INTO site(siteid,name,description,address,sitedns,provice,city,regdatetime,contractname,qq,phone,accesscount,status,email,dict,org_id,keyword) 
    VALUES(@currentSiteID,@name,@description,@address,@sitedns,@province,@city,GETDATE(),@contractname,@qq,@phone,1,1,@Email,@dict,@org_id,@name)
	--------------- site_themesetting ----------------
	DECLARE @themeid2 int
	--SELECT TOP(1) @themeid2=themeid FROM site_themelist WHERE siteid=-1 Order By NewID()
	set @themeid2=203
	INSERT INTO site_themesetting(siteid,themeid,iscurrent,styleid,themeid2) VALUES(@currentSiteID,@themeid,1,0,@themeid2)

	--------------- site_domain ----------------
	INSERT INTO site_domain VALUES(@currentSiteID,@sitedns)
      
	DECLARE @right_userid INT
	INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status)
	VALUES(@account,@password,'网站管理员',getdate(),@org_id,1)
	SELECT @right_userid=@@IDENTITY
	INSERT INTO KWebCMS_Right..sac_user_role(user_id,role_id) values(@right_userid,@manage_role_id)

	INSERT INTO site_user(siteid,account,password,name,createdatetime,usertype,UID,appuserid) VALUES(@currentSiteID,@account,@password,'网站管理员',GETDATE(),98,@right_userid,@userid)
	SELECT @currentUserID=@@IDENTITY

		IF (CharIndex('校讯通',@memo ,1)>0 or CharIndex('园讯通',@memo ,1)>0)
		BEGIN
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			SELECT @manage_role_id,right_id FROM kwebcms_right..gly_right_id where siteid=@siteid and  right_id<>29
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			SELECT @principal_role_id,right_id FROM kwebcms_right..yz_right_id where siteid=@siteid and right_id<>29
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

			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			SELECT @manage_role_id,right_id FROM kwebcms_right..gly_right_id where siteid=@siteid
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			SELECT @principal_role_id,right_id FROM kwebcms_right..yz_right_id where siteid=@siteid

		END
 

    END
    ELSE
    BEGIN
       RETURN -1
    END
        
	 
	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN @currentSiteID		
	END
END
GO
