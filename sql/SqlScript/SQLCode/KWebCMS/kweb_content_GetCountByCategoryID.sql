USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetCountByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-28
-- Description:	GetCount
-- Memo:
*/
CREATE PROCEDURE [dbo].[kweb_content_GetCountByCategoryID]
	@categoryid int
AS
BEGIN	
	DECLARE @count int
	SELECT @count = count(*) 
		FROM cms_content 
		WHERE categoryid = @categoryid 
			AND status = 1 and deletetag = 1
			AND isnull(draftstatus,0) = 0
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetCountByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
