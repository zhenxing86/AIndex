USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_hotposts_top_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取热门推荐 
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-4-27 16:37:29
------------------------------------
CREATE PROCEDURE [dbo].[blog_hotposts_top_GetList]
@hottype int
 AS 
--		SELECT top 6
--		t1.hotpostid,t1.maintitle,t1.subtitle,t1.mainurl,t1.suburl,t1.orderno,t1.posttype,t1.createdate,'' as content
--		 FROM blog_hotposts t1  WHERE hottype=@hottype or hottype=3
--		ORDER BY t1.istop desc, t1.createdate desc


CREATE TABLE #hotpost_top_temp
(
id int identity(1,1),
hotpostid int,
maintitle nvarchar(100),
subtitle nvarchar(100),
mainurl nvarchar(200),
suburl nvarchar(200),
orderno int,
posttype int,
createdate datetime,
istop int
)
insert into #hotpost_top_temp(hotpostid,maintitle,subtitle,mainurl,suburl,orderno,posttype,createdate,istop)
SELECT top 6
t1.hotpostid,t1.maintitle,t1.subtitle,t1.mainurl,t1.suburl,t1.orderno,t1.posttype,t1.createdate,t1.istop
 FROM blog_hotposts t1  WHERE hottype=@hottype
ORDER BY t1.istop desc, t1.createdate desc

insert into #hotpost_top_temp(hotpostid,maintitle,subtitle,mainurl,suburl,orderno,posttype,createdate,istop)
SELECT top 6
t1.hotpostid,t1.maintitle,t1.subtitle,t1.mainurl,t1.suburl,t1.orderno,t1.posttype,t1.createdate,t1.istop
 FROM blog_hotposts t1  WHERE hottype=3
ORDER BY t1.istop desc, t1.createdate desc


select top(6) hotpostid,maintitle,subtitle,mainurl,suburl,orderno,posttype,createdate,'' as content
from #hotpost_top_temp ORDER BY istop desc, createdate desc

drop table #hotpost_top_temp




GO
