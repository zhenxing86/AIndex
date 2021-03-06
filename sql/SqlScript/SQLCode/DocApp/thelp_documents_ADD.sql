USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_ADD]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
    
------------------------------------    
--用途：新增文档    
--项目名称：ZGYEYBLOG    
--说明：    
--时间：2008-10-03 21:30:07    
--作者：along    
------------------------------------    
CREATE PROCEDURE [dbo].[thelp_documents_ADD]    
@categoryid int,    
@title nvarchar(100),    
@docdescription nvarchar(200),    
@body ntext,    
@classdisplay int,    
@kindisplay int,    
@publishdisplay int,    
@userid int,    
@docauthor nvarchar(30),    
@classid int,    
@kid int,    
@kindoccategoryid int,    
@pubcategoryid int    
 AS     
     
 SET TRANSACTION ISOLATION LEVEL READ COMMITTED    
 BEGIN TRANSACTION    
    
 INSERT INTO thelp_documents(    
 [categoryid],[title],[description],[body],[classdisplay],[kindisplay],[publishdisplay],[createdatetime],[viewcount],[userid],[author],[classid],[kid],[kindoccategoryid],[pubcategoryid],[deletetag]    
 )VALUES(    
 @categoryid,@title,@docdescription,@body,@classdisplay,@kindisplay,@publishdisplay,getdate(),0,@userid,@docauthor,@classid,@kid,@kindoccategoryid,@pubcategoryid,1    
 )    
     
 UPDATE thelp_categories SET documentcount=documentcount+1 WHERE categoryid=@categoryid    
    
declare @pcid int,@parentflag int,@kin_oldpcid int  
select @pcid=parentid from thelp_categories WHERE categoryid=@categoryid  
UPDATE thelp_categories SET documentcount=documentcount+1 WHERE categoryid=@pcid      
 while(@pcid<>0)   
 Begin  
select @pcid=parentid from thelp_categories WHERE categoryid=@pcid  
UPDATE thelp_categories SET documentcount=documentcount+1 WHERE categoryid=@pcid   
  END  
    
    
 if(@kindisplay=1 and @kindoccategoryid<>0)    
 BEGIN    
  UPDATE kin_doc_category SET documentcount=documentcount+1 WHERE kincategoryid=@kindoccategoryid     
  
 --更新幼儿园分享文档新的分类的父类统计  
 set @kin_oldpcid=@kindoccategoryid  
 while(@kin_oldpcid<>0)   
 Begin  
 select @kin_oldpcid=parentid from kin_doc_category WHERE kincategoryid=@kin_oldpcid  and [status]=1  
 UPDATE kin_doc_category SET documentcount=documentcount+1 WHERE kincategoryid=@kin_oldpcid   
 END  
 END    
    
 if(@publishdisplay=1 and @pubcategoryid<>0)    
 BEGIN    
  UPDATE pub_doc_category SET documentcount=documentcount+1 WHERE pubcategoryid=@pubcategoryid     
 END    
     
 --DECLARE @name nvarchar(50),@LOGdescription nvarchar(300),@userid1 int    
 --SELECT @name=@docauthor ,@userid1=@userid FROM blog_user t1 INNER JOIN thelp_categories t2 ON t1.userid=t2.userid WHERE t2.categoryid=@categoryid    
 --SET @LOGdescription='<a href="http://blog.zgyey.com/'+cast(@userid as nvarchar(20))+'/index.html" target="_blank">'+@name+'</a>  发表了文档<a href="http://blog.zgyey.com/'+cast(@userid as nvarchar(20))+'/thelp/thelpdocview_'+cast(@@IDENTITY as nvarchar(20))
  
--+'.html" target="_blank"> <<'+@title+'>></a>'    
     
 --if(len(@title)>5)    
 --begin    
 -- set @title=substring(@title,1,5)+'...'    
 --end    
-- SET @LOGdescription='发表文档<a href="http://blog.zgyey.com/'+cast(@userid1 as nvarchar(20))+'/thelp/thelpdocview_'+cast(@@IDENTITY as nvarchar(20))+'.html" target="_blank"> <<'+@title+'>></a>'    
    
 --SET @LOGdescription='发表了教学安排<a href="http://class.zgyey.com/'+cast(@classid as nvarchar(20))+'/classindex/scheduleview_s'+cast(@@IDENTITY as nvarchar(20))+'.html" target="_blank"> <<'+@title+'>></a>'     
    
 declare @docid int    
 set @docid=@@IDENTITY    
    
 --IF(@classdisplay=1 AND @classid<>0)    
 --BEGIN    
 --EXEC class_actionlogs_ADD @userid,@docauthor,@LOGdescription ,'31',@docid,@userid,0,@classid    
   --END    
    
 IF @@ERROR <> 0     
 BEGIN     
  ROLLBACK TRANSACTION    
    RETURN(-1)    
 END    
 ELSE    
 BEGIN    
  COMMIT TRANSACTION    
   --EXEC sys_actionlogs_ADD @userid,@name,@LOGdescription ,'11',@docid,@userid1,0    
    RETURN @docid    
 END    
    
    
    
    
    
    
    
    
    
    
GO
