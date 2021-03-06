USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SetIsIndexShow]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,图片是否在门户显示>
-- =============================================
CREATE PROCEDURE [dbo].[SetIsIndexShow] 
	@ID nvarchar(50)
AS
BEGIN
declare @status int
	select @status=IsIndexShow from article_photo where photoid = @ID
if (@status=0)
begin
	update article_photo set IsIndexShow = 1 where photoid = @ID
end
else if (@status=1)
begin
    update article_photo set IsIndexShow = 0 where photoid = @ID
end
END

GO
