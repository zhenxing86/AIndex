USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_sub_content_category_add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[mh_sub_content_category_add]
@contentid int,
@subcategoryid int
AS
BEGIN
    	
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
