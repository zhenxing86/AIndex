USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_portaldoccontent_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		along
-- Create date: 2009-12-23
-- Description:	GetList
--exec [mh_portaldoccontent_GetListByPage] 'mhjhzj',1,10
-- =============================================
CREATE PROCEDURE [dbo].[mh_portaldoccontent_GetListByPage]
@categorycode nvarchar(20),
@page int,
@size int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT contentid FROM mh_doc_content_relation
		WHERE categorycode=@categorycode and status=1
		ORDER BY docid DESC

		SET ROWCOUNT @size
		SELECT t3.contentid,t2.userid,t2.author,t2.title,t2.createdatetime,t2.viewcount,
		(select b1.subtitle from cms_subcategory b1,mh_subcontent_relation b2
	where b1.subcategoryid=b2.subcategoryid
	and b2.contentid=t3.contentid) as subtitle,
(select b1.subcategoryid from cms_subcategory b1,mh_subcontent_relation b2
	where b1.subcategoryid=b2.subcategoryid
	and b2.contentid=t3.contentid) as subcategoryid,t2.docid
		FROM blogapp..thelp_documents t2, mh_doc_content_relation t3,@tmptable
		WHERE row > @ignore AND t3.contentid=tmptableid 		
		AND t3.docid=t2.docid		
		ORDER BY t2.docid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT t3.contentid,t2.userid,t2.author,t2.title,t2.createdatetime,t2.viewcount,
		(select b1.subtitle from cms_subcategory b1,mh_subcontent_relation b2
	where b1.subcategoryid=b2.subcategoryid
	and b2.contentid=t3.contentid) as subtitle,
		(select b1.subcategoryid from cms_subcategory b1,mh_subcontent_relation b2
	where b1.subcategoryid=b2.subcategoryid
	and b2.contentid=t3.contentid) as subcategoryid,t2.docid
		FROM blogapp..thelp_documents t2, mh_doc_content_relation t3
		WHERE t3.docid=t2.docid and t3.status=1		
		AND t3.categorycode=@categorycode
		ORDER BY t2.docid DESC
	END
END













GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portaldoccontent_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portaldoccontent_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
