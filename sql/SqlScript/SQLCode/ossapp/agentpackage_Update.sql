USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentpackage_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[agentpackage_Update]
 @ID int,
 @gid int,
 @money int,
 @remark varchar(500),
 @a1 int,
 @a2 int,
 @a3 int,
 @a4 int,
 @a5 int,
 @a6 int,
 @a7 int,
 @a8 int,
 @deletetag int
 
 AS 
	UPDATE [agentpackage] SET 
  [gid] = @gid,
 [money] = @money,
 [remark] = @remark,
 [a1] = @a1,
 [a2] = @a2,
 [a3] = @a3,
 [a4] = @a4,
 [a5] = @a5,
 [a6] = @a6,
 [a7] = @a7,
 [a8] = @a8,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
