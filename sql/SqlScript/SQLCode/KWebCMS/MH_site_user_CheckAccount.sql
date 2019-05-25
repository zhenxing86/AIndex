USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_user_CheckAccount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
-- =============================================  
-- Author:  hanbin  
-- ALTER date: 2009-03-30  
-- Description: CheckAccount(-1:帐号不可用,0:帐号可用,URL不可用，1:帐号可用)  
-- =============================================  
CREATE PROCEDURE [dbo].[MH_site_user_CheckAccount]  
@account nvarchar(30)  
AS  
BEGIN  

 --IF EXISTS (SELECT account FROM site_user WHERE account=@account)  
 --BEGIN  
 -- RETURN -1  
 --END   
 --ELSE
 
 IF EXISTS (SELECT account FROM basicdata..[User] WHERE account=@account AND deletetag=1)  
 BEGIN  
  RETURN -1  
 END  
 ELSE  
 BEGIN  
  RETURN 1  
 END  
END  
  
  
  
  
  
GO
