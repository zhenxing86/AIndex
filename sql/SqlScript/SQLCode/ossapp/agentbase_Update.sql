USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentbase_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[agentbase_Update]
 @ID int,
 @uid int,
 @name varchar(50),
 @mastername varchar(200),
 @tel varchar(100),
 @qq varchar(100),
 @isone int,
 @remark varchar(5000),
 @deletetag int
 
 AS 
	UPDATE [agentbase] SET 
  [uid] = @uid,
 [name] = @name,
 [mastername] = @mastername,
 [tel] = @tel,
 [qq] = @qq,
 [isone] = @isone,
 [remark] = @remark,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
