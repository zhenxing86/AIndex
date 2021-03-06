USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinfollow_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[kinfollow_Update]
 @ID int,
 @kid int,
 @followtype varchar(100),
 @fuid int,
 @uid int,
 @status varchar(20),
 @information varchar(3000),
 @intime datetime,
 @kf_id int,
 @isremind int,
 @stime datetime,
 @etime datetime,
 @ctime datetime,
 @deletetag int
 
 AS 
	UPDATE [kinfollow] SET 
  [kid] = @kid,
 [followtype] = @followtype,
 [fuid] = @fuid,
 [uid] = @uid,
 [status] = @status,
 [information] = @information,
 [intime] = @intime,
 [kf_id] = @kf_id,
 [isremind] = @isremind,
 [stime] = @stime,
 [etime] = @etime,
 [ctime] = @ctime,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
