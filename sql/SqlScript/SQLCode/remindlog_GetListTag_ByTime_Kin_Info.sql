USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_GetListTag_ByTime_Kin_Info]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------

------------------------------------
alter PROCEDURE [dbo].[remindlog_GetListTag_ByTime_Kin_Info]
@cuid int
,@mtime1 datetime
,@mtime2 datetime
,@xsid int=-1
 AS 


--邹鹏8或者吴伟4
if( @cuid=141 or @cuid=4 or @cuid=8 or @cuid=6)
begin

	select 1,
		case when isnull(w.kid,0)=0 
		then '/beforefollowremark/Index?uc=2&kfid='+convert(varchar,w.bf_Id)
		else '/beforefollowremark/Index_Main?uc=10&kid='+convert(varchar,w.kid)
		end
	 attention
	 ,isnull(remindtype,'日常') remindtype,convert(varchar(10),w.intime,120) intime
	,case when k.expiretime<convert(varchar(10),getdate(),120) or k.expiretime=null then 1 else 0 end expt
	,k.kname,b.kname,w.remark,u.name
	 from users u 
	inner join beforefollowremark w on w.uid=u.ID and w.deletetag=1
	left join beforefollow b on b.ID=w.bf_Id
	left join kinbaseinfo k on w.kid=k.kid and w.kid>0
	where u.deletetag=1 and (u.roleid=2 or u.ID =@cuid) and u.usertype=0 
	and w.intime between @mtime1 and @mtime2 and (u.ID=@xsid or @xsid=-1)
	


end
else
begin

SELECT 
	1,attention,remindtype,convert(varchar(10),g.intime,120) intime
 ,case when k.expiretime<convert(varchar(10),getdate(),120) or k.expiretime=null then 1 else 0 end expt
,k.kname,b.kname
,w.remark,'' name
	 FROM [remindlog] g 
left join kinbaseinfo k on convert(varchar,k.kid)=Replace(attention,'/beforefollowremark/Index_Main?uc=10&kid=','')
left join beforefollow b on convert(varchar,b.ID)=Replace(attention,'/beforefollowremark/Index?uc=2&kfid=','')
left join beforefollowremark w on w.ID=rid
where g.deletetag=1  and g.uid=@cuid 
and g.intime between @mtime1 and @mtime2
order by w.remindtype

end

GO

[remindlog_GetListTag_ByTime_Kin_Info] 141,'2014-12-1','2014-12-31'