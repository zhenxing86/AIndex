USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_attachs_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		liaoxin
-- alter date: 2010-9-28
-- Description:	根据 CategoryID 获附件数量
--[kweb_attachs_GetCount] 'jcsp',5661
-- =============================================
CREATE PROCEDURE [dbo].[kweb_attachs_GetCount]
@categorycode nvarchar(10),
@siteid int
AS
BEGIN 

DECLARE @count int
declare @categoryid int
declare @url nvarchar(20)

select @url=url from site_menu t1 inner join cms_category t2 on t1.categoryid=t2.categoryid 
where t2.siteid=@siteid and t2.categorycode=@categorycode
 
if(@url='cms_attachslist.aspx')
begin	
		SELECT @count=count(1)
		 FROM cms_contentattachs t1
			inner JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
		where t2.categorycode=@categorycode and (t1.siteid=@siteid)	and t1.deletetag = 1
END
else if(@categorycode='jcsp')
begin
		SELECT @count=count(1)
		 FROM cms_contentattachs t1
			inner JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
		where t2.categorycode=@categorycode and (t1.siteid=@siteid)	and t1.deletetag = 1			
end
else
begin	
		select @count=count(1)
		from cms_content t1 inner JOIN cms_category t2 ON  t1.categoryid=t2.categoryid
		where t2.categorycode=@categorycode and (t1.siteid=@siteid)	and t1.deletetag = 1
END
print @count
RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_attachs_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_attachs_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
