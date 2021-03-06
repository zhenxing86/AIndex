USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_ADD]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-06-21  
-- Description: 新增班级  
-- Memo:   
select * from class where kid = 12511 and grade = 35 order by [order]  
EXEC class_ADD 23115,'YOYO',35,'YOYO'  
select * from class where kid = 12511 and grade = 35 order by [order]   
*/  
CREATE PROCEDURE [dbo].[class_ADD]  
 @kid int,  
 @cname nvarchar(20),  
 @grade int,  
 @sname nvarchar(20),  
 @douserid int =0  
AS  
BEGIN  
 SET NOCOUNT ON   
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = 'class_ADD' --设置上下文标志
  DECLARE @returnvalue int, @order int  
 IF EXISTS(SELECT 1 FROM class where kid = @kid AND cname = @cname  collate Chinese_PRC_CS_AI and deletetag = 1)  
 BEGIN  
  RETURN (-2)  
 END  
 ELSE  
 BEGIN  
  Begin tran     
  BEGIN TRY     
   select @order = max([order]) + 1    
    from class   
    where kid = @kid   
     and grade = @grade  
  
   INSERT INTO class  
     (kid, cname, grade, [order], deletetag, sname, actiondate, iscurrent)  
   VALUES  
     (@kid, @cname, @grade, ISNULL(@order,1), 1, @sname, GETDATE(), 1)  
     
   set @returnvalue=ident_current('class')   
   
    
   Commit tran                                
  End Try        
  Begin Catch        
   Rollback tran   
   EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志    
   Return (-1)         
  end Catch    
   exec ReportApp..InitializeHomeBookPlantBook @returnvalue  
   EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志  
   RETURN  @returnvalue    
 END  
END  
GO
