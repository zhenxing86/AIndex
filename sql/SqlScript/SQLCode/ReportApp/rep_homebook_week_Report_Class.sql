USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_week_Report_Class]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[rep_homebook_week_Report_Class] 
@title varchar(50)
,@kid int
,@term varchar(100) --年-学期
,@order varchar(50)
,@page int
,@size int
AS

set @term=CommonFun.dbo.FilterSQLInjection(@term)
set @order=CommonFun.dbo.FilterSQLInjection(@order)

declare @pcount int,@htype int
select @pcount=count(1),@htype=1 from BasicData..class  c
left join GBApp..homebook h on c.cid=h.classid and term=@term
where c.grade<>38 and c.kid=@kid and  c.deletetag=1--group by booktype


IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint,
			cid int,
			cname varchar(50),
			title varchar(50),
			on_count int,
			off_count int,
			homebookid int,
			id_index int,
			id_type int
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable
			exec('select cid tid,cid,cname ,'''+@title+''' title
,(select top 1 on_count from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+''' ) on_count
,(select top 1 off_count from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+'''  ) off_count
,(select top 1 homebookid from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+''' ) homebookid
,(select top 1 id_index from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+''' ) id_index
,(select top 1 id_type from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+''' ) id_index
  from BasicData..class b inner join BasicData..grade g on g.gid=b.grade where b.deletetag=1 and g.gid<>38 and kid='+@kid+' order by '+@order)

			SET ROWCOUNT @size
			SELECT 
				@pcount,cid ,cname ,title ,on_count,off_count,homebookid,id_index,id_type,@htype
			FROM 
				@tmptable AS tmptable
			WHERE
				row>@ignore 


end
else
begin
SET ROWCOUNT @size
if (@pcount is null)
begin
set @pcount=0
set @htype=0
end

exec('select '+@pcount+',cid,cname,'''+@title+''' title
,(select top 1 on_count from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+'''  ) on_count
,(select top 1 off_count from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+''' ) off_count
,(select top 1 homebookid from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+''' ) homebookid
,(select top 1 id_index from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+''' ) id_index
,(select top 1 id_type from rep_homebook_week where classid=cid and title='''+@title+''' and term ='''+@term+''' ) id_index
,'+@htype+' from BasicData..class b inner join BasicData..grade g on g.gid=b.grade where b.deletetag=1 and g.gid<>38 and kid='+@kid+' order by '+@order)


end






GO
