USE [KWebCMS_Temp]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_contentattachsContent_GetListByPage]    Script Date: 2014/11/24 23:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- 
-- =============================================
CREATE PROCEDURE [dbo].[kweb_cms_contentattachsContent_GetListByPage]
@categorycode varchar(20),
@page int,
@size int,
@siteid int
AS
BEGIN	

if(exists(select 1 from theme_kids where kid=@siteid))
begin
	SET @siteid=11061
	--exec KWebCMS_Temp..[kweb_photo_GetIndex] @categorycode,14499,@page,@size
end
else
begin
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

--select top 1 @categoryid=categoryid from cms_category where 
--(siteid=@siteid  or siteid=0) and categorycode=@categorycode
--select url from site_menu t1 left join cms_category t2 on t1.categoryid=t2.categoryid
-- where t2.categorycode='mzsp' and t1.siteid=2639
--
--select top 1 * from cms_contentattachs where siteid=2639

select @url=url from site_menu t1 left join cms_category t2 on t1.categoryid=t2.categoryid
 where t2.categorycode=@categorycode and t1.siteid=@siteid
 
if(@url='cms_attachslist.aspx')
begin
	IF(@page>1)
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT t1.contentattachsid FROM cms_contentattachs t1
			INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
		where t2.categorycode=@categorycode and (t1.siteid=@siteid)
		ORDER BY t1.createdatetime DESC

		SET ROWCOUNT @size
		select c.contentid,title,createdatetime,contentattachsid,filepath,[filename],attachurl,net 
			from cms_contentattachs c
			inner join @tmptable on c.contentattachsid=tmptableid WHERE row > @ignore 			
			ORDER BY c.createdatetime DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT  t1.contentid,t1.title,t1.createdatetime,contentattachsid,filepath,[filename],attachurl,net 
		 FROM cms_contentattachs t1
			left JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
		where t2.categorycode=@categorycode and (t1.siteid=@siteid)
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
		where t2.categorycode=@categorycode and (t1.siteid=@siteid)
		ORDER BY t1.createdatetime DESC

		SET ROWCOUNT @size
		select t1.contentid,t1.title,t1.createdatetime,0 as attachesid ,'' as filepath ,'' as [filename],
'' as attachurl ,0
from cms_content t1 
inner join @tmptable on t1.[contentid]=tmptableid WHERE row > @ignore 			
			ORDER BY t1.createdatetime DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size

select t1.contentid,t1.title,t1.createdatetime,0 as attachesid ,'' as filepath ,'' as [filename],
'' as attachurl ,0
from cms_content t1 left JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
where t2.categorycode=@categorycode and (t1.siteid=@siteid)
		ORDER BY t1.createdatetime DESC

	END	

END

end
end




GO
