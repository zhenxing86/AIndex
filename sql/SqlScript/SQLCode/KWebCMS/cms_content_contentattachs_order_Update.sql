USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_contentattachs_order_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--修改每周食谱(MZSP)排序
create proc [dbo].[cms_content_contentattachs_order_Update]
 (  
 @siteid int,  
 @categoryid int,    
 @contentid int,    
 @opt int  )  
AS  
BEGIN    
 SET NOCOUNT ON    
  EXEC commonfun.dbo.SetDoInfo @DoUserID = 0, @DoProc = 'cms_content_contentattachs_order_Update' --设置上下文标志  
  declare @istop bit  
select @istop=isnull(istop,'0') from cms_content where contentid=@contentid  
 declare @source_order int, @target_order int, @target_contentid int    
  SELECT @source_order = d1.[orderno],    
     @target_order = d2.[orderno],    
     @target_contentid   = d2.contentid     
  FROM(select siteid,orderno,contentid,categoryid,istop from cms_content   where siteid=@siteid and categoryid=@categoryid
 
   ) d1     
   outer apply    
    (    
     select top(1) [orderno], d2.contentid     
      from (select siteid,orderno,contentid,categoryid,istop from cms_content  where siteid=@siteid and categoryid=@categoryid
     
      ) d2     
      where d2.siteid=@siteid and d2.categoryid=@categoryid And   ISNULL(istop,'0')=@istop
       and d1.contentid <> d2.contentid    
       AND ((@opt > 0 AND d2.[orderno] >= d1.[orderno])    
        or (@opt < 0 AND d2.[orderno] <= d1.[orderno])           
         )            
      order by CASE WHEN @opt > 0 then d2.[orderno] ELSE 9999 END, d2.[orderno] DESC    
    )d2 WHERE d1.contentid = @contentid  
        
 Begin tran       
 BEGIN TRY   

update cms_content    
   set [orderno] = ISNULL(@target_order,[orderno])    
   WHERE contentid = @contentid  
  update cms_content     
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
