USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_contentattachsContent_GetListByPageV5]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- alter date: 2009-02-03
-- Description:	分页获取附件内容
-- =============================================
CREATE PROCEDURE [dbo].[kweb_cms_contentattachsContent_GetListByPageV5]
@categorycode varchar(20),
@page int,
@size int,
@siteid int
AS
BEGIN	

	DECLARE @prep int,@ignore int
		SET @prep = @size * @page
		SET @ignore=@prep - @size
   DECLARE @temtable table
   (
   contentid int,
   title varchar(500),
   createdatetime datetime,
   attachesid int,
   filepath varchar(500),
   [filename] varchar(300),
   attachurl varchar(100)
  )
  declare @categoryid int
  select @categoryid=categoryid from cms_category where (siteid=@siteid  or siteid=0) and categorycode=@categorycode
 
  insert into @temtable  
    select contentid,title,createdatetime,0 as attachesid ,'' as filepath ,'' as [filename],'' as attachurl 
      from cms_content where siteid=@siteid  and categoryid=@categoryid and deletetag = 1
    union all  
    select contentid,title,createdatetime,contentattachsid,filepath,[filename],attachurl 
      from cms_contentattachs  
      where siteid=@siteid and categoryid=@categoryid and deletetag = 1
        and contentid not in(select contentid from  cms_content where categoryid=@categoryid and siteid=@siteid)  
  
  select contentid,title,createdatetime,attachesid,filepath,[filename],attachurl 
    from(select contentid,title,createdatetime,attachesid, filepath,[filename],attachurl, row_number() over (order by createdatetime desc) as num from @temtable )TB  
    where num between @ignore and @prep 
    order by createdatetime desc

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_contentattachsContent_GetListByPageV5', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_contentattachsContent_GetListByPageV5', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_contentattachsContent_GetListByPageV5', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
