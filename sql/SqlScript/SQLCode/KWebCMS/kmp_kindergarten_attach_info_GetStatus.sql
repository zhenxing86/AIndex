USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_kindergarten_attach_info_GetStatus]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  -- =============================================          
-- Author:  hanbin          
-- Create date: 2009-08-07          
-- Description: 获取站点的使用状态      
-- exec [kmp_kindergarten_attach_info_GetStatus] 24972    
-- =============================================          
Alter PROCEDURE [dbo].[kmp_kindergarten_attach_info_GetStatus]           
@kid int          
AS          
BEGIN          
 DECLARE @status int          
 declare @area int          
      
          
 if(@status=2)          
 begin          
  select @area=city from site where siteid=@kid          
  if(@area=256 or @kid=13286 or @kid=13047 or @kid=13522 or @kid=14161 or @kid=14215 or @kid=14017)          
   set @status=  99          
 end          
          
           
 if(exists (select * from ossapp..kinbaseinfo where isclosenet=1 and kid=@kid))          
 begin          
  set @status=4          
 end          

if exists(select * from ossapp..kinbaseinfo where kid=@kid and ([status]='正常缴费' or [status]='催费中' ) )    
begin    
 set @status=3    
end    

if Exists (Select * From blogapp..permissionsetting Where kid = @kid and ptype = 62)
begin    
 set @status=3    
end    

print @status        

 RETURN Isnull(@status, 0)       
END           
          
 
--          
----select * from basicdata..area where city=          
--          
--declare @kid int          
--set @kid=5440          
--DECLARE @status int          
-- declare @area int          
-- SELECT @status=kinstatus from ZGYEY_OM..kindergarten_attach_info WHERE kid=@kid          
--          
-- if(@status=3)          
-- begin          
--  select @area=city from site where siteid=@kid          
--  if(@area=256)          
--   set @status=  99          
-- end          
-- else if (@status=2)          
-- begin            
--  if(@kid=13286 or @kid=13047 or @kid=13522)          
--   set @status=  99          
-- end          
-- print @status          
--          
--select city from site where siteid=58          
          
          
          
GO
