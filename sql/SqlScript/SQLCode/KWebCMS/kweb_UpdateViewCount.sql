USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_UpdateViewCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	取文章内容
-- =============================================
CREATE PROCEDURE [dbo].[kweb_UpdateViewCount]
@contentid int
AS
BEGIN
	
	declare @viewcount int
	select @viewcount=viewcount from cms_content where contentid=@contentid and deletetag = 1
    --update cms_content set viewcount=viewcount+1 where contentid=@contentid	
    return @viewcount
END


GO
