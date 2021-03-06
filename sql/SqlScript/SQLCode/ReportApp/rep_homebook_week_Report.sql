USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_week_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[rep_homebook_week_Report]
@classid int
,@term varchar(100) --年-学期
,@order varchar(50)
,@page int
,@size int
AS

set @term=CommonFun.dbo.FilterSQLInjection(@term)
set @order=CommonFun.dbo.FilterSQLInjection(@order)
declare @hbid int
select @hbid=hbid from gbapp..homebook where classid=@classid and term=@term

if(exists(select 1 from homebook_log where hbid=@hbid))
begin	
	exec init_homebook_ByhomebookidV2 @hbid	
end

declare @cname varchar(30),@bl int

select @cname=cname from BasicData..class where cid=@classid 


select @bl=count(ID) from ReportApp..rep_homebook_week where classid=@classid and term=@term

if(@bl<1)
begin
select 1,2,'3',-1,'5',6,7,8,9,10
end 
else 
begin

declare @pcount int,@htype int
select @pcount=count(1),@htype=1 from ReportApp..rep_homebook_week r
inner join GBApp..homebook h on r.homebookid=h.hbid
where r.classid=@classid and r.term=@term --group by booktype




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
			exec(' SELECT ID from ReportApp..rep_homebook_week 
where classid='''+@classid+''' and term='''+@term+''' order by '+@order)

			SET ROWCOUNT @size
			SELECT 
				@pcount,classid 班级ID,@cname 班级名称,id_type 类型,title 标题,sum(on_count) 已填,sum(off_count) 未填,homebookid,id_index,@htype 
			FROM 
				@tmptable AS tmptable		
			INNER JOIN ReportApp..rep_homebook_week t1
			ON  tmptable.tmptableid=t1.ID 	
			WHERE
				row>@ignore 
group by classid,term,title,ID,on_count,off_count,id_type,homebookid,id_index

end
else
begin
SET ROWCOUNT @size

if(@pcount is null)
begin
set @pcount=0
end

if(@htype is null)
begin
set @htype=1
end

exec('select '+@pcount+',classid 班级ID,'''+@cname+''' 班级名称,id_type 类型,title 标题,sum(on_count) 已填,sum(off_count) 未填,homebookid,id_index,'+@htype+' from ReportApp..rep_homebook_week 
where classid='''+@classid+''' and term='''+@term+''' group by id_type,classid,term,title,ID,on_count,off_count,homebookid,id_index order by '+@order)

end

end





GO
