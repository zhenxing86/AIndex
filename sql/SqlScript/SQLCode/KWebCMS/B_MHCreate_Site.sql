USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[B_MHCreate_Site]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec  [HMCreate_Site] 1026,'liaoxin999','test2','ededede','tddd','httt://dede1DDx.zgyey.net',28,29,'liaoxin',
--'349881223','349881223@qq.com','349881223',33,'liaoxin00000','123212','',''
---------------------------------------------------------
CREATE Procedure [dbo].[B_MHCreate_Site] 
@name nvarchar(50),
@currentSiteID int,
@city int,
@province int,
@phone nvarchar(30),
@contractname nvarchar(30),
@qq nvarchar(20)
AS
BEGIN
	
	
	
	declare @did int
	declare @did2 int
	DECLARE @tempAlbumTable TABLE
	(
		--定义临时相册表
		oldAlbumID int,
		newAlbumID int
	)
	  
 --创建部门可移值后面始化
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES(@name,0,1,1,@currentSiteID,GETDATE())
       
       SET @did=@@IDENTITY
      
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('行政部',@did,1,1,@currentSiteID,GETDATE())
       
       SET @did2=@@IDENTITY
       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('保育组',@did2,1,1,@currentSiteID,GETDATE())
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('财务组',@did2,2,1,@currentSiteID,GETDATE())
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('教学组',@did2,3,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('小班部',@did,4,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('中班部',@did,5,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('大班部',@did,6,1,@currentSiteID,GETDATE())
       
	--创建默认班级
	INSERT INTO Basicdata..class (kid,cname,grade,deletetag,actiondate,iscurrent,subno)
	SELECT @currentSiteID,name,classgrade,1,getdate(),1,0 from    basicdata..Templates_Class --where classgrade=35	
	
	
    INSERT INTO t_dictionarysetting (kid,dic_id) SELECT @currentSiteID,ClassGrade FROM KMP..Templates_Class	

	

	--------------- site_user ------------------
	

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
		exec ossapp..[init_kinbaseinfo]
		RETURN @currentSiteID		
	END

	----------------- 更新 site_menu -----------------
END

GO
