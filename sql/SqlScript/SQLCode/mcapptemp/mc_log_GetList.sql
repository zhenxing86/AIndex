USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_log_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 2013-09-11
-- Description:	
-- Memo:		
exec mc_log_GetList 1,300,12511,'','',-1,-3,'2013-09-02 00:00:00.410','2013-09-12 23:57:25.410'
*/
-- 
CREATE PROCEDURE [dbo].[mc_log_GetList]
@page int
,@size int
,@kid int
,@cardno nvarchar(50)
,@doname nvarchar(50)
,@dowhere int
,@dotype int
,@bgndate DateTime
,@enddate DateTime
 AS 
begin

	DECLARE @fromstring NVARCHAR(2000)
	SET @fromstring = 
	'AppLogs..mc_CardInfo_log mc 
	left join basicdata..[user] uu on uu.userid=mc.BeUserid
	left join basicdata..[user] u on mc.Douserid = u.userid and mc.DoWhere = 1
	left join ossapp..users u1 on mc.Douserid = u1.ID and mc.DoWhere = 0	
	where mc.kid=@D1 
	and crtdate between @T1 AND @T2 '
	 IF @cardno <> '' SET @fromstring = @fromstring + ' AND mc.[card] like @S1 + ''%''' 
	 IF @dotype<>-3 set @fromstring = @fromstring + ' AND mc.dotype = @D2'
	 IF @dowhere <> -1 SET @fromstring = @fromstring + ' AND mc.dowhere = @D3'
	 IF @doname <> '' SET @fromstring = @fromstring + ' AND (u.name=@S2 or u1.name=@S2)'
	 --IF @cardno <> '' SET @fromstring = @fromstring + ' AND @S2 in (s.card1,s.card2,s.card3,s.card4)' 						 
	--分页查询 卡号  操作指令 操作方式  操作对象 操作者 操作时间
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		' mc.[card],mc.dotype,mc.dowhere,uu.name, ISNULL(u.name, u1.name) as DoName, mc.CrtDate',      --查询字段
		@returnstring = 
		' [card],dotype,dowhere,name,DoName,CrtDate',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' mc.CrtDate desc ',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid,
		@D2 = @dotype,
		@D3 = @dowhere,
		@S1 = @cardno,
		@S2 = @doname,
		@T1 = @bgndate,
		@T2 = @enddate
end

GO
