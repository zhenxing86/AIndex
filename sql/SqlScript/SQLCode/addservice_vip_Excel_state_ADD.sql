USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Excel_state_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[addservice_vip_Excel_state_ADD]
 @kid int,
  @intime datetime,
 @deletetag int,
 @uid int
 
 AS 
	INSERT INTO [addservice_vip_Excel_state](
	kid,
  [intime],
 [deletetag],
 [uid]
 
	)VALUES(
	@kid,
  @intime,
 @deletetag,
 @uid
 	
	)

	RETURN @kid



GO
