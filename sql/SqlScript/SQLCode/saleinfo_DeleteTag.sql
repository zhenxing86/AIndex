USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[saleinfo_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                
-- Author:      xie            
-- Create date: 2014-05-17               
-- Description:                 
-- Memo:                        
exec [saleinfo_Del] 1,134               
*/                
CREATE PROCEDURE [dbo].[saleinfo_DeleteTag]            
@saleid int        
,@douserid int                           
 AS                 
begin               
        
 update saleinfo set deletetag=0 ,reuserid=@douserid,udate=GETDATE()       
  where saleid=@saleid      
             
end 
GO
