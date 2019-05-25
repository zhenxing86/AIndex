USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[newsite_user_LoginInfo]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================  
-- Author:  hanbin  
-- ALTER date: 2009-07-29  
-- Description: 获取用户登录必备信息  
-- =============================================  
CREATE PROCEDURE [dbo].[newsite_user_LoginInfo]  
@userid nvarchar(50)  
AS  
BEGIN  
    DECLARE @usertype int  
    select @usertype=usertype from basicdata..[user] where userid=@userid  
      
    select 0,'',0,0,'',@usertype,0,'',0  
END  
  
GO
