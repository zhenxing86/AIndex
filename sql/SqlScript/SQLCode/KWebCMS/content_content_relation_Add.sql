USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[content_content_relation_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-11
-- Description:	ADD
-- =============================================
CREATE PROCEDURE [dbo].[content_content_relation_Add]
@contentid int,
@categoryid int
AS
BEGIN
	BEGIN TRANSACTION

	DECLARE @categorycode nvarchar(20)
	SELECT @categorycode=categorycode FROM cms_category WHERE categoryid=@categoryid

	IF EXISTS(SELECT * FROM mh_content_content_relation WHERE s_contentid=@contentid)
	BEGIN
		UPDATE mh_content_content_relation SET categorycode=@categorycode WHERE s_contentid=@contentid
	END
	ELSE
	BEGIN
		INSERT INTO mh_content_content_relation(s_contentid,actiondate,categorycode,status)
		VALUES(@contentid,GETDATE(),@categorycode,5)	
	END

	DELETE mh_subcontent_relation WHERE contentid=@contentid
	
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 1
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'content_content_relation_Add', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
