USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_statistics_stu_detail]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      xie
-- Create date: 2013-09-26
-- Description:	
-- Paradef: @bgndate,@enddate 短信发送时间范围，@uname 小朋友姓名，@cname 小朋友所在班级，
-- @smstype int （）
-- Memo:
stu_mc_day_highTw_GetList 12511,1,10
go
mc_sms_statistics_stu_detail 12511,1,10,'2013-09-11 00:00:00','2013-09-25 23:59:59','',-1,-1,8

update stu_mc_day set cdate = '2013-09-19 08:59:59' where id in(560,532,548)

select top 1 * from BasicData..[user_child] uc 

select * from mcapp..smstype_name
*/
CREATE procedure [dbo].[mc_sms_statistics_stu_detail]
	@kid int, 
	@page int, 
	@size int,
	@bgndate datetime,
	@enddate datetime,
	@uname varchar(20),
	@mobile varchar(20),
	@gradeid int,
	@cid int,
	@smstype int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @fromstring NVARCHAR(2000)
	SET @fromstring = 
		'sms_mc sm
		  inner join BasicData..[user_child] uc 
		  on sm.recuserid = uc.userid
			where sm.kid = @D1
			and sm.smstype = @D2
			and sm.sendtime>=@T1 and sm.sendtime<=@T2'
	
	IF @uname <> '' SET @fromstring = @fromstring + ' AND uc.[name] like @S1 + ''%'''   
	IF @mobile <> '' SET @fromstring = @fromstring + ' AND sm.recmobile like @S2 + ''%'''   
	IF @gradeid >0 SET @fromstring = @fromstring + ' AND uc.grade = @D3' 
	IF @cid >0 SET @fromstring = @fromstring + ' AND uc.[cid] = @D4' 
	
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,  --数据集		
		@selectstring = 
		' sm.content, uc.name, sm.recmobile, sm.sendtime,uc.cname,uc.cid,uc.grade',      --查询字段
		@returnstring = 
		' content, name, recmobile, sendtime,cname,cid,grade',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' sm.sendtime desc,uc.cname',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid,
		@D2 = @smstype,
		@D3 = @gradeid,
		@D4 = @cid,
		@S1 = @uname,
		@S2 = @mobile,
		@T1 = @bgndate,
		@T2 = @enddate
	
END




GO
