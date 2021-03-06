USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[content_content_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-12
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[content_content_GetModel]
@contentid int
AS
BEGIN
	SELECT s_contentid AS contentid,categoryid,a.categorycode,status,actiondate,subcategoryid,b.createdatetime 
	FROM mh_content_content_relation a 
	LEFT JOIN mh_subcontent_relation b ON a.s_contentid=b.contentid
	LEFT JOIN cms_category c ON a.categorycode=c.categorycode AND siteid=18
	WHERE a.s_contentid=@contentid
END



GO
