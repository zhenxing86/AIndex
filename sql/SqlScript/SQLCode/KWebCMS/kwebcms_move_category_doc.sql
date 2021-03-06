USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kwebcms_move_category_doc]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [kwebcms_move_category_doc] 45700,63283,63288
--select * from mh_doc_content_relation where contentid=45700
create PROCEDURE [dbo].[kwebcms_move_category_doc]
@contentid int,
@fromcategoryid int,
@tocategoryid int
AS
BEGIN
    	
	declare @fromcategorycode nvarchar(20)
	declare @tocategorycode nvarchar(20)
	select @fromcategorycode=categorycode from cms_category where categoryid=@fromcategoryid
	select @tocategorycode =categorycode from cms_category where categoryid=@tocategoryid

	update mh_doc_content_relation
	set categorycode=@tocategorycode
	where contentid = @contentid
	--and categorycode=@fromcategorycode

	update cms_content set categoryid = @tocategoryid 
	where contentid=@contentid

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
