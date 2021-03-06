USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_defaultpage_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-13
-- Description:	获取默认首页
-- =============================================
CREATE PROCEDURE [dbo].[kweb_defaultpage_GetModel]
@siteid int
AS
BEGIN
	SELECT TOP 1 defaultpageid,siteid,defaultpage,startdatetime,enddatetime
	FROM defaultpage 
	WHERE startdatetime<GETDATE() AND enddatetime>GETDATE() AND siteid=@siteid
	ORDER BY startdatetime DESC,enddatetime ASC
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_defaultpage_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
