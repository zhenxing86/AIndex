USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themelist_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-14
-- Description:	Update
-- =============================================
CREATE PROCEDURE [dbo].[site_themelist_Update]
@themeid int,
@siteid int,
@title nvarchar(30),
@thumbpath nvarchar(200),
@status bit,
@iscustomer bit,
@previewUrl nvarchar(100),
@themecategoryid int
AS
BEGIN
	IF EXISTS (SELECT * FROM site_themelist WHERE themeid=@themeid AND thumbpath=@thumbpath)
	BEGIN
		--未修改模板图片,不需要修改日期
		UPDATE site_themelist 
		SET siteid=@siteid,title=@title,thumbpath=@thumbpath,status=@status,iscustomer=@iscustomer,previewUrl=@previewUrl,theme_category_id=@themecategoryid
		WHERE themeid=@themeid
	END
	ELSE
	BEGIN
		UPDATE site_themelist 
		SET siteid=@siteid,title=@title,thumbpath=@thumbpath,status=@status,iscustomer=@iscustomer,previewUrl=@previewUrl,createdatetime=GETDATE(),theme_category_id=@themecategoryid
		WHERE themeid=@themeid
	END

	if(@siteid>0)
	begin
		update site_themesetting set themeid=@themeid where siteid=@siteid
	end
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_themelist_Update', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
