USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[buginfo_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- Author:      xie      
-- Create date: 2013-11-28            
-- Description:             
-- Memo:              
exec buginfo_GetModel 1           
*/            
CREATE PROCEDURE [dbo].[buginfo_GetModel]             
@bugid int       
 AS             
begin            
      
 select 1,b.bugid,b.userid,u.name,b.applydate,b.bug_des,b.kid,k.kname,b.bug_type,b.enddate,b.process,b.dodate,      
 b.doresult,b.douserid,u2.name,b.serialno,b.small_bug_type,b.reason_level
  from ossapp..buginfo b      
   left join basicdata..kindergarten k on k.kid=b.kid      
   left join ossapp..users u on b.userid=u.ID and u.deletetag=1      
   left join ossapp..users u2 on b.douserid=u2.ID and u2.deletetag=1      
  where b.bugid=@bugid and b.deletetag=1         
     
end 
GO
