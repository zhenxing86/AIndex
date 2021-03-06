USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MHCreate_Site_jxs]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec  MHCreate_Site 1026,'yeyname','','','','http://20121115001.zgyey.com',28,29,'','47245183','47245183@qq.com','47245183',310,'20121115001','123123','',''
---------------------------------------------------------
CREATE Procedure [dbo].[MHCreate_Site_jxs] 
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
@memo nvarchar(500),
@jxsid nvarchar(50),
@area int=0,
@residence int=0
AS
BEGIN
	DECLARE @currentSiteID int	--siteid
	
	DECLARE @userid int			--appuserid
	DECLARE @org_id int			--sac org_id
	DECLARE @themeid2 int		--pt theme
	SET @themeid2=203	

 IF exists(select * from  basicdata..[user] where account = @account and deletetag = 1)
 return -1
 IF exists(select * from  basicdata..kindergarten k inner join KWebCMS..site s on k.kid = s.siteid and k.deletetag = 1 where s.sitedns = @sitedns)
 return -1
 
 		--幼儿园表
		INSERT INTO basicdata..kindergarten(kname,privince,city,area,residence,actiondate,telephone,qq,jxsnum) 
			VALUES (@name,@province,@city,@area,@residence,GETDATE(),@phone,@qq,@jxsid)
		SET @currentSiteID = ident_current('basicdata..kindergarten')  
		
 	INSERT INTO basicdata..[user](account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,mobile,email,address,enrollmentdate,headpic)
 	VALUES(@account,@password,98,1,getdate(),@currentSiteID,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')    
	SET @userid = ident_current('basicdata..user')  
	INSERT INTO basicdata..user_baseinfo(userid,name,nickname,birthday,gender,nation,mobile,email,address,enrollmentdate,headpic)
    VALUES(@userid,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')
    
		--创建网站表
		INSERT INTO site(siteid,name,description,address,sitedns,provice,city,regdatetime,contractname,qq,phone,accesscount,status,email,dict,org_id,keyword) 
		VALUES(@currentSiteID,@name,@description,@address,@sitedns,@province,@city,GETDATE(),@contractname,@qq,@phone,1,1,@Email,@dict,@org_id,@name)
		
       
		--幼儿园配置表                
		INSERT INTO KWebCMS.dbo.site_config(siteid,shortname,code,memo,smsnum,ispublish,isportalshow,kindesc,copyright,guestopen,isnew,ptshotname,isvip,isvipcontrol,ispersonal,denycreateclass,classtheme,kinlevel,kinimgpath,theme,bbzxaccount,bbzxpassword,classphotowatermark,linkman,status)VALUES(@currentSiteID,@name,'',@memo,10,0,0,'','',0,0,@name,0,0,0,0,'','','',@themeid,'','','',@contractname,1)
		
		INSERT INTO KWebCMS_Right..sac_org(org_name,create_datetime,up_org_id) VALUES(@name,getdate(),0)
		SELECT @org_id=ident_current('KWebCMS_Right..sac_org')  	
		--------------- site_themesetting ----------------
		
		INSERT INTO site_themesetting(siteid,themeid,iscurrent,styleid,themeid2) VALUES(@currentSiteID,@themeid,1,0,@themeid2)
		--------------- site_domain ----------------
		INSERT INTO site_domain(siteid,domain) VALUES(@currentSiteID,@sitedns)	
		
		
		DECLARE @isxxt INT
		SET @isxxt=0
		IF (CharIndex('校讯通',@memo ,1)>0 or CharIndex('园讯通',@memo ,1)>0)
		BEGIN	
			SET @isxxt=1
		END
		
		-- insert to reg_site_tmp
		INSERT INTO KWebCMS.dbo.reg_site_temp(userid,org_id,kname,currentsiteid,isxxt,themesiteid)VALUES(@userid,@org_id,@name,@currentSiteID,@isxxt,@siteid)		
          
 	
	IF @city=246
	BEGIN
		INSERT INTO  blogapp..permissionsetting (ptype,kid) VALUES(3,@currentSiteID)
	END
	IF @@ERROR <> 0
	BEGIN
	
		RETURN 0
	END
	ELSE
	BEGIN		
		INSERT INTO synkid(kid,	regdatetime) VALUES(@currentSiteID,getdate())
		insert into ossapp..jxs_kid(kid,jxsid)values(@currentSiteID,@jxsid)
		IF(@province!=179)
		BEGIN
			DECLARE @SMSContent VARCHAR(500)
			SET @SMSContent ='幼儿园:' +@name+ '电话:' +@phone +  '联系人:' +@contractname+ 'Q:' +@qq+'幼儿园'	

			INSERT INTO sms..sms_message_zy_ym (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
			VALUES('', '18028633611',8,@SMSContent,getdate(),18,88,getdate(),0,0,0)

			INSERT INTO sms..sms_message_zy_ym (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
			VALUES('', '13808828988',8,@SMSContent,getdate(),18,88,getdate(),0,0,0)

		END
		
		RETURN @currentSiteID		
	END
	
END











GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MHCreate_Site_jxs', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MHCreate_Site_jxs', @level2type=N'PARAMETER',@level2name=N'@Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MHCreate_Site_jxs', @level2type=N'PARAMETER',@level2name=N'@password'
GO
