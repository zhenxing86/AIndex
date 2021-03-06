USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[stu_mc_day_highTw_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 2013-09-19
-- Description:	
-- Paradef: 
-- Memo:
stu_mc_day_highTw_GetList 12511,1,10
go
stu_mc_day_highTw_GetList 12511,1,10,'2013-09-11 00:00:00','2013-09-19 23:59:59','智',-1

update stu_mc_day set cdate = '2013-09-19 08:59:59' where id in(560,532,548)

*/
CREATE procedure [dbo].[stu_mc_day_highTw_GetList]
	@kid int, 
	@page int, 
	@size int,
	@bgntime varchar(20),
	@endtime varchar(20),
	@uname varchar(20),
	@ftype int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @fromstring NVARCHAR(2000)
	SET @fromstring = 
		'stu_mc_day smd
			left join BasicData..User_Child uc
				on smd.stuid = uc.userid
			where smd.kid = @D1 
				and smd.tw >= 37.8
				and smd.CheckDate>= @T1 
				and smd.CheckDate<= @T2'
	
	IF @uname <> '' SET @fromstring = @fromstring + ' AND uc.name like @S1 + ''%'''   
	IF @ftype <> -1 SET @fromstring = @fromstring + ' AND smd.ftype = @D2'

	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,  --数据集		
		@selectstring = 
		' uc.userid,uc.name uname,smd.cdate,smd.tw,smd.zz,uc.mobile,smd.ftype,uc.cname,smd.id',      --查询字段
		@returnstring = 
		' userid, uname, cdate,tw,zz, mobile, ftype,cname,id',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' smd.cdate desc,uc.cname',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid,
		@D2 = @ftype,
		@S1 = @uname,
		@T1 = @bgntime,
		@T2 = @endtime
	
END

GO
