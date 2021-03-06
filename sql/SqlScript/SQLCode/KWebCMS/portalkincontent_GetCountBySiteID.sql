USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalkincontent_GetCountBySiteID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[portalkincontent_GetCountBySiteID]
@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM portalkincontent WHERE fromsiteid=@siteid and deletetag = 1
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalkincontent_GetCountBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
