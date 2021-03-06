USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetJYHD]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-09-01>
-- Description:	<Description,,家园互动活跃度>
-- =============================================
CREATE PROCEDURE [dbo].[GetJYHD] 
	@sd nvarchar(30),
	@end nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select k.id, k.name as 幼儿园,
(select count(id) from t_actionlogs where actionmodule='家园互动'
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 家园互动,
(select count(id) from t_actionlogs where actiontype ='班级公告' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 班级公告,
(select count(id) from t_actionlogs where actiontype ='班级相册' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 班级相册,
(select count(id) from t_actionlogs where actiontype ='每周食谱' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 每周食谱,
(select count(id) from t_actionlogs where actiontype ='精彩视频' 
	and actionmodule='家园互动'
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 精彩视频,
(select count(id) from t_actionlogs where actiontype ='家园互动-教学安排' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 教学安排,
(select count(id) from t_actionlogs where actiontype ='背景音乐' 
	and actionmodule='家园互动'
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 背景音乐
from t_kindergarten k 
where k.status = 1 order by 家园互动 desc
END




GO
