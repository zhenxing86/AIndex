USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_setmeal_GetList]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：统计增值服务套餐
--项目名称：家长增值服务结算报表
--说明: 增值服务套餐统计
--时间：2013-3-7 11:50:29
--exec rep_kin_setmeal_GetList 0,0,0,0,'',0,0,0,'2012-03-18 00:00:00','2013-03-18 23:59:59',0,0,0,0,0,0,0
------------------------------------ 
CREATE PROCEDURE [dbo].[rep_kin_setmeal_GetList]
@privince int
,@city int
,@area int
,@kid int
,@kname varchar(120)
,@sourceType int
,@agent int
,@developer int
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
 
  
set @kname=CommonFun.dbo.FilterSQLInjection(@kname)
 
declare @pcount int
,@excuteSql nvarchar(2000),@whereSql nvarchar(2000)
,@excuteSql2 nvarchar(2000),@whereSql2 nvarchar(2000)
,@fromSql nvarchar(1000)

set @whereSql=''
set @whereSql2=''
if @privince>0  --省
begin
	set @whereSql =@whereSql+' and privince ='+Str(@privince)
end
if @city >0  --省、市
begin
	set @whereSql =@whereSql+' and city ='+Str(@city) 
end
if @area>0  --省、市、县
begin
	set @whereSql =@whereSql+' and area ='+Str(@area) 
end

if @sourceType=1 --市场
begin
	set @whereSql =@whereSql+' and infofrom =''市场人员''' 
	if @developer>0
	begin
		set @whereSql =@whereSql+' and uid ='+Str(@developer)
	end 
end
else if @sourceType=2 --网络
begin
	set @whereSql =@whereSql+' and infofrom =''客服人员'''
	if @developer>0
	begin
		set @whereSql =@whereSql+' and uid ='+Str(@developer)
	end 
end
else if @sourceType=3 --代理
begin
	set @whereSql =@whereSql+' and infofrom =''代理'''
	if @agent>0
	begin
		set @whereSql =@whereSql+' and abid ='+Str(@agent)
	end
	if @developer>0
	begin
		set @whereSql =@whereSql+' and developer ='+Str(@developer)
	end
end

if @kid>0
begin
	set @whereSql =@whereSql+' and kid ='+Str(@kid)
end 
if len(isnull(@kname,''))>0
begin
	set @whereSql =@whereSql+' and kname like ''%'+@kname+'%'''
end

if @chearchType>0
begin
	if @a1>0
	begin
		set @whereSql2 =' and a2<>0'
	end
	else
	begin
		set @whereSql2 =' and a2=0'
	end
	if @a2>0
	begin
		set @whereSql2 =@whereSql2+' and a3<>0'
	end
	else
	begin
		set @whereSql2 =@whereSql2+' and a3=0'
	end
	if @a3>0
	begin
		set @whereSql2 =@whereSql2+' and a4<>0'
	end
	else
	begin
		set @whereSql2 =@whereSql2+' and a4=0'
	end
	if @a4>0
	begin
		set @whereSql2 =@whereSql2+' and a5<>0'
	end
	else
	begin
		set @whereSql2 =@whereSql2+' and a5=0'
	end
	if @a5>0
	begin
		set @whereSql2 =@whereSql2+' and a6<>0'
	end
	else
	begin
		set @whereSql2 =@whereSql2+' and a6=0'
	end
	if @a6>0
	
	begin
		set @whereSql2 =@whereSql2+' and a7<>0'
	end
	else
	begin
		set @whereSql2 =@whereSql2+' and a7=0'
	end
end
else
begin
	if @a1>0
	begin
		set @whereSql2 =' a2<>0 or '
	end
	if @a2>0
	begin
		set @whereSql2 =@whereSql2+' a3<>0 or'
	end
	if @a3>0
	begin
		set @whereSql2 =@whereSql2+' a4<>0 or'
	end
	if @a4>0
	begin
		set @whereSql2 =@whereSql2+' a5<>0 or'
	end
	if @a5>0
	begin
		set @whereSql2 =@whereSql2+' a6<>0 or'
	end
	if @a6>0
	begin
		set @whereSql2 =@whereSql2+' a7<>0 or'
	end
	
	if len(@whereSql2)>0
	begin
		set @whereSql2 = subString(@whereSql2,0,LEN(@whereSql2)-2)
		print @whereSql2
		set @whereSql2 = ' and (' +@whereSql2+')'
	end
	else set @whereSql2=' and 1<>1'
end
	
set @fromSql = 'insert into #temp(kid,kname,title,price,personCount)
	select  k.kid,kname
,(case when a2<>0 then ''+家园短信'' else '''' end)
+(case when a3<>0 then ''+成长档案'' else '''' end)
+(case when a4<>0 then ''+数字图书'' else '''' end)
+(case when a5<>0 then ''+乐奇家园'' else '''' end)
+(case when a6<>0 then ''+晨检'' else '''' end)
+(case when a7<>0 then ''+接送卡'' else '''' end)
,f.price
,(select COUNT(1) from ossapp..addservice a 
inner join BasicData..class c on a.cid=c.cid and grade<>38
where a.kid=k.kid and a.deletetag=1 and a.a1=f.a1 and a.describe=''开通''
 and a.ltime>='''+Convert(nvarchar(50),@txttime1)+''' and a.ftime<='''+ Convert(nvarchar(50),@txttime2)+''')
 from ossapp..kinbaseinfo k
left join  ossapp..feestandard f on k.kid=f.kid'

create table #temp
(
	kid int
	,kname nvarchar(100)
	,title nvarchar(100)
	,price int
	,personCount int
)

if len(isnull(@whereSql,''))=0 
begin
	
	set @excuteSql2=@fromSql +' where f.kid is not null and f.deletetag=1'+@whereSql2+' order by f.kid'
	print @excuteSql2
	exec sp_executesql @excuteSql2
end
else
begin
    
    create table #kintemp
	(
	kid int
	)
	
	set @excuteSql='insert into #kintemp(kid) select kid from ossapp..kinbaseinfo where 1=1 '+@whereSql
	exec sp_executesql @excuteSql
	
	set @excuteSql2=@fromSql +' inner join #kintemp uk on k.kid =uk.kid where f.kid is not null and f.deletetag=1'+@whereSql2+' order by f.kid'
	exec sp_executesql @excuteSql2
	
	drop table #kintemp
end

select kid,(case when kid is null then '其他(注：小朋友已离园)' else kname end) kname,title,price,personCount from #temp 

order by (case when kid>0 then -1 when kid is null then 0 else 1 end) asc,personCount desc

drop table #temp
end



GO
