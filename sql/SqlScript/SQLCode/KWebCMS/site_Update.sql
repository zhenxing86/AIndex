USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
--=============================================  
-- Author:  hanbin  
-- alter date: 2009-01-13  
-- Description: 站点更新  
-- =============================================  
CREATE PROCEDURE [dbo].[site_Update]  
@siteid int,  
@name nvarchar(100),  
@description nvarchar(600),  
@address nvarchar(500),  
@sitedns nvarchar(200),  
@provice int,  
@city int,  
@contractname nvarchar(60),  
@QQ nvarchar(40),  
@phone nvarchar(60),  
@Email nvarchar(100),  
@shotname nvarchar(1200),  
@dict nvarchar(60),  
@ktype nvarchar(30),  
@klevel nvarchar(30),  
@photowater nvarchar(50)  
AS  
BEGIN  
     
 BEGIN TRANSACTION  
    
  
 UPDATE [site]   
 SET [name] = @name,[description] = @description,[address] = @address,[sitedns] = @sitedns,  
 [provice] = @provice,[contractname] = @contractname,[QQ] = @QQ,[phone] = @phone,  
 [Email]=@Email,dict=@dict,ktype=@ktype,klevel=@klevel,photowatermark=@photowater  
 WHERE [siteid] = @siteid  
   
 UPDATE basicdata..kindergarten SET  [address]=@address,privince=@provice,telephone=@phone,qq=@QQ  
  WHERE kid = @siteid  
   if(@shotname='null')
   begin
    UPDATE site_config  
 SET  [linkman]=@contractname  
 WHERE [siteid]=@siteid  
   end
   else
   begin
    UPDATE site_config  
 SET  shortname=@shotname,[linkman]=@contractname  
 WHERE [siteid]=@siteid  
   end

   
 exec [kweb_site_RefreshIndexPage] @siteid  
    
 IF NOT EXISTS (SELECT * FROM site_domain WHERE siteid=@siteid)  
 BEGIN  
  INSERT INTO site_domain VALUES(@siteid,@sitedns)  
 END  
     
  
 IF @@ERROR <> 0   
 BEGIN   
  ROLLBACK TRANSACTION  
    RETURN(-1)  
 END  
 ELSE  
 BEGIN  
  COMMIT TRANSACTION  
    RETURN (1)  
 END  
END  
  
  
  
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_Update', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_Update', @level2type=N'PARAMETER',@level2name=N'@Email'
GO
