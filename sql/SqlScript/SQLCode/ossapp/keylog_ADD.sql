USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[keylog_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[keylog_ADD]
  @uid int,
 @dotime datetime,
 @descname varchar(2000),
 @ipaddress varchar(200),
 @module varchar(100),
 @remark varchar(max),
 @deletetag int
 
 AS 
 
 
 declare @keys varchar(200)=''
if(charindex('kid=',@remark)>0)
begin
 SET ANSI_WARNINGS OFF  
select @keys=replace(col,'kid=','') FROM CommonFun..[f_split](@remark,'@') where col like 'kid=%'
 SET ANSI_WARNINGS ON
end



	INSERT INTO LogData..ossapp_keylog(
  [uid],
 [dotime],
 [descname],
 [ipaddress],
 [module],
 [remark],
 [deletetag],
 keys
	)VALUES(
	
  @uid,
 @dotime,
 @descname,
 @ipaddress,
 @module,
 @remark,
 @deletetag,
 @keys	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID

GO
