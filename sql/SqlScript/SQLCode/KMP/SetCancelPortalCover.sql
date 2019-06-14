USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SetCancelPortalCover]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,图片是否封面显示>
-- =============================================
create PROCEDURE [dbo].[SetCancelPortalCover] 
	@ID nvarchar(50)
AS
BEGIN
declare @categoryid int
	--select @categoryid=articlecategoryid from article_photo where photoid = @ID
	--update article_photo set IsCover = 0 where articlecategoryid = @categoryid 
	update article_photo set IsCover = 0 where photoid = @ID
END


GO
