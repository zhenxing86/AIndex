USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_notebook_week_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2013-07-16    
-- Description: （默认本月  上一月  下一月）或（默认本周，上一周，下一周）    
-- Memo:    
exec rep_notebook_week_Report 12511, '2013-7',20,0,'name',1,10,'',-1      
exec rep_notebook_week_Report 12511, '2013-7',20,0,'name',2,10,'',-1  
*/    
CREATE PROCEDURE [dbo].[rep_notebook_week_Report]      
 @kid int,      
 @yearmonth varchar(20),--格式2011-1      
 @week int,--第一周为：1      
 @types int,--0：表示按月计算，1表示按周计算      
 @order varchar(50),      
 @page int,      
 @size int,      
 @title varchar(50),      
 @u int,      
 @douserid int=0      
AS      
BEGIN      
 SET NOCOUNT ON      
 set @yearmonth=convert(varchar(7),convert(datetime,@yearmonth+'-1'),120)      
 set @order=CommonFun.dbo.FilterSQLInjection(@order)      
 set @title=CommonFun.dbo.FilterSQLInjection(@title)      
      
 if(@order='数量 desc')      
 begin      
 set @order='notecount desc'      
 end      
       
 create table #tmptable      
 (      
  row int IDENTITY(1,1) primary key,      
  userid int,      
  uname varchar(50),      
  notecount int,      
  title varchar(50),      
  newcount int      
 )      
    
  select t.userid,count(c.teachingnotebookid) notecount    
    Into #notecount    
    from ebook..tnb_teachingnotebook t      
      left join ebook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid and c.deletetag = 1     
      left join BasicData..[user] u on t.userid=u.userid      
    where u.kid = @kid and u.deletetag=1 and c.chaptertitle<>'帮助说明'     
      and t.booktype = Case When @u = -1 Then t.booktype Else @u End    
      and c.createdate >= Case When @types = 0 then CAST(@yearmonth + '-1' AS Datetime) else dateadd(wk, -1, dateadd(dd, datepart(DW, convert(varchar(4),@yearmonth,120) + '-01-01'), DATEADD(wk, @week - 1, convert(varchar(4),@yearmonth,120) + '-01-01'))) end    
      and c.createdate < Case When @types = 0 then DATEADD(mm, 1, CAST(@yearmonth + '-1' AS Datetime)) else dateadd(dd, datepart(DW, convert(varchar(4),@yearmonth,120) + '-01-01'), DATEADD(wk, @week - 1, convert(varchar(4),@yearmonth,120) + '-01-01')) end
  
    
    group by t.userid     
      
 declare @pcount int,@SQL NVARCHAR(4000)      
 set @SQL = '      
  select u.userid userid2,u.[name],      
    (select case when sum(notecount) is null then 0 else sum(notecount) end notecount          
     from #notecount r       
     where u.userid = r.userid) notecount,      
      t.title       
   from BasicData..[user] u       
    inner join BasicData..teacher t on t.userid = u.userid      
   where u.usertype <> 0  and u.deletetag=1      
   and u.kid = @kid '+CASE WHEN ISNULL(@title,'') <> '' then '      
   and t.title like @title +''%''' ELSE '' END+'        
   group by u.userid,u.[name],t.title order by '+@order      
          
 DECLARE @ParmDefinition NVARCHAR(4000)      
  SET @ParmDefinition =       
  N' @kid INT = NULL,      
    @title varchar(50) = NULL';      
    PRINT  @SQL      
          
       
          
 INSERT INTO #tmptable(userid,uname, notecount,title)            
 EXEC SP_EXECUTESQL @SQL,@ParmDefinition,      
   @kid = @kid,      
   @title = @title      
 SET @pcount = @@ROWCOUNT       
      
 ;with      
  cet      
  as      
 (      
 select tx.userid xuid,COUNT(1) readcount from #tmptable tx      
 inner join ebook..tnb_teachingnotebook t on tx.userid=t.userid      
 inner join ebook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid and c.chaptertitle<>'帮助说明' and c.deletetag = 1  
 inner join dbo.rep_read_article rr on rr.articleid=c.chapterid      
 where c.chaptertitle<>'帮助说明' and rr.userid=@douserid       
  and convert(varchar(7),c.createdate,120)=@yearmonth       
  and t.booktype=@u       
  group by tx.userid      
 )      
       
 update tx set newcount = notecount-isnull(readcount,0)      
  from #tmptable tx      
  left join cet on xuid=tx.userid      
        
        
       
 exec sp_GridViewByPager      
    @viewName = '#tmptable',             --表名      
    @fieldName = ' @D1 pcount, userid, uname, notecount, title,newcount',      --查询字段      
    @keyName = 'row',       --索引字段      
    @pageSize = @size,                 --每页记录数      
    @pageNo = @page,                     --当前页      
    @orderString = ' row ',          --排序条件      
    @whereString = ' 1=1 ' ,  --WHERE条件      
    @IsRecordTotal = 0,             --是否输出总记录条数      
    @IsRowNo = 0,         
    @D1 = @pcount      
          
    drop table #tmptable, #notecount      
          
END      
    
  
GO
