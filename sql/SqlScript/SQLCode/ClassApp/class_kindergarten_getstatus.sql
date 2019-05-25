USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_kindergarten_getstatus]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取幼儿园状态 
--项目名称：ClassHomePage
--说明：
--时间：2009-4-29 17:58:57
------------------------------------
CREATE PROCEDURE [dbo].[class_kindergarten_getstatus]
@kid int
AS
	DECLARE @status int
	select @status=kinstatus from ZGYEY_OM.dbo.kindergarten_attach_info where kid =@kid
	RETURN Isnull(@status, 0)

GO
