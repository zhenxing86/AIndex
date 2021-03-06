USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_order_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[cms_contentattachs_order_Update]  
 (  
 @siteid int,  
 @categoryid int,    
 @contentattachsid int,    
 @opt int  )  
AS  
BEGIN    
 SET NOCOUNT ON    
  EXEC commonfun.dbo.SetDoInfo @DoUserID = 0, @DoProc = 'cms_contentattachs_order_Update' --设置上下文标志  
  declare @istop bit  
select @istop=istop from cms_contentattachs where contentattachsid=@contentattachsid  
 declare @source_order int, @target_order int, @target_contentattachsid int    
  SELECT @source_order = d1.[orderno],    
     @target_order = d2.[orderno],    
     @target_contentattachsid   = d2.contentattachsid     
  FROM cms_contentattachs d1     
   outer apply    
    (    
     select top(1) [orderno], d2.contentattachsid     
      from cms_contentattachs d2     
      where d2.siteid=@siteid and d2.categoryid=@categoryid And istop=@istop and d2.deletetag = 1
       and d1.contentattachsid <> d2.contentattachsid    
       AND ((@opt > 0 AND d2.[orderno] >= d1.[orderno])    
        or (@opt < 0 AND d2.[orderno] <= d1.[orderno])           
         )            
      order by CASE WHEN @opt > 0 then d2.[orderno] ELSE 9999 END, d2.[orderno] DESC    
    )d2 WHERE d1.contentattachsid = @contentattachsid  
        
 Begin tran       
 BEGIN TRY      
  update cms_contentattachs     
   set [orderno] = ISNULL(@target_order,[orderno])    
   WHERE contentattachsid = @contentattachsid     
  update cms_contentattachs     
   set [orderno] = ISNULL(@source_order,[orderno])    
   WHERE contentattachsid = @target_contentattachsid    
      
  Commit tran                                  
 End Try          
 Begin Catch          
  Rollback tran    
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志           
  Return (-1)           
 end Catch       
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志         
  Return (1)     
    
END 


GO
