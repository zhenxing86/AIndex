USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	得到域名对象实体
-- =============================================
CREATE PROCEDURE [dbo].[site_domain_GetModel]
@id int
AS
BEGIN
	SELECT * FROM site_domain WHERE id=@id
END


GO
