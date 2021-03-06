USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentpaging_GetCountByContentID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-06
-- Description:	获取指定ContentID的分页内容数
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentpaging_GetCountByContentID]
@contentid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM cms_contentpaging WHERE contentid=@contentid
	RETURN @count
END



GO
