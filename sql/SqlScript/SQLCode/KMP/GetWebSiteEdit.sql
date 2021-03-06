USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetWebSiteEdit]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-09-01>
-- Description:	<Description,,网站编辑活跃度>
-- =============================================
CREATE PROCEDURE [dbo].[GetWebSiteEdit] 
	@sd nvarchar(30),
	@end nvarchar(30),
	@rsd nvarchar(30),
	@rend nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
/*CREATE TABLE #actionlogtemp(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ActionType] [varchar](128) COLLATE Chinese_PRC_CI_AS NULL,
	[Actioner] [varchar](100) COLLATE Chinese_PRC_CI_AS NULL,
	[ActionDesc] [text] COLLATE Chinese_PRC_CI_AS NULL,
	[ActionModule] [varchar](100) COLLATE Chinese_PRC_CI_AS NULL,
	[ActionObjectID] [varchar](100) COLLATE Chinese_PRC_CI_AS NULL,
	[ActionDateTime] [datetime] NULL,
	[ActionerIP] [varchar](200) COLLATE Chinese_PRC_CI_AS NULL,
) */
select * into #actionlogtemp from t_actionlogs where actionmodule='网站编辑' and actiondatetime between @sd and @end
--select * from t_actionlogs where actionmodule='网站编辑'
--delete t_actionlogs where actiondatetime<'2007-11-01' and actionmodule='网站编辑'

--select * from t_actionlogs where actionmodule= '登录'
select k.id, k.name as 幼儿园,
(select count(id) from #actionlogtemp where actionmodule='网站编辑'
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 网站编辑,
(select count(id) from #actionlogtemp where actiontype ='公告' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 公告,
(select count(id) from #actionlogtemp where actiontype ='新闻' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 新闻,
(select count(id) from #actionlogtemp where actiontype ='温馨提示' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 温馨提示,
(select count(id) from #actionlogtemp where actiontype ='友情链接' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 友情链接,
(select count(id) from #actionlogtemp where actiontype ='园景园貌' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 园景园貌,
(select count(id) from #actionlogtemp where actiontype ='园所简介' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 园所简介,
(select count(id) from #actionlogtemp where actiontype ='园丁风采' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 园丁风采,
(select count(id) from #actionlogtemp where actiontype ='特色展现' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 特色展现,
(select count(id) from #actionlogtemp where actiontype ='招生专栏' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 招生专栏,
(select count(id) from #actionlogtemp where actiontype ='欢乐时光' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 欢乐时光,
(select count(id) from #actionlogtemp where actiontype ='精彩视频' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 精彩视频,
(select count(id) from #actionlogtemp where actiontype ='幼儿作品' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 幼儿作品,
(select count(id) from #actionlogtemp where actiontype ='每周食谱' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 每周食谱,
(select count(id) from #actionlogtemp where actiontype ='背景音乐' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 背景音乐,
(select count(id) from #actionlogtemp where actiontype ='网站信息' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 网站信息
from t_kindergarten k 
where k.status = 1 and k.actiondate between @rsd and @rend order by 网站编辑 desc

drop table #actionlogtemp
END



--exec GetWebSiteEdit '2007-07-01', '2008-02-24', '2007-07-01', '2008-02-24'

GO
