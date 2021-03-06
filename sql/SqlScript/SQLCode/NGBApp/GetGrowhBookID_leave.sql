USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetGrowhBookID_leave]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie   
-- Create date: 2014-05-13     
-- Description: 获取离园小朋友成长档案
ReturnValue：-1：没有成长档案，0：旧版成长档案，>0：新版成长档案    
-- Memo:        
exec [GetGrowhBookID_leave] 295765      
  SELECT * FROM BASICDATA..[USER] WHERE KID = 12511          
select * from basicdata..class where kid=12511      

*/      
CREATE PROC [dbo].[GetGrowhBookID_leave]      
 @userid int 
          
AS        
BEGIN        
          
 SET NOCOUNT ON        
 declare @gbid int 
 
 select  @gbid = max(gbid)
  from GrowthBook         
  where userid = @userid 
  group by  userid    
         
 IF @gbid IS NOT NULL        
	RETURN @gbid        
 ELSE        
 BEGIN         
	  if exists (select 1 from gbapp..GrowthBook 
	   where userid = @userid  
	   )   
	   begin
		 RETURN 0 
	   end
	   
	   RETURN -1   
 END    
  
         
END        
  
  
GO
