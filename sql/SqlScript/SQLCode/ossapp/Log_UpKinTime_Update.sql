USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[Log_UpKinTime_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[Log_UpKinTime_Update]
 @ID int,
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
	UPDATE [Log_UpKinTime] SET 
  [abid] = @abid,
 [kid] = @kid,
 [old_time] = @old_time,
 [new_time] = @new_time,
 [uid] = @uid,
 [uptime] = @uptime,
 [infofrom] = @infofrom,
 [remark] = @remark,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
