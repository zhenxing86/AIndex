USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[cms_category_GetList]
AS
BEGIN
	SELECT [categoryid],[title],[description],[parentid],[categorytype],[orderno],[categorycode],[siteid],[createdatetime],[iconid]
	FROM cms_category
END




GO
