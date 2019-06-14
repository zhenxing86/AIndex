USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[keylog_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[keylog_Update]
 @ID int,
 @uid int,
 @dotime datetime,
 @descname varchar(2000),
 @ipaddress varchar(200),
 @module varchar(100),
 @remark varchar(max),
 @deletetag int
 
 AS 
	UPDATE [keylog] SET 
  [uid] = @uid,
 [dotime] = @dotime,
 [descname] = @descname,
 [ipaddress] = @ipaddress,
 [module] = @module,
 [remark] = @remark,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
