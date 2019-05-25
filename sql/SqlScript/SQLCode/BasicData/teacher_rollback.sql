use BasicData 
go
/*  
-- Author:      xie  
-- Create date: 2013-12-20  
-- Description:   
-- Memo:   
 [teacher_rollback] 239, '1006,1039'
   
*/  
alter PROCEDURE [dbo].[teacher_rollback]  
 @kid int,  
 @str varchar(8000)
as    
BEGIN   
 SET NOCOUNT ON  
 
  CREATE TABLE #UserID(col nvarchar(40))  
  INSERT INTO #UserID  
    select distinct col  --将输入字符串转换为列表  
    from BasicData.dbo.f_split(@str,',')  
  
   Begin tran   
	BEGIN TRY  
		 update u set deletetag=1,kid=@kid  
		   FROM [user] u  
		   inner join #UserID ui   
			on u.userid = ui.col   
			and u.usertype>0
		    
		  delete from user_del
		  where kid=@kid and exists(
			select 1 
			 from  [user] u  
			  inner join #UserID ui   
			   on u.userid = ui.col  
			    and u.usertype=1
			    and user_del.userid=u.userid
			)
		    
		Commit tran                              
	End Try      
	Begin Catch      
	  Rollback tran  
	  Return  -1      
	end Catch  
	Return 1   
  
END  