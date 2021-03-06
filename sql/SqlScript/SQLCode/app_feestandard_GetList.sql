USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[app_feestandard_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[app_feestandard_GetList]
@kid int,
@userid int
 AS 
 
 
 
 
select f.ID,info,f.remark,isnull(a.describe,'未开通') [status],a.ltime,f.proxyprice,f.isproxy
into #temp
 from  feestandard  f
  left join dict d on d.ID=a1
  left join addservice a 
	on a.kid=f.kid 
		and a.[uid]=@userid
		and a.a1=f.a1
		and a.describe='开通'
 where f.kid=@kid and f.deletetag=1 and f.isproxy=1
 order by d.ID

if(exists(select 1 from #temp where [status]='开通'))
	select ID,info,remark,[status],ltime,ROUND(proxyprice,2) price from #temp
else
begin
	declare @ltime varchar(100),@gtype int,@termstr varchar(100)
	set @termstr=healthapp.dbo.getTerm_New(@kid,getdate()) 
	set @termstr=right(@termstr,1)
	if(@termstr='1')
		set @ltime=CONVERT(varchar(4),getdate(),120)+'-03-01'
	else
		set @ltime=CONVERT(varchar(4),getdate(),120)+'-09-01'

	select ID,info,remark,[status],convert(datetime,@ltime) ltime,ROUND(proxyprice,2) price from #temp 
end

drop table #temp

GO
