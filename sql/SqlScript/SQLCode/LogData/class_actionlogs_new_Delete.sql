USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[class_actionlogs_new_Delete]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		wuzy
-- Create date: 2011-04-27
-- Description:	班级主页日志删除
-- =============================================
CREATE PROCEDURE [dbo].[class_actionlogs_new_Delete]
AS
DECLARE @classid int
declare rs3 insensitive cursor for
select id from kmp..t_class where status=1
open rs3
fetch next from rs3 into @classid
while @@fetch_status=0
begin
	IF((select count(1) from class_actionlogs_new where classid=@classid)>30)	
	BEGIN
		DECLARE @datetime datetime
		SELECT top(1)  @datetime=actiondatetime FROM (select top(30) actiondatetime from class_actionlogs_new where classid=@classid order by actiondatetime desc) as t ORDER BY t.actiondatetime
		DELETE class_actionlogs_new WHERE classid=@classid and actiondatetime <@datetime
	END
	fetch next from rs3 into @classid
end
close rs3
deallocate rs3

GO
