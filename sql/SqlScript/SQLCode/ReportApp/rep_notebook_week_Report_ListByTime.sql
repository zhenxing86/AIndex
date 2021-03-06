USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_notebook_week_Report_ListByTime]    Script Date: 06/15/2013 15:28:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--（默认本月  上一月  下一月）或（默认本周，上一周，下一周）
ALTER PROCEDURE [dbo].[rep_notebook_week_Report_ListByTime]
@kid int
,@firsttime datetime--格式2011-1
,@lasttime datetime--第一周为：1
,@order varchar(50)
,@page int
,@size int
,@grade varchar(50)
,@subject varchar(50)
,@title varchar(50)
,@u int
,@douserid int=0
,@isread int=-1
,@isfine int=-1
AS


if (@order <>'createdate desc' and @order <>' createdate desc')
set @order=CommonFun.dbo.FilterSQLInjection(@order)

set @title=CommonFun.dbo.FilterSQLInjection(@title)
set @grade=CommonFun.dbo.FilterSQLInjection(@grade)
set @subject=CommonFun.dbo.FilterSQLInjection(@subject)

DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint,
			pcount int ,
			userid int,
			uname varchar(50),
			chapterid int ,
			chaptertitle varchar(300),
			grade  varchar(50),
			subject  varchar(50),
			createdate datetime,
			title varchar(50),
			readtime datetime,
			exquisite int
		)

declare @pcount int

select @pcount=count(1) from  EBook..Tnb_teachingNoteBook t
inner join BasicData..[user] u on u.userid=t.userid and u.kid=@kid 
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid
inner join BasicData..teacher te on te.userid=u.userid
left join rep_read_article rra on rra.articleid=c.chapterid and rra.userid=@douserid
where c.createdate between @firsttime and @lasttime and c.deletetag=1
and te.title like ''+@title+'%' 
and grade like ''+@grade+'%' 
and [subject] like ''+@subject+'%'  
and t.booktype=@u
and c.chaptertitle<>'帮助说明'
and (@isread=-1 or @isread=(case when rra.intime is null then 0 else 1 end))

declare @where varchar(5000)=''
if(@isread>-1)
begin
set @where='and '+convert(varchar,@isread)+'=(case when rra.intime is null then 0 else 1 end) and c.deletetag=1'
end


IF(@page>1)
	BEGIN

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid,userid,uname,chapterid,chaptertitle,grade,subject,createdate,title,readtime,exquisite)
			exec('select t.userid,t.userid,s.[name],c.chapterid,c.chaptertitle,c.grade,c.subject,convert(datetime,c.createdate) createdate,te.title,rra.intime,0 exquisite 
from  EBook..Tnb_teachingNoteBook t
inner join BasicData..[user] s on s.userid=t.userid and s.kid='+@kid+'
inner join BasicData..teacher te on te.userid=s.userid
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid and c.deletetag = 1
left join rep_read_article rra on rra.articleid=c.chapterid and rra.userid='+@douserid+'
where c.createdate between convert(datetime,'''+@firsttime+''')  and convert(datetime,'''+@lasttime+''') '+@where+' and c.chaptertitle<>''帮助说明''  and te.title like '''+@title+'%'' and grade like '''+@grade+'%'' and subject like '''+@subject+'%''  and t.booktype='+@u+' order by '+@order )

			SET ROWCOUNT @size
			SELECT 
				@pcount,userid,uname,chapterid,chaptertitle,grade,subject,createdate,title,readtime,exquisite 
			FROM 
				@tmptable AS tmptable		
			WHERE
				row>@ignore 


end
else
begin

SET ROWCOUNT @size
declare @sql varchar(6000)

set @sql=
'select '+convert(varchar,isnull(@pcount,0))+',t.userid,s.[name],c.chapterid,c.chaptertitle,c.grade,c.subject,convert(datetime,c.createdate) createdate,te.title,rra.intime readtime,0 exquisite
from  EBook..Tnb_teachingNoteBook t
inner join BasicData..[user] s on s.userid=t.userid and s.kid='+convert(varchar,@kid)+'
inner join BasicData..teacher te on te.userid=s.userid
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid and c.deletetag = 1
left join rep_read_article rra on rra.articleid=c.chapterid and rra.userid='+convert(varchar,@douserid)+'
where c.createdate between convert(datetime,'''+convert(varchar,@firsttime,120)+''')  and convert(datetime,'''+convert(varchar,@lasttime,120)+''') 
and te.title like '''+@title+'%'' and grade like '''+@grade+'%'' 
and subject like '''+@subject+'%'' and t.booktype='+convert(varchar,@u)+' and c.chaptertitle<>''帮助说明'' '+@where+' order by '+@order

print @sql

exec(@sql)


 

end
GO

