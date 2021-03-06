USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Video_CategoriesEdit]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date:   
-- Description:   
-- Memo:   
*/  
CREATE PROC [dbo].[Video_CategoriesEdit]  
 @Type int,  
 @Categoryid bigint = null,  
 @title varchar(50) = null,  
 @is_public int = null,  
 @userid int = null  
AS  
BEGIN  
 SET NOCOUNT ON  
 DECLARE @Msg varchar(50) = '操作失败'    
 Begin tran     
 BEGIN TRY  
  IF @type = 0  
  begin  
   INSERT INTO dbo.Video_Categories(userid,Title,Is_Public)    
    SELECT @userid, @title, @is_public  
   SELECT @Categoryid =  ident_current('Video_Categories') , @Msg = '新增成功'    
  end  
  ELSE IF @type = 1  
  begin  
   UPDATE Video_Categories  
    SET title = @title,   
      is_public = @is_public  
    WHERE Categoriesid = @Categoryid  
   SET @Msg = '更新成功'   
  end  
  ELSE IF @type = 2  
  begin  
   UPDATE Video_Categories  
    SET DeleteTag = 0  
    WHERE Categoriesid = @Categoryid  
   SET @Msg = '删除成功'    
  end  
  Commit tran                                
 End Try        
 Begin Catch       
  SELECT @Categoryid = -1, @Msg = error_message()  
  Rollback tran        
 end Catch    
Finish:  
 SELECT @Categoryid Categoriesid, @Msg Msg  
  
END  

GO
