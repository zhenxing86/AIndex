USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[bloguserkmpUser_getModel]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
------------------------------------  
--用途：取幼儿园绑定信息 --项目名称：ZGYEYBLOG   
--说明：   
--时间：2008-10-27 07:59:18   
--edit: 2009-09-27 14:39   
--exec [bloguserkmpUser_getModel] 294691   
------------------------------------  
CREATE PROCEDURE [dbo].[bloguserkmpUser_getModel]   
@bloguserid int   
 AS   
 	 

   
DECLARE @kmpuserid int    
DECLARE @usertype int 
 DECLARE @gender nvarchar(50)
set @kmpuserid=0    
SELECT @kmpuserid=userid FROM BasicData.dbo.user_bloguser WHERE bloguserid=@bloguserid  
IF (@kmpuserid<>0)  
BEGIN     
 SELECT @usertype=usertype,@gender=gender FROM BasicData.dbo.[user] WHERE userid=@kmpuserid   
 --如果配置表中无数据，初始化一条
   if not exists( select * from blog_baseconfig  where userid=@bloguserid)
 begin

	exec [blog_Register] @bloguserid,@kmpuserid,@usertype,@gender,''
end	
  
  
 IF(@usertype>0)     
 BEGIN      
  DECLARE @classid int     
  DECLARE @classname nvarchar(25)  
  SET @classid=(SELECT TOP(1) cid FROM BasicData.dbo.user_class WHERE userid=@kmpuserid)      
  SELECT @classname=cname FROM BasicDATA.dbo.class WHERE cid=@classid      
  select top 1 @bloguserid as bloguserid,@kmpuserid as kmpuserid,@classid as classid,@classname as classname,t2.kid,t2.kname,isnull(t5.domain,t7.netaddress) as kurl,@usertype as usertype ,t6.isvip  
  From  BasicData.dbo.[user] t1 inner join BasicData.dbo.kindergarten t2 on t1.kid=t2.kid   
   left join KWebCMS.dbo.site_domain t5 on t2.kid=t5.siteid  
   left join kwebcms.dbo.site_config t6 on t5.siteid=t6.siteid  
   left join ossapp..kinbaseinfo t7 on t2.kid=t7.kid  
  where t1.userid=@kmpuserid     
 END       
 ELSE     
 BEGIN      
  select top 1 @bloguserid as bloguserid,@kmpuserid as kmpuserid,t4.cid as classid,t4.cname as classname,t2.kid,t2.kname,isnull(t5.domain,t7.netaddress) as kurl,@usertype as usertype ,t6.isvip  
  From  BasicData.dbo.[user] t1 inner join BasicData.dbo.kindergarten t2 on t1.kid=t2.kid  
  left join BasicData.dbo.user_class t3 on t1.userid=t3.userid   
  left join BasicData.dbo.class t4 on t3.cid=t4.cid  
  left join KWebCMS.dbo.site_domain t5 on t2.kid=t5.siteid   
  left join kwebcms.dbo.site_config t6 on t5.siteid=t6.siteid  
  left join ossapp..kinbaseinfo t7 on t2.kid=t7.kid   
  where t1.userid=@kmpuserid      
 END       
END        
ELSE     
BEGIN   
  DECLARE @classid2 int        
  DECLARE @classname2 nvarchar(25)        
  DECLARE @kid2    int        
  set @kid2=0        
  SET @classid2=0        
  set @classname2=''              
  select userid as bloguserid,0 as kmpuserid,@classid2 as classid,@classname as classname, 0 as kid, '' as kname, '' as kurl,blogtype as usertype ,0 as isvip  
  from blog_baseconfig where userid=@bloguserid    
END  

GO
