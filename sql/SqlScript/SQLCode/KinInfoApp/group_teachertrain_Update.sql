USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_teachertrain_Update]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[group_teachertrain_Update]
 @ID int,
 @timetype int,
 @level int,
 @inuserid int
 
 AS 
	UPDATE [group_teachertrain] SET 
 [timetype] = @timetype,
 [level] = @level,
 [inuserid] = @inuserid
 	 WHERE ID=@ID 








GO
