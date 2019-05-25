/*    
-- Author:      xie    
-- Create date: 2013-12-20    
-- Description:  班级照片恢复   
-- Memo:     
 [class_photos_rollback] 239, '1006,1039'  
     
*/    
  
alter PROCEDURE [dbo].[class_photos_rollback]    
 @kid int,    
 @str varchar(8000)  
as      
BEGIN     
 SET NOCOUNT ON    
   
  CREATE TABLE #PhotoID(col nvarchar(40))    
  INSERT INTO #PhotoID    
    select distinct col  --将输入字符串转换为列表    
    from BasicData.dbo.f_split(@str,',')    
    
  update cp set [status]=1  
    FROM [class_photos] cp  
    inner join #PhotoID ui     
  on cp.photoid = ui.col     
  and cp.[status]<=0  
   
  select COUNT(1)cnt,a.albumid 
  into #t
  from  [class_photos] a 
  inner join #PhotoID ui on a.photoid = ui.col
  inner join class_album b on a.albumid = b.albumid
  
  update class_album set photocount = isnull(photocount,0) + CNT
  from  #t t inner join class_album b on t.albumid = b.albumid
    
  if @@ERROR<>0  
  return -1  
  else   
  return 1   
    
END 