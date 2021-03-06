USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetListPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- Author:      Master谭            
-- Create date: 2013-08-28            
-- Description: 分页读取文章数据            
-- Memo: kweb_content_GetListPage 'GG',12511,1,10            
*/            
CREATE PROCEDURE [dbo].[kweb_content_GetListPage]            
 @categorycode nvarchar(10),            
 @siteid int,            
 @page int,            
 @size int            
AS            
BEGIN             
  declare @orerStr varchar(500)=' isnull(c1.istop,0) DESC, c1.orderno DESC,c1.createdatetime DESC'          
 if(exists(select 1 from theme_kids where kid=@siteid) or exists(select 1 from tryend_kid where kid=@siteid))            
  exec KWebCMS_Temp..kweb_content_GetListPage @categorycode,11061,@page,@size            
 else if(not exists(select 1 from cms_content where siteid=@siteid))            
  exec KWebCMS_Temp..kweb_content_GetListPage @categorycode,11061,@page,1             
 CREATE TABLE #T(siteid INT)             
 if(@categorycode in('yebj','xw','gg') and @siteid=13336)           
 begin          
 set @orerStr=' c1.createdatetime DESC'           
 INSERT INTO #T            
     SELECT 13336            
  UNION SELECT 13364            
  UNION SELECT 13362           
  end           
 else if(@categorycode='gg' and (@siteid in(13364,13362)))            
 INSERT INTO #T            
     SELECT 13336            
  UNION SELECT @siteid            
 ELSE            
 INSERT INTO #T            
     SELECT @siteid            
          
 exec sp_MutiGridViewByPager            
  @fromstring = 'cms_content c1            
   INNER JOIN cms_category c2             
    ON c1.categoryid = c2.categoryid            
   INNER JOIN #T t             
    ON c1.siteid = t.siteid             
  WHERE c2.categorycode = @S1            
   AND c1.status = 1              
   AND isnull(c1.draftstatus,0) = 0 and c1.deletetag=1',      --数据集            
  @selectstring =             
  'c1.contentid, c1.categoryid, c1.content, c1.title,             
     c1.titlecolor, c1.author, c1.createdatetime,c1.appcontent',      --查询字段            
  @returnstring =             
  'contentid, categoryid, content, title,             
     titlecolor, author, createdatetime,isnull(appcontent,content) appcontent',      --返回字段            
  @pageSize = @Size,                 --每页记录数            
  @pageNo = @page,                     --当前页            
  @orderString = @orerStr,          --排序条件            
  @IsRecordTotal = 0,             --是否输出总记录条数            
  @IsRowNo = 0,           --是否输出行号            
  @S1 = @categorycode            
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListPage', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
