USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_content_content_relation_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[mh_content_content_relation_Delete]
@id int
AS
BEGIN
    DELETE from  mh_content_content_relation
    WHERE s_contentid=@id

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
