USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[buginfo_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- Author:      xie      
-- Create date: 2013-11-28            
-- Description:             
-- Memo:              
exec buginfo_Update 1,10,12511,'帼英',6,-1,'2013-11-27 10:00:00','2013-11-28 23:59:59'            
*/            
CREATE PROCEDURE [dbo].[buginfo_Update]  
@bugid int,          
@bugdes varchar(max),    
@kid int,   
@bugtype int,   
@enddate datetime,       
@douserid int,     
@userid int,
@smallbugtype int=0,
@reasonlevel int=0
 AS             
begin            
    update buginfo
     set bug_des=@bugdes,kid=@kid,bug_type=@bugtype,
     enddate=@enddate,douserid=@douserid,update_userid=@userid
     ,small_bug_type = @smallbugtype,reason_level = @reasonlevel
    where bugid=@bugid
  
if @@ERROR>0  
 return -1  
else return 1   
  
end       
  
GO
