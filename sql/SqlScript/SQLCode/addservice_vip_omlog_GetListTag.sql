USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_omlog_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addservice_vip_omlog_GetListTag]
@kid int
,@IsCurrent int
,@stime varchar(100)
,@etime varchar(100)
 AS 
if(@IsCurrent=0)
begin

select v.[uid],c.cname,b.[name],ftime,ltime,0 
from LogData..ossapp_addservice_log v
inner join BasicData..[user] b on v.[uid] =b.userid
inner join BasicData..class c on c.cid=v.cid
where v.kid=@kid
and grade<>38
and (ftime=@stime or @stime='')
and (ltime=@etime or  @etime='')
and b.kid=@kid
order by c.cid asc, v.[uid]asc 

end
else
begin

select v.[uid],c.cname,r.[name],ftime,ltime,1 from addservice v
inner join BasicData..[user] r on r.userid=v.[uid] and r.deletetag=1
inner join BasicData..class c on c.cid=v.cid
where v.kid=@kid
and grade<>38
and (ftime=@stime or @stime='')
and (ltime=@etime or  @etime='')
and v.describe='开通'
and r.kid=@kid
order by c.cid asc, v.[uid]asc 


end


GO
