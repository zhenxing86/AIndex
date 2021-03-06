USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[HonoursEdit]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-10-24  
-- Description:   
-- Memo:    
*/  
CREATE PROC [dbo].[HonoursEdit]   
 @hid bigint = null,  
 @userid int = null,  
 @kid int = null,  
 @hName varchar(100) = null,  
 @hOwner varchar(100) = null,  
 @hRank varchar(50) = null,  
 @hGrade varchar(50) = null,  
 @hOrgan varchar(100) = null,  
 @hTime varchar(50) = null,  
 @hType varchar(50) = null,  
 @hUnit varchar(100) = null,  
 @hTeacher varchar(50) = null,  
 @hPic varchar(200) = null,  
 @rylei varchar(50) = null,  
 @type int,--0 新增 1修改 2删除  
 @DoUserID int = 0  
AS  
BEGIN  
 SET NOCOUNT ON  
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'HonoursEdit' --设置上下文标志  
 DECLARE @Msg varchar(50) = '操作失败', @Status int  
 Begin tran     
 BEGIN TRY  
  IF @type = 0  
  begin  
   INSERT INTO BlogApp..Honours(userid, kid, hName, hOwner, hRank, hGrade, hOrgan, hTime, hType, hUnit, hTeacher, hPic, rylei)  
   SELECT @userid, @kid, @hName, @hOwner, @hRank, @hGrade, @hOrgan, @hTime, @hType, @hUnit, @hTeacher, @hPic, @rylei  
   SELECT @hid =  ident_current('Honours') , @Msg = '新增成功'    
  end  
  ELSE IF @type = 1  
  begin  
   UPDATE Honours  
    SET hName = @hName,   
      hOwner = @hOwner,   
      hRank = @hRank,   
      hGrade = @hGrade,   
      hOrgan = @hOrgan,   
      hTime = @hTime,   
      hType = @hType,   
      hUnit = @hUnit,   
      hTeacher = @hTeacher,   
      hPic = @hPic,   
      rylei = @rylei  
    WHERE hid = @hid  
   SET @Msg = '更新成功'   
  end  
  ELSE IF @type = 2  
  begin  
   DELETE Honours  
    WHERE hid = @hid  
   SET @Msg = '删除成功'    
  end  
  Commit tran                                
 End Try        
 Begin Catch    
  SELECT @hid = -1, @Msg = error_message()     
  Rollback tran        
 end Catch    
Finish:  
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志    
 SELECT @hid ID, @Msg Msg  
END  
GO
