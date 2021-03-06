USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[getexquisiteTNB_Books_List]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
      
------------------------------------      
----获取优秀文档 getexquisiteTNB_Books_List 2,10,12511,''      
------------------------------------      
CREATE PROCEDURE [dbo].[getexquisiteTNB_Books_List]      
 @page int      
,@size int       
,@kid int,         
@term varchar(50),  
@booktype int,
@userid int=0       
 AS       
  if(@kid=0)
  begin
	select @kid=isnull(kid,0) from BasicData..[user] where userid=@userid
  end   
declare @pcount int      
      
SELECT @pcount=count(1)  FROM EBook..TNB_Chapter t1         
    left join EBook..tnb_teachingnotebook t2 on t1.teachingnotebookid=t2.teachingnotebookid         
      left join basicdata..[user] t3 on t2.userid = t3.userid        
     where   t1.exquisite=1  and t3.kid=@kid and booktype=@booktype and t2.term like '%'+@term +'%'   and t1.deletetag = 1      
      
      
      
IF(@page>1)      
 BEGIN      
       
  DECLARE @prep int,@ignore int      
      
  SET @prep=@size*@page      
  SET @ignore=@prep-@size      
      
  if(@pcount<@ignore)      
  begin      
   set @page=@pcount/@size      
   if(@pcount%@size<>0)      
   begin      
    set @page=@page+1      
   end      
   SET @prep=@size*@page      
   SET @ignore=@prep-@size      
  end      
        
  DECLARE @tmptable TABLE      
  (      
   row int IDENTITY(1,1),      
   tmptableid bigint      
  )      
      
   SET ROWCOUNT @prep      
   INSERT INTO @tmptable(tmptableid)      
    select  t1.chapterid      
    FROM EBook..TNB_Chapter t1         
    left join EBook..tnb_teachingnotebook t2 on t1.teachingnotebookid=t2.teachingnotebookid         
    left join basicdata..[user] t3 on t2.userid = t3.userid        
     where   t1.exquisite=1 and t3.kid=@kid and booktype=@booktype and t2.term like '%'+@term +'%'    and t1.deletetag = 1      
  order by t1.chapterid desc    
   SET ROWCOUNT @size      
   SELECT       
    @pcount, g.chapterid,g.chaptertitle,g.subject,g.grade,g.createdate,g.exquisite     FROM       
    @tmptable AS tmptable        
   INNER JOIN TNB_Chapter g      
   ON  tmptable.tmptableid=g.chapterid        
   WHERE      
    row>@ignore       
    order by g.chapterid desc    
      
end      
else      
begin      
SET ROWCOUNT @size      
      
 select  @pcount,t1.chapterid,t1.chaptertitle,t1.subject,t1.grade,t1.createdate,t1.exquisite        
    FROM EBook..TNB_Chapter t1         
    left join EBook..tnb_teachingnotebook t2 on t1.teachingnotebookid=t2.teachingnotebookid         
    left join basicdata..[user] t3 on t2.userid = t3.userid        
     where   t1.exquisite=1 and t3.kid=@kid and booktype=@booktype and t2.term like '%'+@term +'%'  and t1.deletetag = 1      
     order by t1.chapterid desc    
end      
GO
