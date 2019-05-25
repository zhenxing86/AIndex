USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postsyscategory_relation_delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[blog_postsyscategory_relation_delete]
	@id int
AS
BEGIN
	DELETE from  blog_postsyscategory_relation
    WHERE postid=@id

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
