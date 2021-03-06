USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_SetTop]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
  
-- =============================================  
-- Author:  hanbin  
-- Create date: 2009-08-08  
-- Description: 文章置顶 或 取消  
-- =============================================  
CREATE PROCEDURE [dbo].[cms_content_SetTop]  
@contentid int,  
@isTop bit  
AS  
BEGIN  
 DECLARE @titlecolor nvarchar(10)  
 Declare @categoryid int  
 SET @titlecolor=''  
  
select @categoryid=categoryid from cms_content where contentid=@contentid  
  
 IF @isTop=1  
 BEGIN  
  SET @titlecolor='red'  
  UPDATE cms_content SET istop=@isTop,titlecolor=@titlecolor WHERE contentid=@contentid  
 END  
 else  
 begin  
  UPDATE cms_content SET istop=@isTop,titlecolor='' WHERE contentid=@contentid  
 end  
   
  
 IF @@ERROR <> 0  
 BEGIN  
  RETURN 0  
 END  
 ELSE  
 BEGIN  
  RETURN 1  
 END  
END  
  
  
  
  
  
GO
