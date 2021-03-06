USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SetIsPortalShow]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,图片是否在门户显示>
-- =============================================
CREATE PROCEDURE [dbo].[SetIsPortalShow] 
	@ID nvarchar(50)
AS
BEGIN
declare @status int
declare @Kid int
declare @typecode varchar(10)
declare @covercount int
	select @status=IsPortalShow from article_photo where photoid = @ID
if (@status=0)
begin
	update article_photo set IsPortalShow = 1 where photoid = @ID
	select @Kid = a.KID,@typecode=ac.typecode from article_photo a left join articlecategory ac on a.articlecategoryid=ac.articlecategoryid
	 where a.photoid = @ID
	select @covercount=count(a.photoid) from article_photo a left join articlecategory ac on a.articlecategoryid=ac.articlecategoryid
	 where a.IsCover = 1 and a.kid=@Kid and ac.typecode=@typecode
	if (@covercount =0)
	begin
		update article_photo set IsCover = 1 where photoid = @ID 
	end

end
else if (@status=1)
begin
    update article_photo set IsPortalShow = 0 where photoid = @ID
end
END
GO
