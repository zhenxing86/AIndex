USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_album_GetCountByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-16
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[kweb_album_GetCountByCategoryID]
@categoryid int
AS
BEGIN	
 DECLARE @count int  
 SELECT @count=count(*) FROM cms_album WHERE categoryid=@categoryid AND photocount>0 and deletetag = 1
 RETURN @count  
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetCountByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
