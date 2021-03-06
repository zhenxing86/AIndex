USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_baseinfo_Update]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      Master谭        
-- Create date: 2013-08-01        
-- Description:  修改一条用户详细信息记录       
-- Memo:        
*/       
CREATE PROCEDURE [dbo].[user_baseinfo_Update]      
 @userid int,      
 @name nvarchar(20) = null,      
 @nickname nvarchar(20) = null,      
 @birthday datetime = null,      
 @gender int = null,      
 @nation int = null,      
 @mobile char(11) = null,      
 @email nvarchar(100) = null,      
 @address nvarchar(100) = null,      
 @enrollmentdate datetime = null ,    
 @grade int=null     
AS      
BEGIN      
 SET NOCOUNT ON        
 Begin tran         
 BEGIN TRY           
  UPDATE [user]      
   SET name = ISNULL(@name,name),      
     nickname = ISNULL(@nickname,nickname),      
     birthday = ISNULL(@birthday,birthday),      
     gender = ISNULL(@gender,gender),      
     nation = ISNULL(@nation,nation),      
     mobile = ISNULL(@mobile,mobile),      
     email = ISNULL(@email,email),      
     address = ISNULL(@address,address),     
      jzxxgrade = ISNULL(@grade,jzxxgrade),       
     enrollmentdate = ISNULL(@enrollmentdate,enrollmentdate)      
   WHERE userid = @userid      
      
  Commit tran                                    
 End Try            
 Begin Catch            
  Rollback tran         
  Return -1             
 end Catch           
  RETURN 1      
END 
GO
