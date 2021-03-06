USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_notebook_week_Report_List]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--（默认本月  上一月  下一月）或（默认本周，上一周，下一周）
CREATE PROCEDURE [dbo].[rep_notebook_week_Report_List]  
@kid int  
,@userid int  
,@yearmonth varchar(20)--格式2011-1  
,@week int--第一周为：1  
,@types int--0：表示按月计算，1表示按周计算  
,@order varchar(50)  
,@page int  
,@size int  
,@u int  
,@myuserid int  
AS  
set @yearmonth=convert(varchar(7),convert(datetime,@yearmonth+'-1'),120)  
  
  
if(@order<>' createdate desc' and @order<>'createdate desc')  
set @order=CommonFun.dbo.FilterSQLInjection(@order)  
  
  
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
   exquisite int,  
   isread datetime  
  )  
  
declare @pcount int  
  
declare @whe varchar(600)  
  
if(@types=0)  
begin  
--select @pcount=  
--(select case when sum(notecount) is null then 0 else sum(notecount) end   
--from ReportApp..rep_notebook_week r   
--where r.booktype=@u and u.userid=r.userid and yearmonth like @yearmonth )   
--from BasicData..[user] u   
--where u.usertype <>0 and u.userid = @userid  
--group by u.userid,u.[name],u.userid   
  
  
select  @pcount=COUNT( distinct c.chapterid)  
from ReportApp..rep_notebook_week  r  
inner join BasicData..[user] s on s.userid=r.userid and s.kid=convert(varchar,@kid)  
inner join EBook..Tnb_teachingNoteBook t on t.userid=r.userid and t.booktype=convert(varchar,@u)  
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid  and c.chaptertitle<>'帮助说明'  
where r.userid=convert(varchar,@userid) and c.deletetag=1 and convert(varchar(4),yearmonth,120) = convert(varchar(4),@yearmonth,120) and  datediff(MM,c.createdate,convert(datetime,@yearmonth+'-1'))=0  
  
  
  
set @whe=' where r.userid = '+convert(varchar,@userid)+' and yearmonth = '''+@yearmonth+''' and datediff(MM,c.createdate,convert(datetime,'''+@yearmonth+'-1'+'''))=0 '  
end  
else  
begin  
  
--select @pcount=(select case when sum(notecount) is null then 0 else sum(notecount) end   
--from ReportApp..rep_notebook_week r   
--where u.userid=r.userid and week=convert(varchar,@week) and convert(varchar(4),yearmonth,120)=convert(varchar(4),@yearmonth,120))   
--from BasicData..[user] u   
--where u.usertype <>0 and u.userid = @userid  
  
--group by u.userid,u.[name],u.userid   
  
  
select  @pcount=COUNT( distinct c.chapterid)  
from ReportApp..rep_notebook_week  r  
inner join BasicData..[user] s on s.userid=r.userid and s.kid=convert(varchar,@kid)  
inner join EBook..Tnb_teachingNoteBook t on t.userid=r.userid and t.booktype=convert(varchar,@u)  
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid  and c.chaptertitle<>'帮助说明' and c.deletetag = 1 
where r.userid=convert(varchar,@userid) and convert(varchar(4),yearmonth,120) = convert(varchar(4),@yearmonth,120) and Datepart(week,c.createdate)=convert(varchar,@week)  
  
  
 set @whe='where r.userid='+convert(varchar,@userid)+' and c.deletetag=1 and  convert(varchar(4),yearmonth,120) = '''+convert(varchar(4),@yearmonth,120)+''''+' and Datepart(week,c.createdate)='''+convert(varchar,@week)+''''  
end  
  
  
  
  
  
  
IF(@page>1)  
 BEGIN  
  
   SET ROWCOUNT @prep  
   INSERT INTO @tmptable(tmptableid,userid,uname,chapterid,chaptertitle,grade,subject,createdate,exquisite,isread)  
   exec('select distinct r.userid u1,r.userid,s.[name],c.chapterid,c.chaptertitle,c.grade,c.subject,convert(datetime,c.createdate,120) createdate,c.exquisite,  
   (select intime from ReportApp..rep_read_article rr where rr.userid='+@myuserid+' and rr.articleid=c.chapterid) isread    
   from ReportApp..rep_notebook_week  r  
inner join BasicData..[user] s on s.userid=r.userid and s.kid='+@kid+'  
inner join EBook..Tnb_teachingNoteBook t on t.userid=r.userid and t.booktype='+@u+'  
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid  and c.deletetag = 1 '+@whe+' and c.chaptertitle<>''帮助说明'' order by '+@order)  
  
   SET ROWCOUNT @size  
   SELECT   
    distinct @pcount,userid,uname,chapterid,chaptertitle,grade,subject,createdate,exquisite,isread  
    ,(select max(userid) from ReportApp..rep_read_article rr where rr.userid=@myuserid and rr.articleid=tmptable.chapterid) isread  
   FROM   
    @tmptable AS tmptable    
   WHERE  
    row>@ignore   
  
  
end  
else  
begin  
  
SET ROWCOUNT @size  
  
declare @sql varchar(max)  
set @sql=  
'select distinct '''+convert(varchar,@pcount)+''',r.userid,s.[name],c.chapterid,c.chaptertitle,c.grade,c.subject,convert(datetime,c.createdate) createdate,c.exquisite,  
(select intime from ReportApp..rep_read_article rr where rr.userid='+convert(varchar,@myuserid)+' and rr.articleid=c.chapterid) isread   
from ReportApp..rep_notebook_week  r  
inner join BasicData..[user] s on s.userid=r.userid and s.kid='+convert(varchar,@kid)+'  
inner join EBook..Tnb_teachingNoteBook t on t.userid=r.userid and t.booktype='+convert(varchar,@u)+'  
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid and c.deletetag = 1 '+@whe+' and c.chaptertitle<>''帮助说明'' order by '+@order   
  
print @sql  
exec(@sql)  
  
end  
GO
