USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetDefaultClassMusic]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_SetDefaultClassMusic]
@ClassID varchar(50),
@ID varchar(50)
 AS 
	BEGIN TRAN

	UPDATE classBackgroundMusic set isdefault = 0 where ClassID=@ClassID
	UPDATE classBackgroundMusic set isdefault = 1 where ID = @ID	
	
	COMMIT TRAN
GO
