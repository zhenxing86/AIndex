USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[tea_a_recordlist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	取某个园当天的教师出勤记录
-- Memo:		exec tea_a_recordlist 12511, 1, 10
*/
CREATE PROC [dbo].[tea_a_recordlist]
	@kid int,
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON
	
	CREATE TABLE #result
		(ID INT IDENTITY,stuid	int, card	varchar(10), name	nvarchar(100), 
		 cdate	datetime, ctype	varchar(50), adate	datetime, devid	varchar(50))
		 
	INSERT INTO #result(stuid, card, name,  cdate, ctype, adate, devid)
		select	ta.teaid, ta.card, u.name, ta.cdate, ta.ctype, ta.adate, ta.devid
			from mcapp..tea_at_day ta 
				inner join basicdata..[user] u
					on ta.teaid = u.userid
					and u.deletetag = 1
					and ta.kid = @kid
		
	exec dbo.sp_GridViewByPager    
		 @viewName = '#result',             --表名
     @fieldName = 'stuid, card, name, cdate, ctype, adate, devid',      --查询字段
     @keyName = 'ID',       --索引字段
     @pageSize = @size,                 --每页记录数
     @pageNo = @page,                     --当前页
     @orderString = ' cdate desc ',          --排序条件
     @whereString = '1=1',  --WHERE条件
     @IsRecordTotal = 1,             --是否输出总记录条数
     @IsRowNo = 0	
			
END

GO
