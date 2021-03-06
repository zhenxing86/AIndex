USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[department_order_Update]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-20
-- Description:	修改部门排序
-- Memo:	department_order_Update	
*/
CREATE PROCEDURE [dbo].[department_order_Update]
	@did int,
	@opt int
AS
BEGIN
	SET NOCOUNT ON	
	declare @source_order int, @target_order int, @target_did int
	SELECT	@source_order = d1.[order],
					@target_order = d2.[order],
					@target_did   = d2.did 
		FROM department d1 
			outer apply
				(
					select top(1) [order], d2.did 
						from department d2 
						where d1.superior = d2.superior
							and d2.deletetag = 1 
							and d1.did <> d2.did
							AND ((@opt > 0 AND d2.[order] >= d1.[order])
								or (@opt < 0 AND d2.[order] <= d1.[order])							
									)							 
						order by CASE WHEN @opt > 0 then d2.[order] ELSE 9999 END, d2.[order] DESC
				)d2 WHERE d1.did = @did
						
	Begin tran   
	BEGIN TRY  
		update department 
			set [order] = ISNULL(@target_order,[order])
			WHERE did = @did	
		update department 
			set [order] = ISNULL(@source_order,[order])
			WHERE did = @target_did
		
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return (-1)       
	end Catch    
		Return (1)			
		
END

GO
