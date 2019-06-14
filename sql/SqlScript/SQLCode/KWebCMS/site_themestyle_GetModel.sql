USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themestyle_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-15
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[site_themestyle_GetModel]
@styleid int
AS
BEGIN
	SELECT styleid,themeid,title,thumbpath,webstyle,createdatetime 
	FROM site_themestyle
	WHERE styleid=@styleid
END




GO
