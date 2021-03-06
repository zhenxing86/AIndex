USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themelist_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-14
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[site_themelist_Add]
@siteid int,
@title nvarchar(30),
@thumbpath nvarchar(200),
@status bit,
@iscustomer bit,
@previewUrl nvarchar(100),
@themecategoryid int
AS
BEGIN
	INSERT site_themelist(siteid,title,thumbpath,status,createdatetime,iscustomer,previewUrl,theme_category_id)
	VALUES (@siteid,@title,@thumbpath,@status,GETDATE(),@iscustomer,@previewUrl,@themecategoryid)

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_themelist_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
