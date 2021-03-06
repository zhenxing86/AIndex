USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[banner_orderno_asc]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
    
-- =============================================    
-- Author:     
-- Create date:    
-- Description: 手机banner排序  
-- =============================================    
CREATE PROCEDURE [dbo].[banner_orderno_asc]    
@Id int     
AS    
BEGIN    
 BEGIN TRANSACTION    
    
 DECLARE @currentOrderNo int    
 DECLARE @currentsiteid int    
 SELECT @currentOrderNo=orderno,@currentsiteid=siteid FROM site_banner WHERE id=@Id  
    
 DECLARE @NewOrderNo int    
 DECLARE @NewID int    
 SELECT TOP 1 @NewID=id,@NewOrderNo=orderno FROM site_banner WHERE siteid=@currentsiteid AND orderno>@currentOrderNo ORDER BY orderno ASC    
    
 IF @NewOrderNo IS NULL OR @NewID IS NULL    
 BEGIN    
  COMMIT TRANSACTION    
  RETURN 2 --己经是最高    
 END    
    
 UPDATE site_banner SET orderno=@NewOrderNo WHERE id=@id    
     
 UPDATE site_banner SET orderno=@currentOrderNo WHERE id=@NewID    
    
 IF @@ERROR <> 0     
 BEGIN     
  ROLLBACK TRANSACTION    
    RETURN(-1)    
 END    
 ELSE    
 BEGIN    
  COMMIT TRANSACTION    
    RETURN 1    
 END    
END    
    
GO
