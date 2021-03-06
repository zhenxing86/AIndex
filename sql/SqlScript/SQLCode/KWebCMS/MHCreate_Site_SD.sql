USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MHCreate_Site_SD]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * From basicdata..kindergarten where area=724
--
--select * from basicdata..area where superior=724
--insert into basicdata..area (title,superior,level)values('教育局',724,3)

--select * from site_themelist where siteid=0 and theme_category_id=2
--select * from basicdata..[user] where account='azxhy'
--exec  [MHCreate_Site_SD] 1027,'肥城市安驾庄镇夏辉幼儿园','zjzzxhy','http://zjzzxhy.zgyey.com',188,737,762,'楮丽','1174000270','azxhyry@126.com','15966033892',268

CREATE Procedure [dbo].[MHCreate_Site_SD] 
@siteid int,--1026
@name nvarchar(50),
@account nvarchar(30),
@sitedns nvarchar(100),
@city int,
@area int,
@residence int,
@contractname nvarchar(30),
@qq nvarchar(20),
@Email nvarchar(100),
@phone nvarchar(30),
@themeid int
AS
BEGIN
	declare @dict nvarchar(64)
	declare @description nvarchar(300)
	DECLARE @currentSiteID int
	DECLARE @currentUserID int
	DECLARE @userid int	
	Declare @password nvarchar(50)
	declare @province int
	declare @memo nvarchar(500)

	declare @address nvarchar(500)
	declare @copyright nvarchar(1000)
	set @province = 290
	set @description=''
	set @dict=''
	set @memo='' 
	set @address=''
	set @copyright=''	
	---------------------------------------------------
	----------------插入数据到相应表中-----------------
	---------------------------------------------------	
	set @password='7C4A8D09CA3762AF61E59520943DC26494F8941B'
	IF exists(select * from  basicdata..[user] where account = @account and deletetag = 1)
	return -1
	IF exists(select * from  basicdata..kindergarten k inner join KWebCMS..site s on k.kid = s.siteid and k.deletetag = 1 where s.sitedns = @sitedns)
	return -1
  
  --添加幼儿园 
  --DECLARE @CurrentKid int
	--创建幼儿园表
  INSERT INTO basicdata..kindergarten(kname,privince,city,area,residence,actiondate,telephone,qq) VALUES (@name,@province,@city,@area,@residence,GETDATE(),@phone,@qq)
  SET @currentSiteID = ident_current('basicdata..kindergarten')  
	
	
	INSERT INTO basicdata..[user]([account],[password],[usertype],[deletetag],[regdatetime],kid,[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic )
	VALUES(@account,@password,98,1,getdate(),@currentSiteID,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')    
	SET @userid = ident_current('basicdata..user')    
	INSERT INTO basicdata..[user_baseinfo]([userid],[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic)
    VALUES(@userid,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')
        
     --创建幼儿园配置表                
  INSERT INTO [KWebCMS].[dbo].[site_config]([siteid],[shortname],[code],[memo],[smsnum],[ispublish],[isportalshow],
  [kindesc],[copyright],[guestopen],[isnew],[ptshotname],[isvip],[isvipcontrol],[ispersonal],[denycreateclass],
  [classtheme],[kinlevel],[kinimgpath],[theme],[bbzxaccount],[bbzxpassword],[classphotowatermark],[linkman],[status])
  VALUES(@currentSiteID,@name,'',@memo,10,0,0,'','',0,0,@name,0,0,0,0,'','','',@themeid,'','','',@contractname,1)

	
		DECLARE @org_id int
	DECLARE @site_instance_id int
	INSERT INTO KWebCMS_Right..sac_org(org_name,create_datetime,up_org_id) VALUES(@name,getdate(),0)
	SELECT @org_id=ident_current('KWebCMS_Right..sac_org')  
	INSERT INTO KWebCMS_Right..sac_site_instance(org_id,site_id,site_instance_name,personalized)
	VALUES (@org_id,1,@name+'网站后台',0)
	SELECT @site_instance_id=ident_current('KWebCMS_Right..sac_site_instance')  
	DECLARE @manage_role_id int
	INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'管理员')
	SELECT @manage_role_id=ident_current('KWebCMS_Right..sac_role') 
	DECLARE @principal_role_id int
	INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'园长')
	SELECT @principal_role_id=ident_current('KWebCMS_Right..sac_role') 
	DECLARE @teacher_role_id int
	INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'老师')
	SELECT @teacher_role_id=ident_current('KWebCMS_Right..sac_role') 
	

    --创建网站表
    INSERT INTO site(siteid,name,description,address,sitedns,provice,city,regdatetime,contractname,qq,phone,accesscount,status,email,dict,org_id,keyword) 
    VALUES(@currentSiteID,@name,@description,@address,@sitedns,@province,@city,GETDATE(),@contractname,@qq,@phone,1,1,@Email,@dict,@org_id,@name)
	--------------- site_themesetting ----------------
	DECLARE @themeid2 int	
	set @themeid2=203
	INSERT INTO site_themesetting(siteid,themeid,iscurrent,styleid,themeid2) VALUES(@currentSiteID,@themeid,1,0,@themeid2)

	--------------- site_domain ----------------
	--INSERT INTO site_domain VALUES(@currentSiteID,@sitedns)
      
	DECLARE @right_userid INT
	INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status)
	VALUES(@account,@password,'网站管理员',getdate(),@org_id,1)
	SELECT @right_userid=ident_current('KWebCMS_Right..sac_user') 
	INSERT INTO KWebCMS_Right..sac_user_role(user_id,role_id) values(@right_userid,@manage_role_id)

	INSERT INTO site_user(siteid,account,password,name,createdatetime,usertype,UID,appuserid) VALUES(@currentSiteID,@account,@password,'网站管理员',GETDATE(),98,@right_userid,@userid)
	SELECT @currentUserID=ident_current('site_user')		
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
	SELECT @manage_role_id,right_id FROM kwebcms_right..gly_right_id where siteid=@siteid
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
	SELECT @principal_role_id,right_id FROM kwebcms_right..yz_right_id where siteid=@siteid		
           
 
	DECLARE @tempAlbumTable TABLE
	(
		--定义临时相册表
		oldAlbumID int,
		newAlbumID int
	)
	  
 --创建部门可移值后面始化
	declare @did int
	declare @did2 int
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES(@name,0,1,1,@currentSiteID,GETDATE())
       
       SET @did=ident_current('basicdata..department')		
      
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('行政部',@did,1,1,@currentSiteID,GETDATE())
       
       SET @did2=ident_current('basicdata..department')		
       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('保育组',@did2,1,1,@currentSiteID,GETDATE())
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('财务组',@did2,2,1,@currentSiteID,GETDATE())
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('教学组',@did2,3,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('小班部',@did,4,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('中班部',@did,5,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('大班部',@did,6,1,@currentSiteID,GETDATE())
       
	--创建默认班级
	INSERT INTO Basicdata..class (kid,cname,grade,deletetag,actiondate,iscurrent,subno)
	SELECT @currentSiteID,name,classgrade,1,getdate(),1,0 from    basicdata..Templates_Class --where classgrade=35	
	
	
    --INSERT INTO t_dictionarysetting (kid,dic_id) SELECT @currentSiteID,ClassGrade FROM KMP..Templates_Class	
	
	IF @@ERROR <> 0
	BEGIN
		--ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN						
		--exec ossapp..[init_kinbaseinfo]
		INSERT INTO synkid(kid,	regdatetime) VALUES(@currentSiteID,getdate())
		print @currentSiteID		
	END

	----------------- 更新 site_menu -----------------
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MHCreate_Site_SD', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MHCreate_Site_SD', @level2type=N'PARAMETER',@level2name=N'@Email'
GO
