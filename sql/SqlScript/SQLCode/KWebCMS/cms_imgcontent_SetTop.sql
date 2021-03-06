USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_imgcontent_SetTop]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-08-08
-- Description:	文章置顶 或 取消
-- =============================================
CREATE PROCEDURE [dbo].[cms_imgcontent_SetTop]
@contentid int,
@isTop bit
AS
BEGIN
	DECLARE @orderno int
	DECLARE @titlecolor nvarchar(10)
	Declare @categoryid int
	SET @orderno=0
	SET @titlecolor=''

select @categoryid=categoryid from cms_imgcontent where contentid=@contentid and deletetag = 1

	IF @isTop=1
	BEGIN
		SELECT @orderno=Max(orderno)+1 FROM cms_imgcontent where categoryid=@categoryid and deletetag = 1
		SET @titlecolor='red'
	END
	else
	begin
		set @orderno = @contentid
	end
	UPDATE cms_imgcontent SET orderno=@orderno,titlecolor=@titlecolor WHERE contentid=@contentid
	
	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END

GO
