USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[Get_XQJYPT]    Script Date: 2014/11/24 21:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Get_XQJYPT]
@kid int
 AS 

	select kid 
		from blogapp..permissionsetting 
		where ptype=87 and kid=@kid
	


GO
