USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[permissionsetting_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[permissionsetting_GetListTag]
 @page int
,@size int
,@kid int
 AS 


SELECT 
	1  ,[pid] ,[ptype] ,[kid] FROM BlogApp..[permissionsetting]
	where kid=@kid


GO
