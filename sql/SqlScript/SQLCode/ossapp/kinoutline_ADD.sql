USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinoutline_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
CREATE PROCEDURE [dbo].[kinoutline_ADD]
@kid int,
@outtime datetime,
@uid int

 AS 
	INSERT INTO [kinoutline](
	[kid],[outtime],[uid]
	)VALUES(
	@kid,@outtime,@uid
	)



GO
