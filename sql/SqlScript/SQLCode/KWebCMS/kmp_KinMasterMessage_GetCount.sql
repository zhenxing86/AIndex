USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_KinMasterMessage_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- memo:  exec kmp_KinMasterMessage_GetCount 12511,0      
CREATE PROCEDURE [dbo].[kmp_KinMasterMessage_GetCount]      
@kid int,      
@flag int=0  --0:网站后台，1：网站前台     
,@userid int =0     
AS      
BEGIN      
    DECLARE @count int      
          
    if @flag=0      
  SELECT @count=count(*) FROM kmp..KinMasterMessage      
  WHERE kid=@kid AND (status=0 or status=1 OR status is null)       
  and (ParentId=0 or ParentId is null)      
 else      
 begin    
 if(@userid>0)    
 begin    
   
 SELECT @count=count(*) FROM kmp..KinMasterMessage      
   WHERE kid=@kid   and (ParentId=0 or ParentId is null)  and userid=@userid    
 end    
 else    
 begin    
 SELECT @count=count(*) FROM kmp..KinMasterMessage      
   WHERE kid=@kid AND status=1 and (ParentId=0 or ParentId is null)     
   end     
 end    
    
    RETURN @count      
END   
GO
