USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[init_hb_homebook]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[init_hb_homebook]
@kid int

as

create table #idtypeList
(
homebookid int
,week varchar(50)
,classid int
,term varchar(50)
,idtype int
,orderby int
)

create table #idtypeListtemp
(
id INT IDENTITY(1, 1)
,homebookid int
,classid int
,term  varchar(50)
,cellremarksetting varchar(500)
)

declare @i int,@uncount int,@cellremarksetting varchar(500),@cellremarksettingstr varchar(50),@idtype int

set @uncount=1

insert into  #idtypeListtemp
select h.hbid,h.classid,h.term,c.cellsettings from gbapp..homebook h 
inner join GBApp..CellSet c on c.cellsetid=h.cellsetid
inner join basicdata..class t1 on h.classid=t1.cid
 where t1.kid=@kid and t1.deletetag=1


select @uncount=count(1) from #idtypeListtemp


declare @j int,@k int
set @i=1 
while (@i<=@uncount)
begin
select @cellremarksetting=cellremarksetting from  #idtypeListtemp where id=@i
set @cellremarksetting=@cellremarksetting+','

set @k=1
set @j=1 
while(charindex(',',@cellremarksetting)<>0)   
begin   
		
		set @cellremarksettingstr=(substring(@cellremarksetting,1,charindex(',',@cellremarksetting)-1))
		set @idtype=1
		if(ISNUMERIC(@cellremarksettingstr)=0)
		begin
			set @idtype=0
		end		 
		--当是月份的时候
		if(@idtype=0)
		begin
			
		if(@cellremarksettingstr in ('3月','4月','5月','6月','7月','8月'))	
		begin
		 
	     insert into #idtypeList
         select  homebookid,replace(term,'-0','年')+@cellremarksettingstr,classid,term,@idtype,@k from #idtypeListtemp where id=@i
		 and term like '%-0'
		if(@@ROWCOUNT>0)
		begin
		 set @k=@k+1
		end 

		end
        else if(@cellremarksettingstr in ('9月','10月','11月','12月'))	
		begin
		 insert into #idtypeList
         select  homebookid,replace(term,'-1','年')+@cellremarksettingstr,classid,term,@idtype,@k from #idtypeListtemp where id=@i
		 and 	term like '%-1' 
		if(@@ROWCOUNT>0)
		begin
		 set @k=@k+1
		end 

		end
		else if(@cellremarksettingstr in ('1月','2月'))	
		begin
		 insert into #idtypeList
         select  homebookid,convert(varchar,(convert(int,replace(term,'-1',''))+1))+'年'+@cellremarksettingstr,classid,term,@idtype,@k from #idtypeListtemp where id=@i
		 and 	term like '%-1' 
		if(@@ROWCOUNT>0)
		begin
		 set @k=@k+1
		end 
		end

		end--当是月份的时候
		else
		begin
		 insert into #idtypeList
         select  homebookid,@cellremarksettingstr,classid,term,@idtype,@j from #idtypeListtemp where id=@i
		end


	     set @cellremarksetting = stuff(@cellremarksetting,1,charindex(',',@cellremarksetting),'')   
set @j=@j+1
end --分割字符串


set @i=@i+1
end


drop table #idtypeListtemp  


--idtype要从0开始索引，所以要减1
--delete rep_homebook_week where classid in (select classid from #idtypeList)

delete rep_homebook_week 
from rep_homebook_week 
inner join BasicData..class c on cid=classid
where kid=@kid and c.deletetag=1

insert into rep_homebook_week(classid,id_type,homebookid,term,title,id_index,off_count,on_count)
select  classid,(idtype-1),d.homebookid,term
,case when idtype=0 then week else '第'+week +'周' end title
,(orderby-1),
sum(case when substring(teacher_point,orderby*(len(substring(teacher_point,1,charindex('|',teacher_point)-1))+1)-len(substring(teacher_point,1,charindex('|',teacher_point)-1)),len(substring(teacher_point,1,charindex('|',teacher_point)-1))) in ('0,0,0,0,0,0,0,0','0,0,0,0,0,0,0,0,0,0',null,'')
then 1 else 0 end) 未读
,sum(case when substring(teacher_point,orderby*(len(substring(teacher_point,1,charindex('|',teacher_point)-1))+1)-len(substring(teacher_point,1,charindex('|',teacher_point)-1)),len(substring(teacher_point,1,charindex('|',teacher_point)-1))) in ('0,0,0,0,0,0,0,0','0,0,0,0,0,0,0,0,0,0',null,'')
then 0 else 1 end) 已读
 from #idtypeList d 
left join GBapp..celllist  g on d.homebookid=g.hbid
inner join BasicData..[user] u on u.userid=g.userid and u.deletetag=1 and u.kid<>0
--where --substring(kinremarkitem,orderby*(len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))+1)-len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1)),len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))) is not null
--d.homebookid=5400
group by classid,idtype,d.homebookid,term,week,orderby
order by d.homebookid,orderby 

drop table #idtypeList --记录最后结果用的临时表




GO
