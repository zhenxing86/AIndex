USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[UpdateSiteUrl]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-02-18
-- Description:	更新任务盒子状态
-- Memo:
exec BasicData..UpdateSiteUrl @Kid = @Kid, @@url = @url	
*/
CREATE PROCEDURE [dbo].[UpdateSiteUrl]  
 @Kid int,  
 @url nvarchar(100),  
 @themeid int = null   
AS  
BEGIN  
 SET NOCOUNT ON;   
 if Exists (Select * From KWebCMS.dbo.SiteUrlFilter Where sitedns + '.zgyey.com' = @url Or sitedns = @url)
 begin 
   SELECT  0    
   return    
 END  

 IF exists(  
  select *   
   from basicdata..kindergarten k   
    inner join KWebCMS..site s   
    on k.kid = s.siteid and k.deletetag = 1   
    where s.sitedns = @url and k.kid <> @Kid)      
 BEGIN  
  SELECT  0    
  return    
  END  
 Begin tran     
 BEGIN TRY    
   
  exec [KWebCMS].dbo.[site_domain_ReSet] @Kid,@url  
  --UPDATE KWebCMS..site  
  -- SET sitedns = @url  
  -- WHERE siteid = @kid        
        
  --if NOT exists(select * from KWebCMS..site_domain where siteid = @kid)          
  -- INSERT INTO KWebCMS..site_domain(siteid,domain) VALUES(@Kid, @url)  
  --ELSE   
  -- UPDATE top(1) KWebCMS..site_domain SET domain = @url WHERE siteid = @kid      
      
    UPDATE KWebCMS.dbo.site_config  
     SET theme = @themeid        
   WHERE siteid = @Kid  
                
  UPDATE KWebCMS.dbo.site_themesetting    
     SET themeid = @themeid        
   WHERE siteid = @Kid  
      
    update ossapp..kinbaseinfo set netaddress=@url where kid=@Kid  
      
    exec BasicData..BoxStatusEdit @Kid = @Kid, @StatusNo = 1  
  Commit tran                                
 End Try        
 Begin Catch        
  Rollback tran     
  SELECT  0    
  return      
 end Catch    
 SELECT 1  
END  

GO
