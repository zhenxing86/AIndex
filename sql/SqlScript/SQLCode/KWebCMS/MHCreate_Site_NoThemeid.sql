USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MHCreate_Site_NoThemeid]    Script Date: 2014/12/16 10:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                    
-- Author:      xie                  
-- Create date: 2013-10-25                    
-- Description:                     
-- Memo:                    
*/                    
ALTER Procedure [dbo].[MHCreate_Site_NoThemeid]                     
 @siteid int=1027,            
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
 @themeid int=230,                    
 @account nvarchar(30),                    
 @password nvarchar(64),                    
 @dict nvarchar(64),                    
 @memo nvarchar(500),                
 @area int=0,                
 @residence int=0,      
 @jxsid nvarchar(50)='0',
 @IP nvarchar(50) = '',
 @sendsms int = 1
AS                    
BEGIN                     
 set nocount on          
 Insert Into RegisterHistory(name, phone, account, [password], IP) Values(@name, @phone, @account, @password, @IP)     
 
 --黑名单
 if Exists (Select * From RegisterBlackList Where @IP Like IP + '%') Return
 
   set @themeid = 230          
   set @siteid = 1027          
                     
 if(@name like '%script%' or @contractname like '%script%'                  
 or @Email like '%script%' or @memo like '%script%' or @account like '%script%'                  
 or @contractname like '%script%' or @address like '%script%')                  
 begin                  
  return -1                  
 end                    
                 
 DECLARE @currentSiteID int --siteid                    
 DECLARE @userid int   --appuserid                    
 DECLARE @org_id int   --sac org_id                    
 DECLARE @themeid2 int  --pt theme                    
                   
 SET @themeid2=203                   
 IF exists(select * from  basicdata..[user] where account = @account and deletetag = 1)                
 return -1                
         
   if @jxsid <>'0531'      
   begin      
    --幼儿园表                    
   INSERT INTO basicdata..kindergarten(kname,privince,city,area,residence,actiondate,telephone,qq)                   
    VALUES (@name,@province,@city,@area,@residence,GETDATE(),@phone,@qq)         
   end           
   else      
   begin      
  INSERT INTO basicdata..kindergarten(kname,privince,city,area,residence,actiondate,telephone,qq,jxsnum)                   
    VALUES (@name,@province,@city,@area,@residence,GETDATE(),@phone,@qq,@jxsid)         
   end      
            
  SET @currentSiteID=ident_current('basicdata..kindergarten')                
                     
 INSERT INTO basicdata..[user](account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,mobile,email,address,enrollmentdate,headpic)                  
  VALUES(@account,@password,98,1,getdate(),@currentSiteID,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')                    
                        
 SET @userid = ident_current('basicdata..user')                  
                    
 INSERT INTO basicdata..user_baseinfo(userid,name,nickname,birthday,gender,nation,mobile,email,address,enrollmentdate,headpic)                    
    VALUES(@userid,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')                    
                      
INSERT INTO KWebCMS_Right..sac_org(org_name,create_datetime,up_org_id)                   
   VALUES(@name,getdate(),0)                    
                     
  SELECT @org_id=ident_current('KWebCMS_Right..sac_org')                         
                    
  --创建网站表                    
  INSERT INTO site(siteid,name,description,address,sitedns,provice,city,regdatetime,                  
    contractname,qq,phone,accesscount,status,email,dict,org_id,keyword)                     
   VALUES(@currentSiteID,@name,@description,@address,'http://'+convert(varchar,@currentSiteID)+'.zgyey.com',@province,                  
    @city,GETDATE(),@contractname,@qq,@phone,1,1,@Email,@dict,@org_id,@name)                   
                  
                                 
  --幼儿园配置表                                    
  INSERT INTO KWebCMS.dbo.site_config                  
    (siteid,shortname,code,memo, smsnum,ispublish,isportalshow,                  
     kindesc,copyright,guestopen,isnew,ptshotname,isvip,isvipcontrol,                  
     ispersonal,denycreateclass,classtheme,kinlevel,kinimgpath,theme,                  
     bbzxaccount,bbzxpassword,classphotowatermark,linkman,status)                  
   VALUES(@currentSiteID,@name,'',@memo,10,0,0,'','',0,0,@name,0,0,0,0,'','','',@themeid,'','','',@contractname,1)                    
                        
  INSERT INTO site_themesetting(siteid,themeid,iscurrent,styleid,themeid2)                   
   VALUES(@currentSiteID,@themeid,1,0,@themeid2)                   
            
  INSERT INTO site_domain(siteid,domain)                   
   VALUES(@currentSiteID,'http://'+convert(varchar,@currentSiteID)+'.zgyey.com')             
                      
  DECLARE @isxxt INT                    
  SET @isxxt=0                    
  IF (CharIndex('校讯通',@memo ,1)>0 or CharIndex('园讯通',@memo ,1)>0)            BEGIN                     
   SET @isxxt=1                    
  END                    
                      
  -- insert to reg_site_tmp                    
  INSERT INTO KWebCMS.dbo.reg_site_temp(userid,org_id,kname,currentsiteid,isxxt,themesiteid)                  
   VALUES(@userid,@org_id,@name,@currentSiteID,@isxxt,@siteid)                      
                     
                      
 IF @city=246                    
 BEGIN                    
  INSERT INTO  blogapp..permissionsetting (ptype,kid)                   
  VALUES(3,@currentSiteID)                    
 END                      
                    
 IF @memo like '%创典%'                   
 BEGIN                    
  INSERT INTO  blogapp..permissionsetting (ptype,kid)                   
  VALUES(81,@currentSiteID)                    
 END                    
                   
 IF @@ERROR <> 0                    
 BEGIN                    
  RETURN 0                    
 END                    
 ELSE                    
 BEGIN                      
  INSERT INTO synkid(kid, regdatetime)                   
   VALUES(@currentSiteID,getdate())         
  if @jxsid ='0531'      
  begin          
 insert into ossapp..jxs_kid(kid,jxsid)values(@currentSiteID,@jxsid)       
  end               
  IF(@province!=179) and @sendsms = 1
  BEGIN                    
   DECLARE @SMSContent VARCHAR(500)                    
   SET @SMSContent ='幼儿园:' +@name+ '电话:' +@phone +  '联系人:' +@contractname+ 'Q:' +@qq+'幼儿园'                     
                  
   INSERT INTO sms..sms_message_zy_ym (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)                    
   VALUES('', '18028633611',8,@SMSContent,getdate(),18,88,getdate(),0,0,0)                    
                  
   INSERT INTO sms..sms_message (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)                    
   VALUES('', '13808828988',0,@SMSContent,getdate(),18,88,getdate(),0,0,0)                    
                  
   INSERT INTO sms..sms_message_zy_ym (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)                    
   VALUES('', '18028633616',8,@SMSContent,getdate(),18,88,getdate(),0,0,0)                    
  END                    
 RETURN @currentSiteID                      
 END                    
                     
END 