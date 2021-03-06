USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[questions_orderno_asc]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
-- =============================================    
-- Author:     
-- Create date:    
-- Description: 问题排序  
-- =============================================    
create  PROCEDURE [dbo].[questions_orderno_asc]    
@Id int     
AS    
BEGIN    
 BEGIN TRANSACTION    
    
 DECLARE @currentOrderNo int    
   
 SELECT @currentOrderNo=orderno  FROM questions WHERE id=@Id  
    
 DECLARE @NewOrderNo int    
 DECLARE @NewID int    
 SELECT TOP 1 @NewID=id,@NewOrderNo=orderno FROM questions WHERE   orderno>@currentOrderNo ORDER BY orderno ASC    
    
 IF @NewOrderNo IS NULL OR @NewID IS NULL    
 BEGIN    
  COMMIT TRANSACTION    
  RETURN 2 --己经是最高    
 END    
    
 UPDATE questions SET orderno=@NewOrderNo WHERE id=@id    
     
 UPDATE questions SET orderno=@currentOrderNo WHERE id=@NewID    
    
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
