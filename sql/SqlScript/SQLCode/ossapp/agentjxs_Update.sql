USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentjxs_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[agentjxs_Update]
 @ID int,
  @bid int,
  @name varchar(50),
  @num varchar(50)
 AS 
	UPDATE [agentjxs] SET 
		bid=@bid,name=@name,num=@num
 	 WHERE ID=@ID


GO
