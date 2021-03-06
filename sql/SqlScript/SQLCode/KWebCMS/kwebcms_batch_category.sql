USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kwebcms_batch_category]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [kwebcms_move_category_doc] 45700,63283,63288
--select * from mh_doc_content_relation where contentid=45700
create PROCEDURE [dbo].[kwebcms_batch_category]
@contentid int,
@categoryid int,
@subcategoryid int
AS
BEGIN
    	
	declare @categorycode nvarchar(20)	
	select @categorycode=categorycode from cms_category where categoryid=@categoryid	

	insert into mh_content_content_relation(s_contentid,actiondate,categorycode)
	values(@contentid,getdate(),@categorycode)

	insert into mh_subcontent_relation(subcategoryid,contentid,createdatetime)
	values(@subcategoryid,@contentid,getdate())


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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kwebcms_batch_category', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
