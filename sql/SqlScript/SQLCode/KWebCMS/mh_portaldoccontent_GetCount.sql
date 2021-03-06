USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_portaldoccontent_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		along
-- Create date: 2009-12-24
-- Description:	获取门户分类内容总数
-- =============================================
CREATE PROCEDURE [dbo].[mh_portaldoccontent_GetCount]
@categorycode nvarchar(20)
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM mh_doc_content_relation 
	WHERE categorycode=@categorycode and status=1
	RETURN @count
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portaldoccontent_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
