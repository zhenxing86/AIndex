USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[keylog_ADD]    Script Date: 2014/11/24 23:22:52 ******/
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
	INSERT INTO [keylog](
  [uid],
 [dotime],
 [descname],
 [ipaddress],
 [module],
 [remark],
 [deletetag]
 
	)VALUES(
	
  @uid,
 @dotime,
 @descname,
 @ipaddress,
 @module,
 @remark,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID





GO
