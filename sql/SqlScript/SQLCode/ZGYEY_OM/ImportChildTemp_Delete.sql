USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[ImportChildTemp_Delete]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：
--项目名称：
--说明：
--时间：2009-3-2 15:20:13
-----------------------------------
create PROCEDURE [dbo].[ImportChildTemp_Delete]
@kid int
 AS 	
	
	delete childtemp where kid=@kid
	
	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END




GO
