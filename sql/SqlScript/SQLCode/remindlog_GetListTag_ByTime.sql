USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_GetListTag_ByTime]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------

------------------------------------
alter PROCEDURE [dbo].[remindlog_GetListTag_ByTime]
@cuid int
,@mtime1 datetime
,@mtime2 datetime
,@xsid int=-1
 AS 

--邹鹏8或者吴伟4
if( @cuid=141 or @cuid=4 or @cuid=8 or @cuid=6)
begin
	select count(1),'',isnull(remindtype,'日常'),convert(varchar(10),w.intime,120) intime,0
	 from users u 
	inner join beforefollowremark w on w.uid=u.ID and w.deletetag=1
	left join kinbaseinfo k on w.kid=k.kid and w.kid>0
	where u.deletetag=1 and (u.roleid=2 or u.ID =@cuid) and u.usertype=0 
	and w.intime between @mtime1 and @mtime2 and (u.ID=@xsid or @xsid=-1)
	group by isnull(remindtype,'日常'),convert(varchar(10),w.intime,120)


end
else
begin
	SELECT 
		count(1),'',result,convert(varchar(10),intime,120) intime,0
		 FROM [remindlog] g 
	where g.deletetag=1  and g.uid=@cuid 
	and intime between @mtime1 and @mtime2
	group by result,convert(varchar(10),intime,120)
end


GO

remindlog_GetListTag_ByTime 141,'2014-12-1','2014-12-31'