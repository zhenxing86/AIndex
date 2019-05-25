use ClassApp 
go
/*  
-- Author:      xie  
-- Create date: 2013-12-20  
-- Description: 班级视频恢复 
-- Memo:   
 [class_video_rollback] 239, '1006,1039'
   
*/  

create PROCEDURE [dbo].[class_video_rollback]  
 @kid int,  
 @str varchar(8000)
as    
BEGIN   
 SET NOCOUNT ON  
 
  CREATE TABLE #VideoID(col nvarchar(40))  
  INSERT INTO #VideoID  
    select distinct col  --将输入字符串转换为列表  
    from BasicData.dbo.f_split(@str,',')  
  
	 update cs set [status]=1
	   FROM [class_video] cs
	   inner join #VideoID vi   
		on cs.videoid = vi.col   
		and cs.[status]=0
	 
	 if @@ERROR<>0
	 return -1
	 else 
	 return 1 
  
END  