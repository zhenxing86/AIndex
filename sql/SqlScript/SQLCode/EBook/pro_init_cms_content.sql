USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_cms_content]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_cms_content]
as

delete dbo.cms_content

insert into cms_content(contentid, categoryid, content, title, titlecolor, author, createdatetime, searchkey, searchdescription, 
                        browsertitle, viewcount, commentcount, orderno, commentstatus, ispageing, status, siteid)
select top 300 c.contentid, c.categoryid, c.content, c.title, c.titlecolor, c.author, c.createdatetime, c.searchkey, c.searchdescription, 
               c.browsertitle, c.viewcount, c.commentcount, c.orderno, c.commentstatus, c.ispageing, c.status, c.siteid 
  from dbo.gartenlist g inner join KWebCMS..cms_content c on c.siteid=g.kid
  where c.categoryid=17095 and c.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！' and c.deletetag = 1
  order by  createdatetime desc

GO
