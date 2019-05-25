use ClassApp 
go
/*  
-- Author:      xie  
-- Create date: 2013-12-20  
-- Description: 教学安排恢复 
-- Memo:   
 [class_schedule_rollback] 239, '1006,1039'
   
*/  

create PROCEDURE [dbo].[class_schedule_rollback]  
 @kid int,  
 @str varchar(8000)
as    
BEGIN   
 SET NOCOUNT ON  
 
  CREATE TABLE #ScheduleID(col nvarchar(40))  
  INSERT INTO #ScheduleID  
    select distinct col  --将输入字符串转换为列表  
    from BasicData.dbo.f_split(@str,',')  
  
	 update cs set [status]=1
	   FROM [class_schedule] cs
	   inner join #ScheduleID si   
		on cs.scheduleid = si.col   
		and cs.[status]=0
	 
	 if @@ERROR<>0
	 return -1
	 else 
	 return 1 
  
END  