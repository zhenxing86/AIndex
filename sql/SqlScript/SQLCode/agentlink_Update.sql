USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentlink_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[agentlink_Update]
 @ID int,
 @gid int,
 @name varchar(100),
 @tel varchar(100),
 @qq varchar(100),
 @email varchar(100),
 @post varchar(100),
 @remark varchar(2000),
 @deletetag int
 
 AS 
	UPDATE [agentlink] SET 
  [gid] = @gid,
 [name] = @name,
 [tel] = @tel,
 [qq] = @qq,
 [email] = @email,
 [post] = @post,
 [remark] = @remark,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
