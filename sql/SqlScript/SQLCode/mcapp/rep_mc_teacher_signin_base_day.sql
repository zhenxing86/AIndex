USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_teacher_signin_base_day]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[rep_mc_teacher_signin_base_day]
 @kid int
,@checktime1 datetime
,@page int
,@size int
 AS 

declare @pcount int

--1是入园，0是离园
create table #temp
(
tid int
,tname nvarchar(30) 
,indate varchar(max) 
,outdate varchar(1000) 
)

create table #tempin
(
xid int
,tname nvarchar(30) 
,idate varchar(max) 
)

create table #tempout
(
oid int
,tname nvarchar(30) 
,odate varchar(1000) 
)

if(datediff(dd,@checktime1,getdate())=0)
begin

insert into #tempin(xid,tname,idate)
	select distinct a.teaid,t.[name],cdate from  dbo.tea_at_day a
left join dbo.teainfo t on a.teaid=t.teaid 
where kid=@kid and ctype=1 and datediff(dd,@checktime1,cdate)=0

order by a.teaid,cdate

insert into #tempout(oid,tname,odate)
	select distinct a.teaid,t.[name],cdate from  dbo.tea_at_day a
left join dbo.teainfo t on a.teaid=t.teaid 
where kid=@kid and ctype=0 and datediff(dd,@checktime1,cdate)=0
order by a.teaid,cdate


end
else
begin

insert into #tempin(xid,tname,idate)
	select distinct a.teaid,t.[name],cdate from  dbo.tea_at_month a
left join dbo.teainfo t on a.teaid=t.teaid 
where kid=@kid and ctype=1 and datediff(dd,@checktime1,cdate)=0
order by a.teaid,cdate

insert into #tempout(oid,tname,odate)
	select distinct a.teaid,t.[name],cdate from  dbo.tea_at_month a
left join dbo.teainfo t on a.teaid=t.teaid 
where kid=@kid and ctype=0 and datediff(dd,@checktime1,cdate)=0
order by a.teaid,cdate

end




insert into  #temp(tid,tname,indate)
select xid,tname
,idate=STUFF((SELECT ','+idate FROM #tempin t WHERE xid=t1.xid FOR XML PATH('')), 1, 1, '')
 from #tempin t1
GROUP BY xid,tname

set @pcount=@@RowCount


delete #tempin

insert into  #tempin(xid,idate)
select oid
,odate=STUFF((SELECT ','+odate FROM #tempout t WHERE oid=t1.oid FOR XML PATH('')), 1, 1, '')
 from #tempout t1
GROUP BY oid





update #temp set outdate=idate  from  #tempin
where xid=tid

update #temp set outdate=',' where outdate is null 


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
			select tid from #temp

			SET ROWCOUNT @size
			SELECT 
				@pcount,@kid,tid,tname,indate,outdate
 			FROM 
				@tmptable AS tmptable		
			INNER JOIN #temp g
			ON  tmptable.tmptableid=g.tid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

select @pcount,@kid,tid,tname,indate,outdate from #temp

end






drop table #tempin
drop table #tempout
drop table #temp



GO
