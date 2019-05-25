use ClassApp 
go
/*  
-- Author:      xie  
-- Create date: 2013-12-20  
-- Description:  班级公告恢复 
-- Memo:   
 [student_rollback] 239, '1006,1039'
   
*/  

alter PROCEDURE [dbo].[class_notice_rollback]  
 @kid int,  
 @str varchar(8000)
as    
BEGIN   
 SET NOCOUNT ON  
 
  CREATE TABLE #NoticeID(col nvarchar(40))  
  INSERT INTO #NoticeID  
    select distinct col  --将输入字符串转换为列表  
    from BasicData.dbo.f_split(@str,',')  
  
	 update cn set [status]=1
	   FROM [class_notice] cn
	   inner join #NoticeID ui   
		on cn.noticeid = ui.col   
		and cn.[status]<=0
	 
	 if @@ERROR<>0
	 return -1
	 else 
	 return 1 
  
END  