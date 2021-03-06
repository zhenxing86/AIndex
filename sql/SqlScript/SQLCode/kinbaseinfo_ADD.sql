USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_ADD]    Script Date: 05/14/2013 14:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------

------------------------------------
alter PROCEDURE [dbo].[kinbaseinfo_ADD]
  @kid int,
 @kname varchar(200),
 @regdatetime datetime,
 @ontime datetime,
 @expiretime datetime,
 @privince varchar(30),
 @city varchar(30),
 @area varchar(30),
 @linkstate varchar(100),
 @ctype varchar(100),
 @cflush varchar(200),
 @clevel varchar(100),
 @parentpay varchar(100),
 @infofrom varchar(50),
 @developer varchar(50),
 @status varchar(30),
 @invoicetitle VARCHAR(300),
 @netaddress varchar(100),
 @address varchar(500),
 @remark varchar(4500),
 @deletetag int,
 @uid int,
 @abid int,
 @qq varchar(100),
 @isclosenet int,
 @finfofrom varchar(50),
 @fabid int,
 @fdeveloper varchar(50),
 @mobile nvarchar(500),  
 @residence varchar(100)='0'  
 AS 
 
 
   
declare @ID int  
select @ID=ID from [kinbaseinfo] where  [kid] = @kid  
  
  
  
  
 --不操作域名 
--declare @net_old varchar(100)  
--   select @net_old=netaddress from [kinbaseinfo] where kid=@kid  
  
--   IF EXISTS(SELECT top 1 * FROM KWebCMS..site_domain WHERE domain=@net_old and siteid=@kid)  
-- BEGIN  
--  update KWebCMS..[site_domain] set domain=@netaddress  
--  WHERE siteid=@kid and domain=@net_old  
-- END   
-- ELSE  
-- BEGIN  
--  insert into KWebCMS..[site_domain](siteid,domain)  
--  values(@kid,@netaddress)  
-- end  
   
-- update Kwebcms..[site] set  sitedns=@netaddress where siteid=@kid  
  
Begin TransAction   
  
  
declare @pcount int  
select @pcount=count(1) from [kinbaseinfo] where  [kid] = @kid  
  
if(@pcount=0)  
begin  
INSERT INTO [kinbaseinfo](  
  [kid],  
 [kname],  
 [regdatetime],  
 [ontime],  
 [expiretime],  
 [privince],  
 [city],  
 [area],  
 [linkstate],  
 [ctype],  
 [cflush],  
 [clevel],  
 [parentpay],  
 [infofrom],  
 [developer],  
 [status],  
invoicetitle,  
 [netaddress],  
 [address],  
 [remark],  
 [deletetag], uid,abid,qq,isclosenet,[finfofrom],[fabid],[fdeveloper],mobile  
 ,residence  
 )VALUES(  
   
  @kid,  
 @kname,  
 @regdatetime,  
 @ontime,  
 @expiretime,  
 @privince,  
 @city,  
 @area,  
 @linkstate,  
 @ctype,  
 @cflush,  
 @clevel,  
 @parentpay,  
 @infofrom,  
 @developer,  
 @status,  
@invoicetitle,  
 @netaddress,  
 @address,  
 @remark,  
 @deletetag, @uid,@abid,@qq,@isclosenet,@finfofrom,@fabid,@fdeveloper,@mobile  
  ,@residence  
 )  
set @ID=@@IDENTITY  
end  
else   
begin  
  
UPDATE [kinbaseinfo] SET   
    
 [kname] = @kname,  
 [regdatetime] = @regdatetime,  
 [ontime] = @ontime,  
 [expiretime] = @expiretime,  
 [privince] = @privince,  
 [city] = @city,  
 [area] = @area,  
 [linkstate] = @linkstate,  
 [ctype] = @ctype,  
 [cflush] = @cflush,  
 [clevel] = @clevel,  
 [parentpay] = @parentpay,  
 [infofrom] = @infofrom,  
 [developer] = @developer,  
 [status] = @status,  
invoicetitle=@invoicetitle,  
 --[netaddress] = @netaddress,  
 [address] = @address,  
 [remark] = @remark,  
 [deletetag] = @deletetag, uid= @uid,abid=@abid, qq=@qq,isclosenet=@isclosenet, [finfofrom] = @finfofrom,  
 [fabid] = @fabid,  
 [fdeveloper] = @fdeveloper,  
 mobile=@mobile,  
 residence=@residence  
   WHERE [kid] = @kid  
  
  
--declare @luid varchar(20),@lbid varchar(20),@lprovice varchar(20),@lcity varchar(20),@larea varchar(20)  
--select @luid=[uid],@lbid=bid,@lprovice=provice,@lcity=city,@larea=area from [beforefollow] where [kid] = @kid  
  
--insert into dbo.keylog([uid],dotime,descname,ipaddress,module,remark,deletetag)  
--values(@uid,GETDATE(),'同步营销资料','0,0,0,0','资料同步','[@luid]='+@luid+'[@lbid]='+@lbid+'[@lprovice]='+@lprovice+'[@lcity]='+@lcity+'[@larea]='+@larea,1)  
  
update [beforefollow] set [uid]=@developer,bid=@abid  
 ,[provice] = @privince  
 ,[city] = @city  
 ,[area] = @area  
 ,residence=@residence  
 where [kid] = @kid  
  
  
update KWebCMS.dbo.[site] set provice=@privince,city=@city where siteid=@kid

--update KWebCMS..site_config set shortname=@kname where siteid=@kid  
  
update KWebCMS..[site] set phone=@mobile,[address]=@address,[name]=@kname,[status]=1 where siteid=@kid  
  
update BasicData..kindergarten set kname=@kname where kid=@kid  
  
  
declare @did int  
select @did=MIN(did) from basicdata..department   
where kid=@kid and superior=0  
  
update basicdata..department set dname=@kname where did=@did and kid=@kid  
  
end  



 If @@error>0 
  begin 

   rollback TransAction 
	RETURN 0
  end 
 Else
  Begin 
   Commit TransAction
	RETURN @ID
  End
GO

--select * from basicdata..department where kid=12511 and superior=0

--select * from basicdata..department where kid in
--(
--select kid from basicdata..department 
--where  superior=0 and deletetag=1
--group by kid having COUNT(1)>1
--) and superior=0