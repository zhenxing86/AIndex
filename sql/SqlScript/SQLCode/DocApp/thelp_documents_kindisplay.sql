USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_kindisplay]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
------------------------------------  
--用途：查询文档时间  
--项目名称：zgyeyblog  
--说明：  
--时间：2010-09-27 22:36:39  
------------------------------------  
CREATE PROCEDURE [dbo].[thelp_documents_kindisplay]  
@docid int,  
@kindisplay int  
AS  
  
DECLARE @oldcategoryid int  
  DECLARE @oldkindoccategoryid int  
  DECLARE @oldkindisplay int  
  DECLARE @oldpubcategoryid int  
  DECLARE @oldpublishdisplay int   
  DECLARE @aprove INT  
    
  SELECT @oldcategoryid=categoryid,@oldkindoccategoryid=kindoccategoryid, @oldkindisplay=kindisplay,@oldpubcategoryid=pubcategoryid,@oldpublishdisplay=publishdisplay,@aprove=aprove  FROM thelp_documents WHERE docid=@docid  
    
  
update  thelp_documents set kindisplay=@kindisplay   
WHERE docid=@docid  
  
UPDATE kin_doc_category SET documentcount=documentcount-1 WHERE kincategoryid=@oldkindoccategoryid  
declare @kin_oldpcid int          
--更新幼儿园分享文档旧分类的父类统计  
     set @kin_oldpcid=@oldkindoccategoryid  
     while(@kin_oldpcid<>0)   
     Begin  
     select @kin_oldpcid=parentid from kin_doc_category WHERE kincategoryid=@kin_oldpcid  and [status]=1  
     UPDATE kin_doc_category SET documentcount=documentcount-1 WHERE kincategoryid=@kin_oldpcid   
     END  
  
GO
