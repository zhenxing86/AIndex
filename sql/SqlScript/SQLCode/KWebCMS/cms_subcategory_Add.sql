USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_subcategory_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[cms_subcategory_Add]
@categoryid int,
@subtitle nvarchar(50)
AS
BEGIN	

	INSERT INTO cms_subcategory(subtitle,categoryid) VALUES(@subtitle,@categoryid)

	IF @@ERROR <> 0
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_subcategory_Add', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
