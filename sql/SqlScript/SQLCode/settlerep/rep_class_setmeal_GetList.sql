USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_setmeal_GetList]    Script Date: 08/10/2013 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：统计单个幼儿园增值服务套餐
--项目名称：家长增值服务结算报表
--说明: 单个幼儿园增值服务套餐统计
--时间：2013-3-7 11:50:29
--exec rep_class_setmeal_GetList 8911,'2012-03-18 00:00:00','2013-03-18 23:59:59',1,1,0,0,0,0,0
------------------------------------ 
CREATE PROCEDURE [dbo].[rep_class_setmeal_GetList]
@kid int
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

if @kid>0
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
	
	set @whereSql = 'and grade<>38 and c.kid='+str(@kid) +@whereSql
	
	set @fromSql = 'insert into #temp(cid,cname,title,price,personCount)
	select  c.cid,cname
	,(case when a2<>0 then ''+家园短信'' else '''' end)
	+(case when a3<>0 then ''+成长档案'' else '''' end)
	+(case when a4<>0 then ''+数字图书'' else '''' end)
	+(case when a5<>0 then ''+乐奇家园'' else '''' end)
	,f.price
	,(select COUNT(1) from ossapp..addservice a where a.cid=c.cid and deletetag=1 and a.a1=f.a1 and a.describe=''开通''
	 and a.ltime>='''+Convert(nvarchar(50),@txttime1)+''' and a.ftime<='''+ Convert(nvarchar(50),@txttime2)+''')
	 from BasicData..class c
	 left join  ossapp..feestandard f on c.kid=f.kid'

	create table #temp
	(
		cid int
		,cname nvarchar(100)
		,title nvarchar(100)
		,price int
		,personCount int
	)


	set @excuteSql=@fromSql +' where f.kid is not null and f.deletetag=1 '+@whereSql+' order by c.cid'
	print @excuteSql
	exec sp_executesql @excuteSql

	select cid,(case when cid is null then '其他(注：小朋友已离园)' else cname end) cname,title,price,personCount from #temp 
	order by (case when cid>0 then -1 when cid is null then 0 else 1 end) asc,personCount desc

	drop table #temp
end
end
GO
