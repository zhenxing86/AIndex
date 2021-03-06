USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_weekByhomebookid]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[rep_homebook_weekByhomebookid]
@homebookid int,
@id_index int
AS

if exists(select * from tempdb..sysobjects where id=object_id('tempdb..#idtypeList1'))
drop table #idtypeList1

create table #idtypeList1
(
homebookid int
,week varchar(50)
,classid int
,term varchar(50)
,idtype int
,orderby int
)

if exists(select * from tempdb..sysobjects where id=object_id('tempdb..#idtypeListtemp1'))
drop table #idtypeListtemp1

create table #idtypeListtemp1
(
id INT IDENTITY(1, 1)
,homebookid int
,classid int
,term  varchar(50)
,cellremarksetting varchar(500)
)

declare @i int,@uncount int,@cellremarksetting varchar(500),@cellremarksettingstr varchar(50),@idtype int
set @i=1
while (@i<27)
begin

insert into #idtypeList1
select homebookid,@i,classid,term,1,@i from ebook..hb_homebook 
where not exists(select top 1 1 from ebook..HB_Setting where hbid=homebookid) and homebookid=@homebookid 

set @i=@i+1
end

select @uncount=count(1) from ebook..hb_homebook 
where exists(select top 1 1 from ebook..HB_Setting where hbid=homebookid)  and homebookid=@homebookid 


insert into  #idtypeListtemp1
select homebookid,classid,term,cellremarksetting from ebook..hb_homebook 
inner join ebook..HB_Setting on hbid=homebookid and homebookid=@homebookid 



declare @j int
set @i=1 
while (@i<=@uncount)
begin
select @cellremarksetting=cellremarksetting from  #idtypeListtemp1 where id=@i


set @j=1 
while(charindex(',',@cellremarksetting)<>0)   
begin   
		
		set @cellremarksettingstr=(substring(@cellremarksetting,1,charindex(',',@cellremarksetting)-1))
		set @idtype=1
		if(len(@cellremarksettingstr)>3)
		begin
			set @idtype=0
		end		 

		 insert into #idtypeList1
         select  homebookid,@cellremarksettingstr,classid,term,@idtype,@j from #idtypeListtemp1 where id=@i
          
	     set @cellremarksetting = stuff(@cellremarksetting,1,charindex(',',@cellremarksetting),'')   
set @j=@j+1
end --分割字符串

set @i=@i+1
end

declare @a varchar(20),@b varchar(20),@c varchar(20),@d varchar(20)

select @a=(orderby-1) ,@b=g.homebookid,
@c=sum(case when substring(kinremarkitem,orderby*(len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))+1)-len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1)),len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))) in ('0,0,0,0,0,0,0,0','0,0,0,0,0,0,0,0,0,0',null,'')
then 1 else 0 end) 
,@d=sum(case when substring(kinremarkitem,orderby*(len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))+1)-len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1)),len(substring(kinremarkitem,1,charindex('|',kinremarkitem)-1))) in ('0,0,0,0,0,0,0,0','0,0,0,0,0,0,0,0,0,0',null,'')
then 0 else 1 end) 
 from #idtypeList1 d 
left join ebook..gb_weekremark  g on d.homebookid=g.homebookid
where (orderby-1)=@id_index
group by orderby,g.homebookid

update reportapp..rep_homebook_week set on_count=@d ,off_count=@c where id_index=@a and homebookid=@b
select @a id_index,@b homebookid,@c 未读,@d 已读

drop table #idtypeListtemp1  
drop table #idtypeList1
 



GO
