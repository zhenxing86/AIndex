USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
------------------------------------  
  
------------------------------------  
CREATE PROCEDURE [dbo].[kinbaseinfo_Update]  
 @ID int,  
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
 @invoicetitle varchar(100),  
 @netaddress varchar(100),  
 @address varchar(500),  
 @remark varchar(5000),  
 @deletetag int,  
 @uid int,  
 @abid int,  
 @qq varchar(100),  
 @isclosenet int,  
 @finfofrom varchar(50),  
 @fabid int,  
 @fdeveloper varchar(50),  
 @mobile varchar(50)  
   
 AS   
  
Begin TransAction   
declare @errno int   
  
 UPDATE [kinbaseinfo] SET   
  [kid] = @kid,  
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
 [netaddress] = @netaddress,  
 [address] = @address,  
 [remark] = @remark,  
 [deletetag] = @deletetag,  
 uid= @uid,  
 abid=@abid,  
 qq = @qq,  
 isclosenet=@isclosenet,  
 [finfofrom] = @finfofrom,  
 [fabid] = @fabid,  
 [fdeveloper] = @fdeveloper,  
mobile=@mobile  
   WHERE ID=@ID   
  
  
  
update [beforefollow] set [uid]=@uid,bid=@abid  
 ,[provice] = @privince  
 ,[city] = @city  
 ,[area] = @area  
 where [kid] = @kid  
  
  
  
--update KWebCMS..site_config set shortname=@kname where siteid=@kid  
  
  
  
update KWebCMS..site set phone=@mobile,address=@address,[status]=1 where siteid=@kid  
  
  
  
  
  
  
  
 If @@error>0   
  begin   
  
   rollback TransAction   
  end   
 Else  
  Begin   
   Commit TransAction  
  End   
  
  
GO
