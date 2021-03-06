USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[remindlog_GetListTag]
 @page int
,@size int
,@kid int
,@cuid int
,@lv int
 AS 

declare @ntime datetime

set @ntime=convert(varchar(10),getdate(),120)

create table #temp
(
ID int,
rid int,
attention varchar(300),
result nvarchar(30),
info nvarchar(2000),
intime datetime,
userid int,
kid int,
)

insert into #temp(ID,rid,attention,result,info,intime,userid)
SELECT g.ID,rid,attention,result,info,intime,g.[uid]
FROM [remindlog] g 
where g.deletetag=1  and g.[uid]=@cuid 
and intime<=@ntime  and (((g.lv is null or g.lv=0) and @lv=0) or g.lv=@lv)



update #temp set kid=Replace(attention,'/beforefollowremark/Index_Main?uc=10&kid=','')
where ISNUMERIC(Replace(attention,'/beforefollowremark/Index_Main?uc=10&kid=',''))=1

select @size,t.ID,rid,attention,result,info,intime,userid,1,
case when k.expiretime<@ntime then 1 else 0 end expt,expiretime
from #temp t
left join kinbaseinfo k on t.kid=k.kid
order by intime desc

drop table #temp




GO
