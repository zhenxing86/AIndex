USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_Class_Info_Report_List]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-08
-- Description:	获取教案
-- Memo: exec [rep_Class_Info_Report_List] 12511,-1,2,20,'',''
*/
CREATE PROCEDURE [dbo].[rep_Class_Info_Report_List]
	@kid int,
	@cid int,
	@page int,
	@size int,
	@na varchar(30),
	@mobile varchar(30)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @fromstring NVARCHAR(400)
	if (@cid<=0) 
	SET @fromstring = 
			'basicdata..[user] u
				where u.usertype = 0  
				and u.deletetag = 1  
				and u.kid = @D1'
	ELSE
	SET @fromstring = 
		'basicdata..[user] u
			inner join basicdata..user_class c on u.userid = c.userid 
			where u.usertype = 0  
			and u.deletetag = 1  
			and c.cid = @D2' 
	IF isnull(@na,'')<>''
	SET @fromstring = @fromstring + ' and u.name like ''%'+@na+'%'' '
	IF isnull(@mobile,'')<>''
	SET @fromstring = @fromstring + ' and u.mobile like ''%'+@mobile+'%'' '
	
	exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集
			@selectstring = 
			'u.name,case when u.gender = 2 then ''女'' else ''男'' end sex, u.mobile,CommonFun.dbo.fn_age(u.birthday) age,
			u.userid,u.privince,u.city ',      --查询字段
			@returnstring = 
			'name, sex, mobile, age, userid, privince, city ',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' u.name',          --排序条件
			@IsRecordTotal = 1,             --是否输出总记录条数
			@IsRowNo = 0,					--是否输出行号
			@D1 = @kid,										
			@D2 = @cid

END

GO
