USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetTeachingNoteBookLsit]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UI_gartenlist_GetTeachingNoteBookLsit]  
 @page int,  
 @size int,  
 @booktype int  
  AS  
    
  declare @pcount int  
  declare @size_ int  
   
   
 DECLARE @tp TABLE  
 (  
  pc int  
 )  
  
 if(@booktype=0)  
 begin  
     
 insert into @tp  
 SELECT count(t1.teachingnotebookid)  
 FROM  [EBook]..TNB_TeachingNoteBook t1  
 inner join [gartenlist] t2 on t1.kid=t2.kid     
 inner join ebook..TNB_Chapter t3 on t1.teachingnotebookid = t3.teachingnotebookid and booktype = @booktype and  exquisite =1 and t3.deletetag = 1
 end  
 else  
 begin  
 insert into @tp  
 SELECT count(t1.teachingnotebookid)  
 FROM  [EBook]..TNB_TeachingNoteBook t1  
 inner join [gartenlist] t2 on t1.kid=t2.kid     
 inner join ebook..TNB_Chapter t3 on t1.teachingnotebookid = t3.teachingnotebookid and booktype = @booktype  and t3.deletetag = 1
   
 end  
 select @pcount=pc from @tp  
   
 IF(@page>1)  
  BEGIN  
   DECLARE @prep int,@ignore int  
   SET @prep=@size*@page  
   SET @ignore =@prep-@size  
   DECLARE @tmptable TABLE  
   (  
    row int IDENTITY(1,1),  
    tmptableid bigint  
   )  
     
   if(@booktype=0)  
   begin  
     
   SET ROWCOUNT @prep  
   INSERT INTO @tmptable (tmptableid)  
   select t1.teachingnotebookid  
    FROM [EBook]..TNB_TeachingNoteBook t1  
       inner join gartenlist t2 on  t1.kid = t2.kid and booktype = @booktype  
       inner join ebook..TNB_Chapter t3 on t1.teachingnotebookid = t3.chapterid and exquisite =1 and t3.deletetag = 1  
    order by t1.createdate desc  
      
      
    end  
    else  
    begin  
      
    SET ROWCOUNT @prep  
    INSERT INTO @tmptable (tmptableid)  
    select t1.teachingnotebookid  
    FROM [EBook]..TNB_TeachingNoteBook t1  
       inner join gartenlist t2 on  t1.kid = t2.kid and booktype = @booktype  
       inner join ebook..TNB_Chapter t3 on t1.teachingnotebookid = t3.chapterid  and t3.deletetag = 1
    order by t1.createdate desc  
      
      
    end   
      
    SET ROWCOUNT @size  
    SELECT @pcount, t1.teachingnotebookid,t1.booktitle,t1.createdate,t1.username,t3.chapterid,t3.chaptertitle, t2.kname  
       FROM  @tmptable a  
       inner join [EBook]..TNB_TeachingNoteBook t1 on t1.teachingnotebookid = a.tmptableid  
    inner join [gartenlist] t2 on t1.kid=t2.kid     
    inner join ebook..TNB_Chapter t3 on t1.teachingnotebookid = t3.chapterid and exquisite =1  and t3.deletetag = 1         
     WHERE row>@ignore   
 end  
 else  
 begin  
 SET ROWCOUNT @size  
 if(@pcount is null)  
 begin  
 set @pcount=0  
 end  
   
 if(@booktype=0)  
 begin  
   
 SELECT @pcount, t1.teachingnotebookid,t1.booktitle,t1.createdate,t1.username,t3.chapterid,t3.chaptertitle,t2.kname  
 FROM  [EBook]..TNB_TeachingNoteBook t1  
 inner join [gartenlist] t2 on t1.kid=t2.kid     
 inner join ebook..TNB_Chapter t3 on t1.teachingnotebookid = t3.teachingnotebookid and booktype = @booktype and  exquisite =1 and t3.deletetag = 1
 order by t1.createdate desc  
   
 end  
 else  
 begin  
   
 SELECT @pcount, t1.teachingnotebookid,t1.booktitle,t1.createdate,t1.username,t3.chapterid,t3.chaptertitle, t2.kname  
 FROM  [EBook]..TNB_TeachingNoteBook t1  
 inner join [gartenlist] t2 on t1.kid=t2.kid     
 inner join ebook..TNB_Chapter t3 on t1.teachingnotebookid = t3.teachingnotebookid and booktype = @booktype and t3.deletetag = 1
 order by t1.createdate desc  
   
 end   
   
 end  
 RETURN 0  

GO
