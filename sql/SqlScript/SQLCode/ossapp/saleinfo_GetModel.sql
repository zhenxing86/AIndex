USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[saleinfo_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                   
-- Author:      xie              
-- Create date: 2014-05-17                 
-- Description:                   
-- Memo:                          
exec saleinfo_GetModel 12511,1,10,'',-3,'2013-1-2','2014-3-2'                  
*/                  
CREATE PROCEDURE [dbo].[saleinfo_GetModel]              
@saleid int                             
 AS                   
begin                 
          
 select 1,s.saleid,s.userid,s.reuserid,s.kid,s.kname,s.ytj_cnt,s.gun_cnt,    
 s.pb_cnt,s.card_cnt,s.js_date,s.js_style,s.js_cnt,u.name username,    
 u1.name dousername,card_equ_cnt,js_cnt_kk,js_status,js_status_kk,price,totlemoney,term,salefrom,s.remark         
 from saleinfo s        
  left join ossapp..users u         
   on s.userid=u.id        
  left join ossapp..users u1         
   on s.reuserid=u1.id           
  where saleid =@saleid and s.deletetag =1          
               
end 
GO
