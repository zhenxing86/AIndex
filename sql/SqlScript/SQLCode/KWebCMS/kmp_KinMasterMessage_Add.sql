USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_KinMasterMessage_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================    
-- Author:  xie    
-- Create date: 2013-11-01    
-- Description: 添加园长信箱回复    
/*  
memo:   
exec kmp_KinMasterMessage_Add 123,'很好，继续努力。',16535  
*/  
-- =============================================    
CREATE PROCEDURE [dbo].[kmp_KinMasterMessage_Add]    
@kid int,    
@content ntext,    
@Title nvarchar(50),    
@IP nvarchar(50),    
@UserName nvarchar(50),    
@Email nvarchar(50),    
@ContractPhone nvarchar(50),    
@Address nvarchar(50),    
@parentid int,    
@userid int    
AS    
BEGIN   
set @ContractPhone=ISNULL(@ContractPhone,'') 
 DECLARE @Status int    
 SET @Status=0    
 INSERT INTO kmp..KinMasterMessage (Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,parentid,userid)    
 VALUES (@kid,@content,@Title,GETDATE(),@IP,@Status,@UserName,@EMail,@ContractPhone,@Address,@parentid,@userid)    
    
 IF @@ERROR<>0    
 BEGIN    
  RETURN 0    
 END    
 ELSE    
 BEGIN    
  RETURN @@identity    
 END    
END    
    
    
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_KinMasterMessage_Add', @level2type=N'PARAMETER',@level2name=N'@Email'
GO
