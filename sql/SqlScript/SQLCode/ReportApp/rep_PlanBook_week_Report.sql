USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_PlanBook_week_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_PlanBook_week_Report]
@cid int
,@year int
,@term int
,@order varchar(100)
,@page int
,@size int

AS
set @order=CommonFun.dbo.FilterSQLInjection(@order)


create table #templist
(
ty int--0上午1下午
,week int--第几周
,result varchar(max)--0和1
,num int
)

declare @am varchar(max),@pm varchar(max),@amstr varchar(max),@pmstr varchar(max),@planbookid int


select top 1 @am=planconam,@pm=planconpm,@planbookid=planbookid from Ebook..PB_PlanBook where classid=@cid and [year]=@year and term=@term

if(@planbookid is null)
begin
select 0,0,0,'0',0,0

end
else 
begin

set @am=replace(@am,' ','')+'|'
set @pm=replace(@pm,' ','')+'|'

DECLARE @lv_index int, @lv_indexpm int,@i int,@j int,@k int

set @i=1
--将|的数据读取出来
WHILE (LEN(@am) > 0)
begin

SET @lv_index = CHARINDEX('|', @am)
SET @lv_indexpm = CHARINDEX('|', @pm)

 IF (@lv_index>0)
   BEGIN
    SET @amstr = SUBSTRING(@am, 0, @lv_index)
    set @am=SUBSTRING(@am, @lv_index+1, len(@am)-@lv_index)
	insert into #templist (ty,week,result,num) 
	select 0,@i,@amstr,0

    SET @pmstr = SUBSTRING(@pm, 0, @lv_indexpm)
    set @pm=SUBSTRING(@pm, @lv_indexpm+1, len(@pm)-@lv_indexpm)
	insert into #templist (ty,week,result,num) 
	select 1,@i,@pmstr,0
   END
set @i=@i+1
end
--开始分析$数据出来
set @j=1
WHILE (@j < @i)
begin


select @am=result+'$' from #templist where week=@j and ty=0
select @pm=result+'$' from #templist where week=@j and ty=1
set @k=1
while (@k<6)
begin
SET @lv_index = CHARINDEX('$', @am)
SET @lv_indexpm = CHARINDEX('$', @pm)

IF (@lv_index>0)
begin
SET @amstr = SUBSTRING(@am, 1, @lv_index)
set @am=SUBSTRING(@am, @lv_index+1, len(@am)-@lv_index)


SET @pmstr = SUBSTRING(@pm, 1, @lv_indexpm)
set @pm=SUBSTRING(@pm, @lv_indexpm+1, len(@pm)-@lv_indexpm)

if(len(@amstr)>1 or len(@pmstr)>1)
begin
update #templist set num=num+1 where week=@j 
end

end

set @k=@k+1
end

set @j=@j+1
end


--分页
declare @pcount int,@p int
select @pcount=count(week) from #templist where ty=0
set @p=@pcount


while (@p<20)
begin

set @p=@p+1

insert into #templist(ty,week,result,num) 
select 0,@p,'',0


end
set @pcount=@p

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			exec('select week from #templist where ty=0 order by '+@order) 

			SET ROWCOUNT @size
			SELECT 
				@pcount,@planbookid planbookid,week,'第'+convert(varchar,week)+'周' 周数,num 已填天数,5-num 未填天数
			FROM 
				@tmptable AS tmptable		
			INNER JOIN #templist t1
			ON  tmptable.tmptableid=t1.week 	
			WHERE
				row>@ignore and ty=0

end
else
begin
SET ROWCOUNT @size

exec('select '+@pcount+','+@planbookid+' planbookid,week,''第''+convert(varchar,week)+''周'' 周数,num 已填天数,5-num 未填天数 from #templist where ty=0 order by  '+@order) 

end

drop table  #templist

end



GO
