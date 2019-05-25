USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_Kindergarten_GetModel]    Script Date: 2014/11/24 23:12:24 ******/
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
SELECT denycreateclass,classphotowatermark FROM  T_Kindergarten WHERE id=@kid

GO
