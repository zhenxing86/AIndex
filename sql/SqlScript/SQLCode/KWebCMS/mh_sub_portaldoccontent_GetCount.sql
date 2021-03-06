USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_sub_portaldoccontent_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		along
-- Create date: 2009-12-26
-- Description:	获取子分类列表数量
--exec [mh_sub_portaldoccontent_GetCountByTitleAndDateTime] 'mhjhzj',5
-- =============================================
CREATE PROCEDURE [dbo].[mh_sub_portaldoccontent_GetCount]
@categorycode nvarchar(20),
@subcategoryid int
AS
BEGIN
	DECLARE @count int

	SELECT @count=count(1)
		FROM blogapp..thelp_documents t2, mh_doc_content_relation t3,cms_subcategory t4,mh_subcontent_relation t5
		WHERE t3.docid=t2.docid and t3.status=1
		AND t4.subcategoryid=t5.subcategoryid
		AND t5.contentid=t3.contentid
		AND t3.categorycode=@categorycode
		AND t4.subcategoryid=@subcategoryid
	RETURN @count
END









GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_sub_portaldoccontent_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
