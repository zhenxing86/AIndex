USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[T_Kindergarten_GetModel]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		wuzy
-- Create date: 2010-12-19
-- Description:	班级主页获取水印和是否允许加入幼儿园
-- =============================================
CREATE PROCEDURE [dbo].[T_Kindergarten_GetModel]
@kid int
AS
SELECT denycreateclass,classphotowatermark FROM  kwebcms..site_config WHERE siteid=@kid




GO
