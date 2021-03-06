USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[getfilteredrecord_kid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[getfilteredrecord_kid]
@BegDate Date, 
@EndDate Date,
@kid int
as
Set Nocount On

Select Case tablename When 'blog_posts' Then '博客文章' When 'class_notice' Then '班级通知' 
                      When 'class_article' Then '班级文章' When 'class_schedule' Then '教学教案'
                      When 'cms_content' Then '公告、新闻、精彩文章等内容'
       End tablename, title, content, adddate, Case When keyword <> '' Then Replace(keyword, '%', '') Else keyword End keyword
  From ossapp.dbo.filteredrecord
  Where adddate >= @BegDate and adddate <= @EndDate and kid = @kid and tablename <> 'product' and status = 0


GO
