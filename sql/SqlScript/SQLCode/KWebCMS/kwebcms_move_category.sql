USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kwebcms_move_category]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kwebcms_move_category]
@contentid int,
@fromcategoryid int,
@tocategoryid int
AS
BEGIN
    	
	declare @fromcategorycode nvarchar(20)
	declare @tocategorycode nvarchar(20)
	select @fromcategorycode=categorycode from cms_category where categoryid=@fromcategoryid
	select @tocategorycode =categorycode from cms_category where categoryid=@tocategoryid

	update mh_content_content_relation
	set categorycode=@tocategorycode
	where s_contentid = @contentid
	and categorycode=@fromcategorycode

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
