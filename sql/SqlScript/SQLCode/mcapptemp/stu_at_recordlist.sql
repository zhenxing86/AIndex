USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[stu_at_recordlist]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	取某个园当天的学生出勤记录
-- Memo:		exec stu_at_recordlist 12511, 1, 1000
*/
CREATE PROC [dbo].[stu_at_recordlist]
	@kid int,
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON
	
	CREATE TABLE #result
		(ID INT IDENTITY,stuid	INT, card	varchar(10), name	nvarchar(100), cname nvarchar(40),
		 cdate	datetime, ctype	varchar(50), adate	datetime, devid	varchar(50))
		 
	INSERT INTO #result(stuid, card, name, cname, cdate, ctype, adate, devid)
		select	sa.stuid, sa.card, u.name, c.cname, 
						sa.cdate, sa.ctype, sa.adate, sa.devid
			from mcapp..stu_at_day sa 
				inner join basicdata..[user] u
					on sa.stuid = u.userid
					and u.deletetag = 1
					and sa.kid = @kid and sa.devid<>''
				inner join basicdata..user_class uc
					on sa.stuid = uc.userid
				inner join basicdata..class c
					on uc.cid = c.cid
					and c.grade <> 38
					and c.deletetag = 1
		
	exec dbo.sp_GridViewByPager    
		 @viewName = '#result',             --表名
     @fieldName = 'stuid, card, name, cname, cdate, ctype, adate, devid',      --查询字段
     @keyName = 'ID',       --索引字段
     @pageSize = @size,                 --每页记录数
     @pageNo = @page,                     --当前页
     @orderString = ' cdate desc ',          --排序条件
     @whereString = '1=1',  --WHERE条件
     @IsRecordTotal = 1,             --是否输出总记录条数
     @IsRowNo = 0	
			
END

GO
