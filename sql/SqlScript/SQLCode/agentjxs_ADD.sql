USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentjxs_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[agentjxs_ADD]
  @bid int,
  @name varchar(50),
  @num varchar(50)
 
 AS 
	INSERT INTO [agentjxs](
	 bid,
	 name,
	 num,
	 deletetag
	)VALUES(
			  @bid,
			  @name,
			  @num,
			  1
	 		)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID


GO
