USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_belong_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[users_belong_ADD]
  @puid int,
 @cuid int,
 @cduty varchar(50),
 @uid int,
 @bid int,
 @intime datetime,
 @deletetag int
 
 AS 
	INSERT INTO [users_belong](
  [puid],
 [cuid],
 [cduty],
 [uid],
 [bid],
 [intime],
 [deletetag]
 
	)VALUES(
	
  @puid,
 @cuid,
 @cduty,
 @uid,
 @bid,
 @intime,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
