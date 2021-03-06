USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_GetListTag_ByTime_dl]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[remindlog_GetListTag_ByTime_dl]
@cuid int
,@mtime1 datetime
,@mtime2 datetime
 AS 

create table #ulist
(puid int)


insert into #ulist(puid) values (@cuid)

insert into #ulist(puid)
select ID from users where seruid=@cuid

insert into #ulist(puid)
select cuid from users_belong where puid=@cuid  and deletetag=1
and cuid not in (select puid from #ulist)


SELECT count(1),'',result,convert(varchar(10),intime,120) intime,0
	 FROM [remindlog] g 
	 inner join #ulist on g.uid=puid 
where g.deletetag=1  
and intime between @mtime1 and @mtime2
group by result,convert(varchar(10),intime,120)


drop table #ulist



GO
