USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_teachertrain_ADD]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[group_teachertrain_ADD]
  @userid int,
 @timetype int,
 @level int,
 @inuserid int,
 @gid int
 
 AS 
	INSERT INTO [group_teachertrain](
  [userid],
 [timetype],
 [level],
 [inuserid],
 [intime],
 [kid],
 [deletetag]
 
	)VALUES(
	
  @userid,
 @timetype,
 @level,
 @inuserid,
 getdate(),
 @gid,
1
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID










GO
