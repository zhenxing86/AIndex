USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[urgesfee_GetListTag_newkin2lv4]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[urgesfee_GetListTag_newkin2lv4]
@cuid int
,@bid int
 AS 

declare @ftime datetime,@ltime datetime,@ntime datetime
set @ntime=dateadd(hh,23,convert(varchar(10),getdate(),120))
set @ftime=dateadd(dd,-8,@ntime)
set @ltime=dateadd(dd,15,@ntime)




--老客户欠费的
--代理商客服部：可以看到所有代理商的客户
SET ROWCOUNT 100


SELECT 	0 ,ID    ,kid    ,[expiretime]    ,0    ,[kname],''    ,deletetag,infofrom  ,@bid	 
FROM [kinbaseinfo] k where deletetag=1 and status='正常缴费'
and [expiretime] between @ftime and @ltime
and abid=@bid and infofrom='代理'
order by [expiretime] desc


GO
