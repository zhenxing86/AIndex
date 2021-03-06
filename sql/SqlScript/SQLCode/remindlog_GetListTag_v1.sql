USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_GetListTag_v1]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[remindlog_GetListTag_v1]
 @page int
,@size int
,@kid int
,@cuid int
 AS 

declare @pcount int,@ntime datetime

SELECT @pcount=count(1) FROM [remindlog] where deletetag=1

set @ntime=convert(varchar(10),getdate(),120)




SELECT 
	@pcount      ,g.ID    ,rid    ,attention    ,result    ,info    ,intime    ,g.uid    ,g.deletetag

 ,case when k.expiretime<convert(varchar(10),getdate(),120) then 1 else 0 end expt,expiretime
	 FROM [remindlog] g 
left join kinbaseinfo k on convert(varchar,k.kid)=Replace(attention,'/beforefollowremark/Index_Main?uc=10&kid=','')

where g.deletetag=1  and g.uid=@cuid 
and intime<=@ntime order by intime desc





GO
