USE [AndroidApp]
GO
/****** Object:  StoredProcedure [and_yuanzhang_GetLoginLogDetail]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [and_yuanzhang_GetLoginLogDetail] 
@userid int,
@bgntime datetime,
@endtime datetime,
@kid int,
@page int,
@size int
AS

declare @kin table(kid int)

insert into @kin(kid)		
exec ossapp..[kinbaseinfo_GetKidByUserid] @userid


select u.userid,u.name,u.mobile,convert(varchar(10),l.intime,120) intime
	,COUNT(convert(varchar(10),l.intime,120)) daycount
	INTO #T 
	 from dbo.and_log l
	inner join BasicData..kindergarten k 
		on l.tag=k.kid and k.kid=@kid
	inner join @kin x 
		on x.kid=k.kid and x.kid=@kid
	inner join BasicData..[user] u 
		on u.userid=l.userid
			where l.ltype>1 and sms_id=0
				and l.intime between @bgntime and @endtime
				and k.kid=@kid 
		group by u.name,u.mobile,convert(varchar(10),l.intime,120),u.userid
		
  exec sp_GridViewByPager    
    @viewName = '#T',             --表名    
    @fieldName = 'name,mobile,intime,daycount',      --查询字段    
    @keyName = 'userid',       --索引字段    
    @pageSize = @size,                 --每页记录数    
    @pageNo = @page,                     --当前页    
    @orderString = ' intime desc ',          --排序条件    
    @whereString = ' 1 = 1  ' ,  --WHERE条件    
    @IsRecordTotal = 1,             --是否输出总记录条数    
    @IsRowNo = 0
          
 drop table #T

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'园长登录明细' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_yuanzhang_GetLoginLogDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_yuanzhang_GetLoginLogDetail', @level2type=N'PARAMETER',@level2name=N'@bgntime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_yuanzhang_GetLoginLogDetail', @level2type=N'PARAMETER',@level2name=N'@endtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_yuanzhang_GetLoginLogDetail', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_yuanzhang_GetLoginLogDetail', @level2type=N'PARAMETER',@level2name=N'@size'
GO
