USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[init_homebook_Byhomebookid]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_homebook_Byhomebookid]
@homebookid int
AS
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
set @i=1
while (@i<21)
begin

insert into #idtypeList
select homebookid,@i,classid,term,1,@i from ebook..hb_homebook 
where not exists(select top 1 1 from ebook..HB_Setting where hbid=homebookid) and homebookid=@homebookid

set @i=@i+1
end


select @uncount=count(1) from ebook..hb_homebook 
where exists(select top 1 1 from ebook..HB_Setting where hbid=homebookid) and homebookid=@homebookid 


insert into  #idtypeListtemp
select homebookid,classid,term,cellremarksetting from ebook..hb_homebook 
inner join ebook..HB_Setting on hbid=homebookid and homebookid=@homebookid

declare @j int
set @i=1 
while (@i<=@uncount)
begin
select @cellremarksetting=cellremarksetting from  #idtypeListtemp where id=@i
set @cellremarksetting=@cellremarksetting+','

set @j=1 
while(charindex(',',@cellremarksetting)<>0)   
begin   
		
		set @cellremarksettingstr=(substring(@cellremarksetting,1,charindex(',',@cellremarksetting)-1))
		set @idtype=1
		if(len(@cellremarksettingstr)>3)
		begin
			set @idtype=0
		end		 

		 insert into #idtypeList
         select  homebookid,@cellremarksettingstr,classid,term,@idtype,@j from #idtypeListtemp where id=@i
          
	     set @cellremarksetting = stuff(@cellremarksetting,1,charindex(',',@cellremarksetting),'')   
set @j=@j+1
end --分割字符串

set @i=@i+1
end


drop table #idtypeListtemp  
 --记录最后结果用的临时表
delete from reportapp..rep_homebook_week where homebookid=@homebookid
--idtype要从0开始索引，所以要减1
insert into reportapp..rep_homebook_week(classid,id_type,homebookid,term,title,id_index,off_count,on_count)
select  classid,(idtype-1),d.homebookid,term
,case when idtype=0 then week else '第'+week +'周' end title
,orderby,
sum(case when substring(kinremarkitem,orderby*(len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))+1)-len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1)),len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))) in ('0,0,0,0,0,0,0,0','0,0,0,0,0,0,0,0,0,0',null,'')
then 1 else 0 end) 未读
,sum(case when substring(kinremarkitem,orderby*(len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))+1)-len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1)),len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))) in ('0,0,0,0,0,0,0,0','0,0,0,0,0,0,0,0,0,0',null,'')
then 0 else 1 end) 已读
 from #idtypeList d 
left join ebook..gb_weekremark  g on d.homebookid=g.homebookid
where d.homebookid=@homebookid
group by classid,idtype,d.homebookid,term,week,orderby
order by d.homebookid,orderby 

drop table #idtypeList

GO
