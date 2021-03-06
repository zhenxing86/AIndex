USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_imgcontent_order_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      xie  
-- Create date: 2013-06-21  
-- Description: 修改专家股东排序  
-- Memo:    
select top 2* from cms_imgcontent where categoryid= 86750 order by [orderno] desc
exec cms_imgcontent_order_Update 86750,754,1   
*/   
CREATE PROCEDURE [dbo].[cms_imgcontent_order_Update]  
 @categoryid int,  
 @contentid int,  
 @opt int  
AS  
BEGIN  
 SET NOCOUNT ON  
 EXEC commonfun.dbo.SetDoInfo @DoUserID = 0, @DoProc = 'cms_imgcontent_order_Update' --设置上下文标志   
 declare @source_order int, @target_order int, @target_contentid int  
 SELECT @source_order = d1.[orderno],  
     @target_order = d2.[orderno],  
     @target_contentid   = d2.contentid   
  FROM cms_imgcontent d1   
   outer apply  
    (  
     select top(1) [orderno], d2.contentid   
      from cms_imgcontent d2   
      where d2.categoryid=@categoryid
       and d1.contentid <> d2.contentid  and d2.deletetag = 1
       AND ((@opt > 0 AND d2.[orderno] >= d1.[orderno])  
        or (@opt < 0 AND d2.[orderno] <= d1.[orderno])         
         )          
      order by CASE WHEN @opt > 0 then d2.[orderno] ELSE 9999 END, d2.[orderno] DESC  
    )d2 WHERE d1.contentid = @contentid and d1.deletetag = 1
      
 Begin tran     
 BEGIN TRY    
  update cms_imgcontent   
   set [orderno] = ISNULL(@target_order,[orderno])  
   WHERE contentid = @contentid   
  update cms_imgcontent   
   set [orderno] = ISNULL(@source_order,[orderno])  
   WHERE contentid = @target_contentid  
    
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_imgcontent_order_Update', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
