USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[role_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[role_ADD]
  @agbid int,
 @name varchar(100),
 @duty varchar(200),
 @describe varchar(2000),
 @deletetag int
 
 AS 
	INSERT INTO [role](
  [agbid],
 [name],
 [duty],
 [describe],
 [deletetag]
 
	)VALUES(
	
  @agbid,
 @name,
 @duty,
 @describe,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
