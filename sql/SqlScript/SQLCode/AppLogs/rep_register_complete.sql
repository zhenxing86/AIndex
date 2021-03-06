USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_register_complete]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[rep_register_complete]
 @ftime datetime,
 @ltime datetime
 AS 
 
 
 select  k.kid,kname,name,l.* into #temp from dbo.appcenter_log  l
inner join BasicData..[user] u on u.userid=l.userid
inner join BasicData..kindergarten k on k.kid=u.kid
where appid in (46,47,48,49,56,57,58,59,60) and asctiondesc is not null
and k.kid not in(22188) and actiondatetime  between @ftime and @ltime
order by l.userid,actiondatetime asc
 
 declare @completecount int,@reguster int,@homeconfig int
 
 select @completecount=COUNT(1) from #temp where appid=46
and actiondatetime between @ftime and @ltime and asctiondesc= '网站任务-完成' 

select @reguster=COUNT(1) from BasicData..kindergarten where actiondate  between @ftime and @ltime 

 select @homeconfig=COUNT(1) from #temp where appid=49
and actiondatetime between @ftime and @ltime and asctiondesc= '配置家园联系册' 


select @reguster 总注册量,@completecount 任务完成量,@homeconfig 配置家园联系册

drop table #temp


GO
