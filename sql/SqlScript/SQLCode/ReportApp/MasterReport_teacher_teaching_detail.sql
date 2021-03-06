USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_teacher_teaching_detail]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[dbo].[MasterReport_teacher_teaching_detail]   12511,296418,'2013-4',2,10,'电子教案',466920

create PROCEDURE [dbo].[MasterReport_teacher_teaching_detail]  
@kid int  
,@userid int  
,@yearmonth varchar(20)--格式2011-1
,@page int  
,@size int  
,@title varchar(20)
,@myuserid int  
AS  
set @yearmonth=convert(varchar(7),convert(datetime,@yearmonth+'-1'),120)  

DECLARE @prep int,@ignore int,@u int

  set @u = (case when @title = '电子教案'then 0
                when @title = '教学随笔'then 1
                when @title = '教学反思'then 2
                when @title = '观察记录'then 3 END)
  
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
  
begin 

select  @pcount=COUNT( distinct c.chapterid)  
from ReportApp..rep_notebook_week  r  
inner join BasicData..[user] s on s.userid=r.userid and s.kid=convert(varchar,@kid)  
inner join EBook..Tnb_teachingNoteBook t on t.userid=r.userid and t.booktype=convert(varchar,@u)  
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid  and c.chaptertitle<>'帮助说明'  
where r.userid=convert(varchar,@userid) and c.deletetag=1 and convert(varchar(4),yearmonth,120) = convert(varchar(4),@yearmonth,120) and  datediff(MM,c.createdate,convert(datetime,@yearmonth+'-1'))=0  

set @whe=' where r.userid = '+convert(varchar,@userid)+' and yearmonth = '''+@yearmonth+''' and datediff(MM,c.createdate,convert(datetime,'''+@yearmonth+'-1'+'''))=0 '  
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
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid  and c.deletetag = 1 '+@whe+' and c.chaptertitle<>''帮助说明'' ')  
  
   SET ROWCOUNT @size  
   SELECT   
    distinct @pcount pcount,userid,uname,chapterid,chaptertitle,grade,subject,createdate,exquisite,isread  
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
'select distinct '''+convert(varchar,@pcount)+''' pcount,r.userid,s.[name],c.chapterid,c.chaptertitle,c.grade,c.subject,convert(datetime,c.createdate) createdate,c.exquisite,  
(select intime from ReportApp..rep_read_article rr where rr.userid='+convert(varchar,@myuserid)+' and rr.articleid=c.chapterid) isread   
from ReportApp..rep_notebook_week  r  
inner join BasicData..[user] s on s.userid=r.userid and s.kid='+convert(varchar,@kid)+'  
inner join EBook..Tnb_teachingNoteBook t on t.userid=r.userid and t.booktype='+convert(varchar,@u)+'  
inner join EBook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid and c.deletetag = 1 '+@whe+' and c.chaptertitle<>''帮助说明'' '
  
print @sql  
exec(@sql)  
  
end  



GO
