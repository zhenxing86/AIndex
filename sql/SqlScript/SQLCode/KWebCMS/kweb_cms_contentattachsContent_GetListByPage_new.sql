USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_contentattachsContent_GetListByPage_new]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- alter date: 2009-02-03
-- Description:	分页获取附件内容
--[kweb_cms_contentattachsContent_GetListByPage] 'mzsp',1,10,403
-- =============================================
CREATE PROCEDURE [dbo].[kweb_cms_contentattachsContent_GetListByPage_new]
@categorycode varchar(20),
@page int,
@size int,
@siteid int
AS
BEGIN	

	DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
  declare @categoryid int
declare @url nvarchar(20)

select @categoryid=categoryid from cms_category where 
(siteid=@siteid  or siteid=0) and categorycode=@categorycode

select @url=url from site_menu where categoryid=@categoryid 
 
if(@url='cms_attachslist.aspx')
begin
	IF(@page>1)
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT t1.[contentid] FROM cms_contentattachs t1
			INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
		where t2.categorycode=@categorycode and (t1.siteid=@siteid) and t1.deletetag = 1
		ORDER BY t1.createdatetime DESC

		SET ROWCOUNT @size
		select c.contentid,title,createdatetime,contentattachsid,filepath,[filename],attachurl,net 
			from cms_contentattachs c
			join @tmptable on c.[contentid]=tmptableid WHERE row > @ignore and c.deletetag = 1		
			ORDER BY c.createdatetime DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT  t1.contentid,t1.title,t1.createdatetime,contentattachsid,filepath,[filename],attachurl,net 
		 FROM cms_contentattachs t1
			left JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
		where t2.categorycode=@categorycode and (t1.siteid=@siteid) and t1.deletetag = 1
		ORDER BY t1.createdatetime DESC
	END	
END
else
begin
IF(@page>1)
	BEGIN
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT t1.[contentid] FROM cms_content t1
			INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
		where t2.categorycode=@categorycode and (t1.siteid=@siteid) and t1.deletetag = 1
		ORDER BY t1.createdatetime DESC

		SET ROWCOUNT @size
		select t1.contentid,t1.title,t1.createdatetime,0 as attachesid ,'' as filepath ,'' as [filename],
'' as attachurl ,0
from cms_content t1 
join @tmptable on t1.[contentid]=tmptableid WHERE row > @ignore and t1.deletetag = 1		
			ORDER BY t1.createdatetime DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size

select t1.contentid,t1.title,t1.createdatetime,0 as attachesid ,'' as filepath ,'' as [filename],
'' as attachurl ,0
from cms_content t1 left JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
where t2.categorycode=@categorycode and (t1.siteid=@siteid) and t1.deletetag = 1
		ORDER BY t1.createdatetime DESC

	END	

END

end

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_contentattachsContent_GetListByPage_new', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_contentattachsContent_GetListByPage_new', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_contentattachsContent_GetListByPage_new', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
