USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Create_Site]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------
CREATE Procedure [dbo].[Create_Site]   
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
 DECLARE @tempAlbumTable TABLE  
 (  
  --定义临时相册表  
  oldAlbumID int,  
  newAlbumID int  
 )  
 ---------------------------------------------------  
 ----------------插入数据到相应表中-----------------  
 ---------------------------------------------------  
  
 --BEGIN TRANSACTION  
  
 DECLARE @CheckUserID int------验证帐号  
 EXEC @CheckUserID=MH_site_user_CheckAccount @account  
 IF @CheckUserID<>1  
 BEGIN  
  --ROLLBACK TRANSACTION  
  RETURN @CheckUserID  
 END  
  
 DECLARE @CheckURL int-----验证URL  
 EXEC @CheckURL=[MH_site_CheckSitedns] @sitedns  
 IF @CheckURL<>1  
 BEGIN  
  --ROLLBACK TRANSACTION  
  RETURN @CheckURL  
 END  
 EXEC @currentSiteID=kmp..[Create_WebSite] @account,@password,@name,@province,@city,@phone,@contractname,@address,@sitedns,@qq,@Email,@phone,@memo,'28',@dict  
 IF @currentSiteID IS NULL OR @currentSiteID <=0   
 BEGIN  
  --ROLLBACK TRANSACTION  
  RETURN -1  
 END  
 ELSE IF EXISTS (SELECT siteid FROM site WHERE siteid=@currentSiteID)  
 BEGIN  
  --ROLLBACK TRANSACTION  
  RETURN 0  
 END  
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
  
 INSERT INTO site(siteid,name,description,address,sitedns,provice,city,regdatetime,contractname,qq,phone,accesscount,status,email,dict,org_id)   
    VALUES(@currentSiteID,@name,@description,@address,@sitedns,@province,@city,GETDATE(),@contractname,@qq,@phone,1,1,@Email,@dict,@org_id)  
 --------------- site_themesetting ----------------  
 DECLARE @themeid2 int  
 SELECT TOP(1) @themeid2=themeid FROM site_themelist WHERE siteid=-1 Order By NewID()  
 INSERT INTO site_themesetting(siteid,themeid,iscurrent,styleid,themeid2) VALUES(@currentSiteID,@themeid,1,0,@themeid2)  
  
 --------------- site_domain ----------------  
 INSERT INTO site_domain VALUES(@currentSiteID,@sitedns)  
  
 --------------- site_user ------------------  
 DECLARE @right_userid INT  
 INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status)  
 VALUES(@account,@password,'网站管理员',getdate(),@org_id,1)  
 SELECT @right_userid=@@IDENTITY  
 INSERT INTO KWebCMS_Right..sac_user_role(user_id,role_id) values(@right_userid,@manage_role_id)  
  
 INSERT INTO site_user(siteid,account,password,name,createdatetime,usertype,UID) VALUES(@currentSiteID,@account,@password,'网站管理员',GETDATE(),98,@right_userid)  
 SELECT @currentUserID=@@IDENTITY  
  
 DECLARE @csnr_siteid int  
 SET @csnr_siteid=1026  
 ------------ kin_friendhref ----------------  
 INSERT INTO kin_friendhref(caption,href,siteid,orderno)  
 SELECT caption,href,@currentSiteID,orderno FROM kin_friendhref WHERE siteid=@csnr_siteid ORDER BY id  
 ------------ kin_friendhref ----------------  
 ----------------- cms_content -----------------   
 INSERT INTO cms_content(categoryid,[content],title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,orderno,commentstatus,ispageing,status,siteid,viewcount,commentcount)   
 SELECT t1.categoryid,t1.content,t1.title,t1.titlecolor,t1.author,getdate(),t1.searchkey,t1.searchdescription,t1.browsertitle,t1.orderno,t1.commentstatus,t1.ispageing,t1.status,@currentSiteID,t1.viewcount,t1.commentcount FROM Templates_cms_content t1  
