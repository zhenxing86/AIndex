USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRegdatetime]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-24
-- Description:	过程用于更新幼儿园注册时间
-- Memo:		
*/
CREATE PROC [dbo].[UpdateRegdatetime]
	@kid int,
	@newdate datetime
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY  
		update kwebcms..site 
			set regdatetime = @newdate 
			where siteid = @kid

		update [BasicData].[dbo].[kindergarten] 
			set [actiondate] = @newdate  
			where kid = @kid 

		update ossapp..kinbaseinfo 
			set regdatetime = @newdate
				 ,ontime = @newdate
			where kid = @kid

		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return        
	end Catch   
  

END	
	
GO
