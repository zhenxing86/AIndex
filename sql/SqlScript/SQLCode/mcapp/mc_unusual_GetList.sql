use mcapp
go
/*    
-- Author:      xie    
-- Create date: 2014-11-27  
-- Description:  体温偏高确认  
-- Paradef:     
-- Memo:    
mc_unusual_GetList 12511,'2013-09-11'   
  
update stu_mc_day set cdate = '2013-09-19 08:59:59' where id in(560,532,548)    
  
*/    
alter procedure [dbo].[mc_unusual_GetList]    
 @kid int,     
 @mcdate datetime   
AS    
BEGIN    
 SET NOCOUNT ON   --班级  姓名  体温  晨检时间  确认按钮  
    
 select uc.cname,uc.name uname,smd.tw,smd.cdate,smd.ftype,smd.id  
  from stu_mc_day smd    
   left join BasicData..User_Child uc    
    on smd.stuid = uc.userid    
   where smd.kid = @kid   
    and smd.tw >= 37.8    
    and ftype >0
    and smd.CheckDate = convert(varchar(10),@mcdate,120)  
   order by uc.name desc   
    
END    
  