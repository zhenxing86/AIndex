USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[Log_UpKinTime_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[Log_UpKinTime_ADD]
  @abid int,
 @kid int,
 @old_time datetime,
 @new_time datetime,
 @uid int,
 @uptime datetime,
 @infofrom varchar(50),
 @remark varchar(100),
 @deletetag int
 
 AS 
	INSERT INTO [Log_UpKinTime](
  [abid],
 [kid],
 [old_time],
 [new_time],
 [uid],
 [uptime],
 [infofrom],
 [remark],
 [deletetag]
 
	)VALUES(
	
  @abid,
 @kid,
 @old_time,
 @new_time,
 @uid,
 @uptime,
 @infofrom,
 @remark,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID


GO
