use mcapp
go
/*  
-- Author:      xie  
-- Create date: 2014-11-27 
-- Description: 体温偏高确认 
-- Memo:   
mc_unusual_Setting 0
*/  
create PROCEDURE [dbo].[mc_unusual_Setting]   
 @id int
as    
BEGIN   
 SET NOCOUNT ON  
 
 update s   
  set ftype = 2  
  from stu_mc_day s  
  where ID = @id 
   
END  