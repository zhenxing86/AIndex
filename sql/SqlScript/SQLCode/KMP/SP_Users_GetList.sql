USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Users_GetList]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Users_GetList]
 AS 
	SELECT 
	[ID],[LoginName],[Password],[Style],[UserType],[Activity],[Memo]
	 FROM T_Users WHERE Activity = 1
GO
