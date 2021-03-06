USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_setmeal_detail]    Script Date: 08/10/2013 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：统计单个幼儿园增值服务套餐
--项目名称：家长增值服务结算报表
--说明: 单个幼儿园增值服务套餐统计
--时间：2013-3-7 11:50:29
--exec rep_class_setmeal_detail 13158,'2013-01-18 00:00:00','2013-03-18 23:59:59',1,1,0,0,0,0,1
------------------------------------ 
alter PROCEDURE [dbo].[rep_class_setmeal_detail]
@classid int
,@txttime1 datetime
,@txttime2 datetime
,@a1 int
,@a2 int 
,@a3 int
,@a4 int
,@a5 int
,@a6 int
,@chearchType int
 AS
 begin
declare @pcount int
,@excuteSql nvarchar(2000),@whereSql nvarchar(2000)
,@fromSql nvarchar(1000)

set @whereSql=''

if @classid>0
begin
	if @chearchType>0 --精确查找
	begin
		if @a1>0
		begin
			set @whereSql =' and a2<>0'
		end
		else
		begin
			set @whereSql =' and a2=0'
		end
		if @a2>0
		begin
			set @whereSql =@whereSql+' and a3<>0'
		end
		else
		begin
			set @whereSql =@whereSql+' and a3=0'
		end
		if @a3>0
		begin
			set @whereSql =@whereSql+' and a4<>0'
		end
		else
		begin
			set @whereSql =@whereSql+' and a4=0'
		end
		if @a4>0
		begin
			set @whereSql =@whereSql+' and a5<>0'
		end
		else 
		begin
			set @whereSql =@whereSql+' and a5=0'
		end
		if @a5>0
		begin
			set @whereSql =@whereSql+' and a6<>0'
		end
		else
		begin
			set @whereSql =@whereSql+' and a6=0'
		end
		if @a6>0
		begin
			set @whereSql =@whereSql+' and a7<>0'
		end
		else
		begin
			set @whereSql =@whereSql+' and a7=0'
		end
	end
	else--模糊查找
	begin
		if @a1>0
		begin
			set @whereSql =' a2<>0 or '
		end
		if @a2>0
		begin
			set @whereSql =@whereSql+' a3<>0 or'
		end
		if @a3>0
		begin
			set @whereSql =@whereSql+' a4<>0 or'
		end
		if @a4>0
		begin
			set @whereSql =@whereSql+' a5<>0 or'
		end
		if @a5>0
		begin
			set @whereSql =@whereSql+' a6<>0 or'
		end
		if @a6>0
		begin
			set @whereSql =@whereSql+' a7<>0 or'
		end
		
		if len(@whereSql)>0
		begin
			set @whereSql = 'and (' +subString(@whereSql,0,LEN(@whereSql)-2)+')'
		end
		else set @whereSql=' and 1<>1'
	end

	set @fromSql = 'insert into #temp(cid,userid,username,ftime,ltime)
	select  a.cid,a.[uid],u.name,a.ftime,a.ltime
	 from ossapp..addservice a 
	left join BasicData..[user] u on a.[uid]=u.userid
	inner join BasicData..class c on a.cid=c.cid and grade<>38'

	create table #temp
	(
		cid int
		,userid int
		,username nvarchar(100)
		,ftime datetime
		,ltime datetime
	)

	set @excuteSql=@fromSql +' where a.describe=''开通'' and a.deletetag=1'+' and c.cid='+str(@classid) 
	+' and a.ltime>='''+Convert(nvarchar(50),@txttime1)+''' and a.ftime<='''+ Convert(nvarchar(50),@txttime2)+''''
	+@whereSql +' order by a.[uid]'
	print @excuteSql
	exec sp_executesql @excuteSql

	select cid,userid,username,ftime,ltime from #temp 
	order by (case when cid>0 then -1 when cid is null then 0 else 1 end) asc
	
	drop table #temp
end
end
GO
