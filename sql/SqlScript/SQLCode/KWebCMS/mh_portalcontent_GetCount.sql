USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_portalcontent_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-24
-- Description:	获取门户分类内容总数
-- =============================================
CREATE PROCEDURE [dbo].[mh_portalcontent_GetCount]
@categorycode nvarchar(20)
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM mh_content_content_relation c ,cms_content  t,[site] s
	WHERE c.categorycode=@categorycode  and c.s_contentid=t.contentid 
	and t.siteid = s.siteid  and c.status=1 and t.deletetag = 1
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portalcontent_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