-- SELECT t1.createdatetime,t1.categoryid,t1.content,t1.title,t1.titlecolor,t1.author,getdate(),t1.searchkey,t1.searchdescription,t1.browsertitle,t1.orderno,t1.commentstatus,t1.ispageing,t1.status,0,0 FROM cms_content t1 inner join cms_category t2 on t1.categoryid=t2.categoryid  where t1.siteid=1026 and t2.siteid=0   
 ----------------- cms_content -----------------60  
 ----------------- cms_album -----------------  
 INSERT INTO cms_album(categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime,siteid)  
 SELECT t1.categoryid,t1.title,t1.searchkey,t1.searchdescription,t1.photocount,t1.cover,t1.orderno,getdate(),@currentSiteID FROM Templates_cms_album t1   
-- SELECT t1.createdatetime,t1.categoryid,t1.title,t1.searchkey,t1.searchdescription,t1.photocount,t1.cover,t1.orderno,getdate() FROM cms_album t1 inner join cms_category t2 on t1.categoryid=t2.categoryid WHERE t1.siteid=1026 and t2.siteid=0  
  
 INSERT INTO @tempAlbumTable SELECT t1.albumid,t2.albumid FROM  cms_album t1 inner join cms_album t2 on t1.categoryid=t2.categoryid WHERE t1.siteid=@csnr_siteid and t2.siteid=@currentSiteID and t1.deletetag = 1 and t2.deletetag = 1 
 ----------------- cms_album -----------------17  
 ----------------- cms_photo -----------------  
 INSERT INTO cms_photo(categoryid,albumid,title,[filename],filepath,filesize,orderno,commentcount,indexshow,flashshow,createdatetime,siteid)  
 SELECT t1.categoryid,t1.albumid,t1.title,t1.[filename],t1.filepath,t1.filesize,t1.orderno,t1.commentcount,t1.indexshow,t1.flashshow,t1.createdatetime,@currentSiteID FROM Templates_cms_photo t1   
-- SELECT t1.createdatetime,t1.categoryid,t1.albumid,t1.title,t1.[filename],t1.filepath,t1.filesize,t1.orderno,t1.commentcount,t1.indexshow,t1.flashshow,getdate() FROM cms_photo t1 inner join cms_category t2 on t1.categoryid=t2.categoryid WHERE t1.siteid=1026 and t2.siteid=0  
 UPDATE t1 SET t1.albumid=t2.newAlbumID FROM cms_photo t1 inner join @tempAlbumTable t2 on t1.albumid=t2.oldalbumid WHERE t1.siteid=@currentSiteID  
--  SELECT @currentOldAlbumID=albumid FROM cms_photo WHERE photoid=@photoid  
--  SELECT @currentNewAlbumID=newAlbumID FROM @tempAlbumTable WHERE oldAlbumID=@currentOldAlbumID  
--  UPDATE cms_photo SET albumid=@currentNewAlbumID WHERE photoid=@@IDENTITY  
 ----------------- cms_photo -----------------17  
 ----------------- cms_contentattachs -----------------   
 INSERT INTO cms_contentattachs(categoryid,contentid,title,filepath,[filename],filesize,viewcount,createdatetime,attachurl,isdefault,siteid)  
 SELECT categoryid,contenid,title,filepath,[filename],filesize,viewcount,createdatetime,attachurl,isdefault,@currentSiteID FROM Templates_cms_contentattachs  
-- SELECT t1.createdatetime,t1.categoryid,t1.contentid,t1.title,t1.filepath,t1.[filename],t1.filesize,t1.viewcount,getdate(),t1.attachurl,t1.isdefault FROM cms_contentattachs t1 inner join cms_category t2 on t1.categoryid=t2.categoryid WHERE t1.siteid=1026 and t2.siteid=0  
 ----------------- cms_contentattachs -----------------13  
  
   -------------------初始化空间大小-------------------  
   insert into site_spaceInfo(siteID,spaceSize,useSize,lastSize,lastUpdateTime) values(@currentSiteID,300*1024*1024,0,300*1024*1024,getdate())  
 IF @city=246  
 BEGIN  
  insert  into  blog..permissionsetting (ptype,kid) values(3,@currentSiteID)  
 END  
 IF @@ERROR <> 0  
 BEGIN  
  --ROLLBACK TRANSACTION  
  RETURN 0  
 END  
 ELSE  
 BEGIN  
  --COMMIT TRANSACTION  
  RETURN @currentSiteID  
 END  
  
 ----------------- 更新 site_menu -----------------  
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Create_Site', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Create_Site', @level2type=N'PARAMETER',@level2name=N'@Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Create_Site', @level2type=N'PARAMETER',@level2name=N'@password'
GO
