USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Excel_state_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[addservice_vip_Excel_state_Update]
 @kid int,
 @intime datetime,
 @deletetag int,
 @uid int
 
 AS 
	UPDATE [addservice_vip_Excel_state] SET 
  [intime] = @intime,
 [deletetag] = @deletetag,
 [uid] = @uid
 	 WHERE kid=@kid 



GO
