USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MHCreate_Site_NoThemeid]    Script Date: 09/15/2015 15:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                      
-- Author:      xie                    
-- Create date: 2013-10-25                      
-- Description:                       
-- Memo:                      
--时光树注册的幼儿园网站，默认勾选  只使用微网站   的权限 by 陈舒婷 at 2015.07.08  
*/     


                 
declare                   
 @siteid int=29994,              
 @name nvarchar(50),                      
 --@description nvarchar(300),                      
 --@address nvarchar(500),                      
 --@copyright nvarchar(1000),                      
 --@sitedns nvarchar(100),                      
 @province int,                      
 @city int,                      
 @contractname nvarchar(30),                      
 --@qq nvarchar(20),                      
 --@Email nvarchar(100),                      
 --@phone nvarchar(30),                      
 @themeid int=230,                      
 --@account nvarchar(30),                      
 --@password nvarchar(64),                      
 --@dict nvarchar(64),                      
 @memo nvarchar(500),                  
 --@area int=0,                  
 --@residence int=0,        
 @jxsid nvarchar(50)='0' 
 --@IP nvarchar(50) = '',  
 --@sendsms int = 1,  
 --@proxyid int = null  
                    
BEGIN                         
 set nocount on              


--select * from basicdata..kindergarten where kid= @siteid
         
 DECLARE @currentSiteID int --siteid                        
 DECLARE @userid int   --appuserid                        
 DECLARE @org_id int   --sac org_id                        
 DECLARE @themeid2 int  --pt theme                        
                       
 SET @themeid2=203                       
                      
  SET @currentSiteID=@siteid                 
                         
 --INSERT INTO basicdata..[user](account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,mobile,email,address,enrollmentdate,headpic)                      
 -- VALUES(@account,@password,98,1,getdate(),@currentSiteID,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')                        
                            
 select top 1 @userid =userid from basicdata..[user] where usertype=98 and deletetag=1 and kid= 29994  order by userid
                        
 INSERT INTO basicdata..user_baseinfo(userid,name,nickname,birthday,gender,nation,mobile,email,address,enrollmentdate,headpic)                        
    select userid,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg'
     from BasicData..[user] u
      where userid = @userid and not exists(
		select 1 from BasicData..user_baseinfo ub
		 where u.userid = ub.userid
      )                      

if not exists ( select * from site where siteid=@siteid)  
begin                      
INSERT INTO KWebCMS_Right..sac_org(org_name,create_datetime,up_org_id)                       
   VALUES(@name,getdate(),0)                        
                         
  SELECT @org_id=ident_current('KWebCMS_Right..sac_org')                             
           
  --创建网站表                        
  INSERT INTO site(siteid,name,description,address,sitedns,provice,city,regdatetime,                      
    contractname,qq,phone,accesscount,status,email,dict,org_id,keyword)                         
   VALUES(@currentSiteID,@name,'','','http://'+convert(varchar,@currentSiteID)+'.zgyey.com',@province,                      
    @city,GETDATE(),@contractname,'','',1,1,'','',@org_id,@name)                       
end
                                   
  --幼儿园配置表  
  if  not exists ( select * from KWebCMS.dbo.site_config where siteid= @currentSiteID)                                         
  INSERT INTO KWebCMS.dbo.site_config                      
    (siteid,shortname,code,memo, smsnum,ispublish,isportalshow,                      
     kindesc,copyright,guestopen,isnew,ptshotname,isvip,isvipcontrol,                      
     ispersonal,denycreateclass,classtheme,kinlevel,kinimgpath,theme,                      
     bbzxaccount,bbzxpassword,classphotowatermark,linkman,status)                      
   VALUES(@currentSiteID,@name,'',@memo,10,0,0,'','',0,0,@name,0,0,0,0,'','','',@themeid,'','','',@contractname,1)                        
  
 
 if  not exists ( select * from site_themesetting where siteid= @currentSiteID)                           
  INSERT INTO site_themesetting(siteid,themeid,iscurrent,styleid,themeid2)                       
   VALUES(@currentSiteID,@themeid,1,0,@themeid2)                       
  
  if  not exists ( select * from site_domain where siteid= @currentSiteID)               
  INSERT INTO site_domain(siteid,domain)                       
   select @currentSiteID,'http://'+convert(varchar,@currentSiteID)+'.zgyey.com'
               
                          
  DECLARE @isxxt INT                        
  SET @isxxt=0                        
  IF (CharIndex('校讯通',@memo ,1)>0 or CharIndex('园讯通',@memo ,1)>0)              
  BEGIN                         
   SET @isxxt=1                        
  END     
                  
 if  not exists ( select * from KWebCMS.dbo.reg_site_temp where userid=@userid and themesiteid= @currentSiteID)                      
  INSERT INTO KWebCMS.dbo.reg_site_temp(userid,org_id,kname,currentsiteid,isxxt,themesiteid)                      
   VALUES(@userid,@org_id,@name,@currentSiteID,@isxxt,@siteid)                          
                         
                          
 IF @city=246                        
 BEGIN 
 
   if  not exists ( select * from blogapp..permissionsetting where ptype=3 and kid= @currentSiteID)                       
  INSERT INTO  blogapp..permissionsetting (ptype,kid)                       
  VALUES(3,@currentSiteID)                        
 END                          
            
 END                        
    
    
 IF @@ERROR <> 0                        
 BEGIN                        
  select 0                        
 END                        
 ELSE                        
 BEGIN                          
	  INSERT INTO synkid(kid, regdatetime)                       
	   VALUES(@currentSiteID,getdate())             
	  if @jxsid ='0531'          
	  begin              
	 insert into ossapp..jxs_kid(kid,jxsid)values(@currentSiteID,@jxsid)           
	  end                   
      select 1                 
  END                                           
 END                        
                         
END   
