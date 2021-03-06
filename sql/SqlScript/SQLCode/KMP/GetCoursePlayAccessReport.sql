USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetCoursePlayAccessReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2008-04-13>
-- Description:	<Description,,学堂访问>
-- =============================================
CREATE PROCEDURE [dbo].[GetCoursePlayAccessReport] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select '' as id, '总数' as 幼儿园, '' as url,
(select count(id) from t_actionlogs where actiontype='课件播放' and actiondatetime between @sd and @ed)
as 播放次数

union
 
select t1.id as id, t1.name as 幼儿园,t1.url as url, 
(select count(id) from t_actionlogs where actiontype='课件播放' and actionobjectid=t1.id and actiondatetime between @sd and @ed)
as 播放次数 
from t_kindergarten t1 where t1.status=1 and id in
(select actionobjectid from t_actionlogs where actiontype='课件播放' and actiondatetime between @sd and @ed)
order by 播放次数 desc

END



GO
