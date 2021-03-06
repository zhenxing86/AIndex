USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_Update]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：修改文档  
--项目名称：ZGYEYBLOG  
--说明：  
--时间：2008-10-03 21:30:07  
--作者：along  
------------------------------------  
CREATE PROCEDURE [dbo].[thelp_documents_Update]  
@docid int,  
@categoryid int,  
@title nvarchar(100),  
@description nvarchar(200),  
@body ntext,  
@classdisplay int,  
@kindisplay int,  
@publishdisplay int,  
@classid int,  
@kindoccategoryid int,  
@pubcategoryid int  
 AS   
 SET TRANSACTION ISOLATION LEVEL READ COMMITTED  
 BEGIN TRANSACTION  
  
  DECLARE @oldcategoryid int  
  DECLARE @oldkindoccategoryid int  
  DECLARE @oldkindisplay int  
  DECLARE @oldpubcategoryid int  
  DECLARE @oldpublishdisplay int   
  DECLARE @aprove INT  
    
  SELECT @oldcategoryid=categoryid,@oldkindoccategoryid=kindoccategoryid, @oldkindisplay=kindisplay,@oldpubcategoryid=pubcategoryid,@oldpublishdisplay=publishdisplay,@aprove=aprove  FROM thelp_documents WHERE docid=@docid  
  IF(@categoryid<>@oldcategoryid)  
  BEGIN  
   UPDATE thelp_categories SET documentcount=documentcount-1 WHERE categoryid=@oldcategoryid  
   UPDATE thelp_categories SET documentcount=documentcount+1 WHERE categoryid=@categoryid  
  
  
declare @oldpcid int,@newpcid int,@kin_oldpcid int,@kin_newpcid int   
select @oldpcid=parentid from thelp_categories WHERE categoryid=@oldcategoryid    
UPDATE thelp_categories SET documentcount=documentcount-1 WHERE categoryid=@oldpcid  
--更新旧分类的父类统计  
 while(@oldpcid<>0)   
 Begin  
select @oldpcid=parentid from thelp_categories WHERE categoryid=@oldpcid  and [status]=1  
UPDATE thelp_categories SET documentcount=documentcount-1 WHERE categoryid=@oldpcid   
  END  
--更新新的分类的父类统计  
select @newpcid=parentid from thelp_categories WHERE categoryid=@categoryid   
 while(@newpcid<>0)   
 Begin  
select @newpcid=parentid from thelp_categories WHERE categoryid=@newpcid  and [status]=1  
UPDATE thelp_categories SET documentcount=documentcount+1 WHERE categoryid=@newpcid   
  END  
  
  
declare @pcid int   
select @pcid=parentid from thelp_categories WHERE categoryid=@categoryid  
UPDATE thelp_categories SET documentcount=documentcount+1 WHERE categoryid=@pcid  
  
  END  
   
  IF(@kindisplay=1)  
  BEGIN  
    
   IF(@oldkindisplay=1)  
   BEGIN  
      
    IF(@oldkindoccategoryid<>@kindoccategoryid)  
    BEGIN  
       
     UPDATE kin_doc_category SET documentcount=documentcount-1 WHERE kincategoryid=@oldkindoccategoryid  
     UPDATE kin_doc_category SET documentcount=documentcount+1 WHERE kincategoryid=@kindoccategoryid  
     --更新幼儿园分享文档旧分类的父类统计  
     set @kin_oldpcid=@oldkindoccategoryid  
     while(@kin_oldpcid<>0)   
     Begin  
     select @kin_oldpcid=parentid from kin_doc_category WHERE kincategoryid=@kin_oldpcid  and [status]=1  
     UPDATE kin_doc_category SET documentcount=documentcount-1 WHERE kincategoryid=@kin_oldpcid   
     END  
     --更新幼儿园分享文档新的分类的父类统计  
     set @kin_oldpcid=@kindoccategoryid  
     while(@kin_oldpcid<>0)   
     Begin  
     select @kin_oldpcid=parentid from kin_doc_category WHERE kincategoryid=@kin_oldpcid  and [status]=1  
     UPDATE kin_doc_category SET documentcount=documentcount+1 WHERE kincategoryid=@kin_oldpcid   
     END  
       
    END   
       
   END  
   ELSE  
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
  END  
  ELSE  
  BEGIN  
   IF(@oldkindisplay=1)  
   BEGIN  
     UPDATE kin_doc_category SET documentcount=documentcount-1 WHERE kincategoryid=@oldkindoccategoryid   
     --更新幼儿园分享文档旧分类的父类统计  
     set @kin_oldpcid=@oldkindoccategoryid  
     while(@kin_oldpcid<>0)   
     Begin  
     select @kin_oldpcid=parentid from kin_doc_category WHERE kincategoryid=@kin_oldpcid  and [status]=1  
     UPDATE kin_doc_category SET documentcount=documentcount-1 WHERE kincategoryid=@kin_oldpcid   
     END        
   END  
  END  
  
  IF(@publishdisplay=1 and @aprove=1)  
  BEGIN  
   IF(@oldpublishdisplay=1)  
   BEGIN  
    IF(@oldpubcategoryid<>@pubcategoryid)  
    BEGIN  
     UPDATE pub_doc_category SET documentcount=documentcount-1 WHERE pubcategoryid=@oldpubcategoryid  
     UPDATE pub_doc_category SET documentcount=documentcount+1 WHERE pubcategoryid=@pubcategoryid  
    END     
   END  
   ELSE  
   BEGIN  
    UPDATE pub_doc_category SET documentcount=documentcount+1 WHERE pubcategoryid=@pubcategoryid  
   END  
  END  
  ELSE  
  BEGIN  
   IF(@oldpublishdisplay=1 and @aprove=1)  
   BEGIN  
     UPDATE pub_doc_category SET documentcount=documentcount-1 WHERE pubcategoryid=@oldpubcategoryid         
   END  
  END  
  
  UPDATE thelp_documents SET   
  [categoryid] = @categoryid,[title] = @title,[description] = @description,[body] = @body,[classdisplay] = @classdisplay,[kindisplay] = @kindisplay,[publishdisplay] = @publishdisplay,[classid]=@classid,[kindoccategoryid]=@kindoccategoryid,[pubcategoryid]=
@pubcategoryid  
  WHERE docid=@docid   
  
 IF @@ERROR <> 0   
 BEGIN   
  ROLLBACK TRANSACTION    
    RETURN(-1)  
 END  
 ELSE  
 BEGIN   
  COMMIT TRANSACTION  
    RETURN (1)  
 END  
GO
