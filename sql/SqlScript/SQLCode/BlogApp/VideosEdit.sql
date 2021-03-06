USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[VideosEdit]    Script Date: 2014/11/25 11:50:43 ******/
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
CREATE PROC [dbo].[VideosEdit]  
 @Type int, --0新增，10 修改Title，11修改Categoryid， 2删除  
 @VideoID bigint = null,  
 @Categoryid bigint = null,  
 @Title varchar(50) = null,  
 @CoverPic varchar(200) = null,  
 @PicNet int = null,  
 @VideoUrl varchar(200) = null,  
 @VideoNet int = null  
AS  
BEGIN  
 SET NOCOUNT ON  
 DECLARE @Msg varchar(50) = '操作失败'    
 Begin tran     
 BEGIN TRY  
  IF @type = 0  
  begin  
   INSERT INTO dbo.Videos(Categoriesid,Title,CoverPic,PicUpdateTime,PicNet,VideoUrl,VideoUpdateTime,VideoNet)    
    SELECT @Categoryid,@Title,@CoverPic,GETDATE(),@PicNet,@VideoUrl,GETDATE(),@VideoNet  
   SELECT @Categoryid =  ident_current('Videos') , @Msg = '新增成功'    
  end  
  ELSE IF @type = 10  
  begin  
   UPDATE Videos  
    SET title = @title  
    WHERE VideoID = @VideoID  
   SET @Msg = '更新成功'   
  end  
  ELSE IF @type = 11  
  begin  
   UPDATE Videos  
    SET Categoriesid = @Categoryid  
    WHERE VideoID = @VideoID  
   SET @Msg = '更新成功'   
  end  
  ELSE IF @type = 2  
  begin  
   UPDATE Videos  
    SET DeleteTag = 0  
    WHERE VideoID = @VideoID  
   SET @Msg = '删除成功'    
  end  
  Commit tran                                
 End Try        
 Begin Catch       
  SELECT @Categoryid = -1, @Msg = error_message()  
  Rollback tran        
 end Catch    
Finish:  
 SELECT @VideoID VideoID, @Msg Msg  
  
END  

GO
