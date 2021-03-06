USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[department_Update]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-20
-- Description:	修改一条部门记录
-- Memo:		
*/ 
CREATE PROCEDURE [dbo].[department_Update]
	@did int,
	@dname nvarchar(20),
	@superior int
AS
BEGIN
	SET NOCOUNT ON
 
	DECLARE @order int, @oldsuperior int
	
	SELECT @oldsuperior = superior 
		FROM department 
		WHERE did = @did 
		 
	IF (@oldsuperior <> @superior)
	BEGIN
		select @order = MAX([order]) + 1 
			from department 
			WHERE superior = @superior
	END

	Begin tran   
	BEGIN TRY  
		UPDATE department 
			SET dname = @dname,
					superior = @superior,
					[order] = ISNULL(@order,[order])
			WHERE did = @did 		
			
		IF (@oldsuperior <> @superior)
		BEGIN
			;WITH CET AS
			(
				SELECT *, ROW_NUMBER()over(order by [order])rowno 
					FROM department 
					WHERE superior = @oldsuperior
			)
				update CET 
					set [order] = rowno		
			;WITH CET AS
			(
				SELECT *, ROW_NUMBER()over(order by [order])rowno 
					FROM department 
					WHERE superior = @superior
			)
				update CET 
					set [order] = rowno		
		END
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return (-1)       
	end Catch    
		Return (1)	
END
	

GO
