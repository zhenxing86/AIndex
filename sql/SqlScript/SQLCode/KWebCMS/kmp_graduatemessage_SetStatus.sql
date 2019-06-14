USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_graduatemessage_SetStatus]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Author:  xie  
-- Create date: 2013-11-04  
-- Description: 留言审核  
--paras: @status: 0:设置，1：取消
-- =============================================  
CREATE PROCEDURE [dbo].[kmp_graduatemessage_SetStatus]  
@id int, 
@status int = 1
AS  
declare @state int= 1
BEGIN  
 if @status=1  set @state = 0
 UPDATE kmp..GraduateMessage SET Status=@state WHERE id=@id  
   
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
