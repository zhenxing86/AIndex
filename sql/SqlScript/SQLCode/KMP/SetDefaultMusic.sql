USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SetDefaultMusic]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,设置默认背景音乐>
-- =============================================
create PROCEDURE [dbo].[SetDefaultMusic] 
	@ID nvarchar(50)
AS
BEGIN
declare @ArticleCategoryID int

select @ArticleCategoryID = ArticleCategoryID 
	from article_photo where photoid = @ID

update article_photo set IsIndexShow = 0 
	where ArticleCategoryID = @ArticleCategoryID

update article_photo set IsIndexShow = 1 where photoid = @ID

END

GO
