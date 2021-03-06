USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[banner_orderno_desc]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
    
-- =============================================    
-- Author:    
-- Create date:    
-- Description:    
-- =============================================    
create PROCEDURE [dbo].[banner_orderno_desc]    
@id int     
AS    
BEGIN    
 BEGIN TRANSACTION    
    
 DECLARE @currentOrderNo int    
 DECLARE @currentsiteid int    
 SELECT @currentOrderNo=orderno,@currentsiteid=siteid FROM Site_Banner WHERE id=@id    
    
 DECLARE @NewOrderNo int    
 DECLARE @NewID int    
 SELECT TOP 1 @NewID=id,@NewOrderNo=orderno FROM Site_Banner WHERE siteid=@currentsiteid AND orderno<@currentOrderNo ORDER BY orderno DESC    
 
    
 IF @NewOrderNo IS NULL OR @NewID IS NULL    
 BEGIN    
  COMMIT TRANSACTION    
  RETURN 2 --己经是最低    
 END    
    
 UPDATE Site_Banner SET orderno=@NewOrderNo WHERE id=@id    
     
 UPDATE Site_Banner SET orderno=@currentOrderNo WHERE id=@NewID    
    
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
