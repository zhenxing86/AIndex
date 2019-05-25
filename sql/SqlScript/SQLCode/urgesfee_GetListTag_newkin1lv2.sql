USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[urgesfee_GetListTag_newkin1lv2]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[urgesfee_GetListTag_newkin1lv2]
@cuid int
,@bid int
 AS 

declare @ftime datetime,@ltime datetime,@ntime datetime
set @ntime=dateadd(hh,23,convert(varchar(10),getdate(),120))
set @ftime=dateadd(dd,-8,@ntime)
set @ltime=dateadd(dd,3,@ntime)




--新客户欠费的
--总部非客服部（市场部）：可以看到自己开发的客户
SET ROWCOUNT 100

SELECT 	0 ,ID    ,kid    ,[expiretime]    ,0    ,[kname],''    ,deletetag,infofrom  ,@bid	 
FROM [kinbaseinfo] k where deletetag=1 
and [expiretime] between @ftime and @ltime
and status='试用期'
and developer = @cuid 
order by [expiretime] desc


GO
