use ossapp
go
alter PROCEDURE [dbo].[kinbaseinfo_GetModel]      
@id int      
 AS       
      
declare @smsnum int,@bfid int,@kfid int,@smsautocount int,@smsbuycount int      
select  @smsnum=smsnum from kwebcms..site_config s where s.siteid=@id      
select  @bfid=b.id,@kfid=ID from dbo.beforefollow b where b.kid=@id      
select @smsautocount=autosmslimit from  KWebCMS.dbo.site_config where siteid = @id       
SELECT @smsbuycount = sum(ncount) FROM [smsbase] g where g.deletetag=1 and g.kid=@id

  
 SELECT       
  1      ,ID    ,kid    ,kname    ,regdatetime    ,ontime        
  ,expiretime    ,privince    ,city    ,area    ,linkstate    ,ctype         
 ,cflush    ,clevel    ,parentpay    ,infofrom    ,developer          
,k.status,invoicetitle    ,netaddress    ,[address]    ,remark    ,deletetag,abid ,@smsnum ,qq,isclosenet ,[finfofrom]    ,[fabid]    ,[fdeveloper],mobile,@bfid,@kfid,@smsautocount      
,k.residence,@smsbuycount  FROM [kinbaseinfo] k      
      
  WHERE kid=@id 
  
select *from BasicData..kindergarten