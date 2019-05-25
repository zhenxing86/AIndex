use BasicData 
go
/*  
-- Author:      xie  
-- Create date: 2013-12-20  
-- Description:   
-- Memo:   
 [department_rollback] 239, '1006,1039'
   
*/  
create PROCEDURE [dbo].[department_rollback]  
 @kid int,  
 @str varchar(8000)
as    
BEGIN   
 SET NOCOUNT ON  
 
  CREATE TABLE #DID(col nvarchar(40))  
  INSERT INTO #DID  
    select distinct col  --将输入字符串转换为列表  
    from BasicData.dbo.f_split(@str,',')  
 
	 update d set deletetag=1
	   FROM department d  
	   inner join #DID di   
		on d.did = di.col   
		and d.deletetag=0
		and d.kid=@kid
	
	if @@ERROR<>0
	return -1
	else
	Return 1   
  
END  