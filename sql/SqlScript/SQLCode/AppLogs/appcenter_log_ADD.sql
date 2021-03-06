USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[appcenter_log_ADD]    Script Date: 2014/11/24 21:14:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：增加应用日志记录  
--项目名称：  
--说明：  
--时间：2011-7-1 15:29:16  
------------------------------------  
CREATE PROCEDURE [dbo].[appcenter_log_ADD]  
	@userid int,  
	@usertype int,
	@asctiondesc nvarchar(500),    
	@appid int  
AS 
BEGIN  
	SET NOCOUNT ON
	DECLARE @id int  

	Begin tran 	
	BEGIN TRY 
		INSERT INTO appcenter_log
				(userid,usertype,actiondatetime,appid,asctiondesc)
			VALUES(@userid,@usertype,getdate(),@appid,@asctiondesc)  
		SET @id = @@IDENTITY  

		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  (-1)       
	end Catch    
	return @id  

END
GO
