USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_graduatemessage_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  hanbin  
-- Create date: 2009-11-30  
-- Description: 添加毕业留言  
-- =============================================  
CREATE PROCEDURE [dbo].[kmp_graduatemessage_Add]  
@siteid int,  
@content ntext,  
@Title nvarchar(50),  
@IP nvarchar(50),  
@UserName nvarchar(50),  
@Email nvarchar(50),  
@ContractPhone nvarchar(50),  
@Address nvarchar(50),  
@categorytype int,  
@parentid int,  
@userid int  
AS  
BEGIN  
 DECLARE @Status int  
 SET @Status=0  
 INSERT INTO kmp..GraduateMessage (Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid,userid)  
 VALUES (@siteid,@content,@Title,GETDATE(),@IP,@Status,@UserName,@EMail,@ContractPhone,@Address,@categorytype,@parentid,@userid)  
  
  update kmp..GraduateMessage set userid = @userid where kid =@siteid and id = @parentid and userid=0
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_graduatemessage_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_graduatemessage_Add', @level2type=N'PARAMETER',@level2name=N'@Email'
GO
