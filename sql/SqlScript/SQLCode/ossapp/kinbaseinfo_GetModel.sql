USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kinbaseinfo_GetModel]    
@id int    
 AS     
    
declare @smsnum int,@bfid int,@kfid int,@smsautocount int    
select  @smsnum=smsnum from kwebcms..site_config s where s.siteid=@id    
select  @bfid=b.id,@kfid=ID from dbo.beforefollow b where b.kid=@id    
select @smsautocount=autosmslimit from  KWebCMS.dbo.site_config where siteid = @id     
    
 SELECT     
  1      ,ID    ,kid    ,kname    ,regdatetime    ,ontime      
  ,expiretime    ,privince    ,city    ,area    ,linkstate    ,ctype       
 ,cflush    ,clevel    ,parentpay    ,infofrom    ,developer        
,k.status,invoicetitle    ,netaddress    ,[address]    ,remark    ,deletetag,abid ,@smsnum ,qq,isclosenet ,[finfofrom]    ,[fabid]    ,[fdeveloper],mobile,@bfid,@kfid,@smsautocount    
,k.residence  FROM [kinbaseinfo] k    
    
  WHERE kid=@id 
GO
