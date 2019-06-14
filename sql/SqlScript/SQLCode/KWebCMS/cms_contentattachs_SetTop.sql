USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_SetTop]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
-- =============================================  
-- Author:  lx  
-- Create date: 2011-4-12  
-- Description: 附近置顶或取消  
-- =============================================  
CREATE PROCEDURE [dbo].[cms_contentattachs_SetTop]  
@contentattachsid int,  
@istop bit  
AS  
BEGIN  
 UPDATE cms_contentattachs SET istop=@istop  WHERE contentattachsid=@contentattachsid  
   
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
