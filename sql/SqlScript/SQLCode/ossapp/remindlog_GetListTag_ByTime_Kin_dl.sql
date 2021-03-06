USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_GetListTag_ByTime_Kin_dl]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[remindlog_GetListTag_ByTime_Kin_dl]
@cuid int
,@mtime1 datetime
,@mtime2 datetime
 AS 

create table #ulist
(puid int,uname varchar(100))


insert into #ulist(puid) values (@cuid)

insert into #ulist(puid)
select ID from users where seruid=@cuid

insert into #ulist(puid)
select cuid from users_belong where puid=@cuid  and deletetag=1
and cuid not in (select puid from #ulist)

update #ulist set uname=[name] from users where ID=puid

SELECT 
	1,attention,result,convert(varchar(10),g.intime,120) intime
 ,case when k.expiretime<convert(varchar(10),getdate(),120) or k.expiretime=null then 1 else 0 end expt
,k.kname,b.kname,uname
	 FROM [remindlog] g 
	  inner join #ulist on g.uid=puid 
left join kinbaseinfo k on convert(varchar,k.kid)=Replace(attention,'/beforefollowremark/Index_Main?uc=10&kid=','')
left join beforefollow b on convert(varchar,b.ID)=Replace(attention,'/beforefollowremark/Index?uc=2&kfid=','')
where g.deletetag=1  
and g.intime between @mtime1 and @mtime2

drop table #ulist



GO
