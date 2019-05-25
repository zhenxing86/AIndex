USE SMS
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	返回充值历史
-- Memo:		exec smsapp_smsbase_GetListTag '2012-01-01','2013-12-12',12511,1,10
*/
ALTER PROC smsapp_smsbase_GetListTag
	@bgntime datetime,
	@endtime datetime,
	@kid int,
	@page int, 
	@size int
AS
BEGIN
	SET NOCOUNT ON
			 
	SELECT s.ID, s.kid, s.ncount smscount, s.remark, s.intime, ISNULL(u.name,'平台充值') uname
		into #result 
		FROM ossapp.dbo.smsbase s
			left join BasicData.dbo.[user] u
				on s.uid = u.userid
				and s.remark = '自助充值'
		where s.kid = @kid
			and intime >= CONVERT(varchar(10),@bgntime,120)
			and intime < CONVERT(varchar(10),DATEADD(dd,1,@endtime),120)
		
	exec dbo.sp_GridViewByPager    
		 @viewName = '#result',             --表名
     @fieldName = 'kid, smscount, remark, intime, uname',      --查询字段
     @keyName = 'ID',       --索引字段
     @pageSize = @size,                 --每页记录数
     @pageNo = @page,                     --当前页
     @orderString = ' intime desc ',          --排序条件
     @whereString = '1=1',  --WHERE条件
     @IsRecordTotal = 1,             --是否输出总记录条数
     @IsRowNo = 0	
			
END

GO