USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[content_content_category_add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[content_content_category_add]
@contentid int,
@categorycode nvarchar(20)
AS
BEGIN
    
	declare @categoryid int
	select @categoryid=categoryid from cms_category where categorycode=@categorycode	

	insert into mh_content_content_relation(s_contentid,actiondate,categorycode)
	values(@contentid,getdate(),@categorycode)

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'content_content_category_add', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
