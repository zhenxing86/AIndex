USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_cms_content]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_cms_content]
as

delete dbo.cms_content

insert into cms_content
select top 300 c.* from dbo.gartenlist g 
inner join KWebCMS..cms_content c on c.siteid=g.kid
where

c.categoryid=17095 and c.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！'
order by  createdatetime desc
GO
