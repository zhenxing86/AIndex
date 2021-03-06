USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kinexpiretimestatus]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
-- =============================================        
-- Author:           
-- Create date: 2014-07-19        
-- Description: 获取站点状态,网站到期了，短信平台应该禁止使用。客户无法进入短信平台        
-- =============================================        
CREATE PROCEDURE [dbo].[kinexpiretimestatus]            
@kid int            
AS            
            
BEGIN           
 DECLARE @status int=0 ,@end_date datetime,@statusflag nvarchar(50)               
 declare @area int                
 SELECT @status=kinstatus from ZGYEY_OM..kindergarten_attach_info WHERE kid=@kid                
                
 --if(@status=2)                
 --begin                
 -- select @area=city from site where siteid=@kid                
 -- if(@area=256 or @kid=13286 or @kid=13047 or @kid=13522 or @kid=14161 or @kid=14215 or @kid=14017)                
 --  set @status=  99                
 --end                
        
 select @end_date=expiretime,@statusflag=[status] from ossapp..kinbaseinfo where kid=@kid and deletetag=1        
--if(@status=2 or @status=4 or @status=99 or @status=0)       
--if(@end_date>GETDATE() )   
if(@statusflag<>'欠费')       
begin        
return 1        
end        
else        
begin        
return -1        
end        
             
END 
GO
