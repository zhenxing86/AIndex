USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_subcategory_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		along
-- Create date: 2009-12-25
-- Description:	得到子分类实体
-- =============================================
create PROCEDURE [dbo].[cms_subcategory_GetModel]
@subcategoryid int
AS
BEGIN
	SELECT subcategoryid,subtitle,categoryid FROM cms_subcategory WHERE subcategoryid=@subcategoryid
END







GO
