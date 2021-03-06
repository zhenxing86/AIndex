USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_kmp_kinmastermessage_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
      
      
-- =============================================      
-- Author:  hanbin      
-- Create date: 2009-03-06      
-- Description: 添加园长信箱      
-- =============================================      
CREATE PROCEDURE [dbo].[kweb_kmp_kinmastermessage_Add]      
@siteid int,      
@content ntext,      
@title nvarchar(50),      
@IP nvarchar(50),      
@UserName nvarchar(50),      
@EMail nvarchar(50),      
@ContractPhone nvarchar(50),      
@Address nvarchar(50),    
@userid int=0,  
@parentid int=0,  
@ID int=0      
AS      
BEGIN     
if(@ID>0)  
begin  
 update  kmp..kinmastermessage set Content=@content,userid=@userid,IP=@IP,[Address]=@Address,ContractPhone=@ContractPhone,E_Mail=@EMail  
  where ID=@ID  
end   
 else if(@userid>0)    
 begin    
   INSERT INTO kmp..kinmastermessage (Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,userid,parentid)       
 VALUES (@siteid,@content,@Title,GETDATE(),@IP,0,@UserName,@EMail,@ContractPhone,@Address,@userid,@parentid)      
 end    
 else    
 begin    
   INSERT INTO kmp..kinmastermessage (Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address)       
 VALUES (@siteid,@content,@Title,GETDATE(),@IP,0,@UserName,@EMail,@ContractPhone,@Address)      
 end    
    
 IF @@ERROR<>0      
 BEGIN      
  RETURN 0      
 END      
 ELSE      
 BEGIN      
  RETURN 1      
 END      
END      
      
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_kmp_kinmastermessage_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_kmp_kinmastermessage_Add', @level2type=N'PARAMETER',@level2name=N'@EMail'
GO
