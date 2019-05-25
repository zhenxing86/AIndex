use BasicData 
go
/*  
-- Author:      xie  
-- Create date: 2013-12-20  
-- Description:   
-- Memo:   
 [student_rollback] 12511, '586964'
   
*/  
alter PROCEDURE [dbo].[student_rollback]  
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
			and u.usertype=0
		    
		  delete from user_del
		  where kid=@kid and exists(
			select 1 
			 from  [user] u  
			  inner join #UserID ui   
			   on u.userid = ui.col  
			  and u.usertype=0
			  and user_del.userid=u.userid
			)
		   
		   insert into user_class(cid,userid)
		    select cid,userid
			 from leave_kindergarten
			 where exists(
				select 1 
				 from #UserID ui 
				  inner join user_class uc 
				   on ui.col<>uc.userid
				 where leave_kindergarten.userid=ui.col 
			 )
		   
		   delete 
		   from leave_kindergarten
		    where exists(
			 select 1 
			  from #UserID ui 
			  where leave_kindergarten.userid=ui.col
			)
			
			drop table #UserID
		Commit tran                              
	End Try      
	Begin Catch      
	  Rollback tran  
	  Return  -1      
	end Catch  
	Return 1   
  
END  