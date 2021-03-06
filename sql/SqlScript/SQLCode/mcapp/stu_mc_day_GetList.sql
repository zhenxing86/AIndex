USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stu_mc_day_GetList]    Script Date: 2014/11/24 23:15:11 ******/
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
stu_mc_day_GetList 12511,1,10,'2013-09-24 00:00:00','2013-09-27 23:59:59',
'2013-09-24 00:00:00','2013-09-27 23:59:59','','','',''

stu_mc_day_GetList -1,1,10,'2013-10-9 00:00:00','2013-10-16 23:59:59',
'2013-10-9 00:00:00','2013-10-16 23:59:59','','','',''

update stu_mc_day set cdate = '2013-09-19 08:59:59' where id in(560,532,548)

输出：班级，学生姓名，上传时间， 刷卡时间,体温、症状，发短信
select top 10000* from mcapp..stu_mc_day smd where kid = 12511 and cdate>='2013-09-24'
*/
CREATE procedure [dbo].[stu_mc_day_GetList]
	@kid int, 
	@page int, 
	@size int,
	@read_card_bgndate datetime,
	@read_card_enddate datetime,
	@upload_bgndate datetime,
	@upload_enddate datetime,
	@cname varchar(20),
	@uname varchar(20),
	@devid varchar(20),
	@gunid varchar(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @fromstring NVARCHAR(2000)
	SET @fromstring = 
		'stu_mc_day smd
			left join BasicData..User_Child uc
				on smd.stuid = uc.userid
			where (smd.devid != '''' and smd.devid is not null)
			and smd.cdate>=@T3 and smd.cdate<=@T4
			and smd.adate>=@T1 and smd.adate<=@T2'

	IF @kid >0 SET @fromstring = @fromstring + ' AND smd.kid =@D1' 
	IF @cname <> '' SET @fromstring = @fromstring + ' AND uc.[cname] like @S1 + ''%''' 
	IF @uname <> '' SET @fromstring = @fromstring + ' AND uc.[name] like @S2 + ''%'''   
	IF @devid <> '' SET @fromstring = @fromstring + ' AND smd.devid = @S3'
	IF @gunid <> '' SET @fromstring = @fromstring + ' AND smd.gunid = @S4'
	
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,  --数据集		
		@selectstring = 
		' uc.userid,uc.name uname,smd.cdate,smd.tw,smd.zz,uc.mobile,smd.ftype,uc.cname,smd.id,smd.adate,smd.devid,smd.gunid,smd.card',      --查询字段
		@returnstring = 
		' userid, uname, cdate,tw,zz, mobile, [ftype],cname,id,adate,devid,gunid,card',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' smd.cdate desc,uc.cname',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid,
		@S1 = @cname,
		@S2 = @uname,
		@S3 = @devid,
		@S4 = @gunid,
		@T1 = @upload_bgndate,
		@T2 = @upload_enddate,
		@T3 = @read_card_bgndate,
		@T4 = @read_card_enddate
	
END


GO
