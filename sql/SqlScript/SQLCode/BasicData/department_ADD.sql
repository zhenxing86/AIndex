USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[department_ADD]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-20
-- Description:	增加一条部门记录
-- Memo:		
*/ 
CREATE PROCEDURE [dbo].[department_ADD]
	@dname nvarchar(20),
	@superior int,
	@kid int
AS
BEGIN
	SET NOCOUNT ON 
	
	DECLARE @did int, @order int
		
	Begin tran   
	BEGIN TRY
		SELECT @order=max([order]) + 1 
			FROM department 
			WHERE superior = @superior		
	  
		INSERT INTO department
			(dname, superior, [order], deletetag, kid, actiondatetime)
			VALUES(@dname, @superior, ISNULL(@order,1), 1, @kid, GETDATE())	
					
		SET @did = @@IDENTITY
		
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return (-1)       
	end Catch    
		Return @did	
END

GO
