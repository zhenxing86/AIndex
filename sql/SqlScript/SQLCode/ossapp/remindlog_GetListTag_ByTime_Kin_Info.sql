USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_GetListTag_ByTime_Kin_Info]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[remindlog_GetListTag_ByTime_Kin_Info]
@cuid int
,@mtime1 datetime
,@mtime2 datetime
 AS 

SELECT 
	1,attention,remindtype,convert(varchar(10),g.intime,120) intime
 ,case when k.expiretime<convert(varchar(10),getdate(),120) or k.expiretime=null then 1 else 0 end expt
,k.kname,b.kname
,w.remark
	 FROM [remindlog] g 
left join kinbaseinfo k on convert(varchar,k.kid)=Replace(attention,'/beforefollowremark/Index_Main?uc=10&kid=','')
left join beforefollow b on convert(varchar,b.ID)=Replace(attention,'/beforefollowremark/Index?uc=2&kfid=','')
left join beforefollowremark w on w.ID=rid
where g.deletetag=1  and g.uid=@cuid 
and g.intime between @mtime1 and @mtime2
order by w.remindtype



GO
