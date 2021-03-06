USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stu_mc_recordlist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	取某个园当天的学生晨检记录
-- Memo:		exec stu_mc_recordlist 12511, 10, 10
*/
CREATE PROC [dbo].[stu_mc_recordlist]
	@kid int,
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON
	
	CREATE TABLE #result
		(ID INT IDENTITY,stuid	int, card	varchar(10), name	nvarchar(100), cname nvarchar(40),
		 cdate	datetime, tw	varchar(50), ta	varchar(50), toe varchar(50),zz	varchar(50), adate	datetime, devid	varchar(50),gunid	varchar(50),)
	INSERT INTO #result(stuid, card, name, cname, cdate, tw,ta,toe, zz, adate, devid,gunid)
		select	sm.stuid, sm.card, u.name, c.cname, 
						sm.cdate, sm.tw,sm.ta,sm.toe, sm.zz, sm.adate, sm.devid,sm.gunid
			from mcapp..stu_mc_day_raw sm 
				inner join basicdata..[user] u
					on sm.stuid = u.userid
					and u.deletetag = 1
					and sm.kid = @kid and adate>=CONVERT(VARCHAR(10),GETDATE(),120) and sm.devid<>''
				inner join basicdata..user_class uc
					on sm.stuid = uc.userid
				inner join basicdata..class c
					on uc.cid = c.cid
					and c.grade <> 38
					and c.deletetag = 1
		
	exec dbo.sp_GridViewByPager    
		 @viewName = '#result',             --表名
     @fieldName = 'stuid, card, name, cname, cdate, tw,ta, toe, zz, adate, devid,gunid',      --查询字段
     @keyName = 'ID',       --索引字段
     @pageSize = @size,                 --每页记录数
     @pageNo = @page,                     --当前页
     @orderString = ' cdate desc ',          --排序条件
     @whereString = '1=1',  --WHERE条件
     @IsRecordTotal = 1,             --是否输出总记录条数
     @IsRowNo = 0	
			
END

GO
