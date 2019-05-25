USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetListByUidcc]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MsgTeacher_GetListByUidcc]
@useridstr varchar(max)
,@page int
,@size int
as 


set @useridstr='0'+@useridstr

declare @pcount int
set @pcount=0
exec('select '+@pcount+','''','''',n.kid,n.[kname],r.userid,r.[name],r.mobile,t.title job 
from BasicData..kindergarten n
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
left join BasicData..teacher t on t.userid=r.userid
where r.userid in ('+@useridstr +')')

GO
