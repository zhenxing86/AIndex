USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[bug_detial_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*          
-- Author:      xie    
-- Create date: 2013-11-28          
-- Description:           
-- Memo:            
exec bug_detial_GetModel 2,6,2        
*/      
CREATE PROCEDURE [dbo].[bug_detial_GetModel]             
@id int     
 AS           
begin    
   
  select 1,bd.bugid,bd.douserid,u.name username,bd.dodate,bd.suggestion,ftype,bd.id
   from  ossapp..bug_detial bd          
    left join ossapp..users u on bd.douserid=u.ID and u.deletetag=1    
    where bd.id=@id 
  
end     
GO
