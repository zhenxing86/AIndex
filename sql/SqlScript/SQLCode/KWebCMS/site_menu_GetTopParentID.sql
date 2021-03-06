USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_GetTopParentID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-12
-- Description:	获取默认的最前的一个ParentID号
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_GetTopParentID]
@siteid int,
@parentid int
AS
BEGIN
	DECLARE @parentid2 int
	SELECT TOP 1 @parentid2=menuid FROM site_menu WHERE menuid in (SELECT menuid FROM site_usermenu WHERE siteid=@siteid and parentid=@parentid) ORDER BY parentid ASC,orderno ASC
	RETURN @parentid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_GetTopParentID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
