USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[department_Delete]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-20
-- Description:	删除一条部门记录
-- Memo:		SELECT * FROM department WHERE KID = 12511
*/ 
CREATE PROCEDURE [dbo].[department_Delete]
	@did int
AS
BEGIN
	SET NOCOUNT ON 
	IF EXISTS(SELECT 1 FROM department WHERE superior = @did and deletetag = 1)
	BEGIN
		RETURN (-2)
	END 
	ELSE IF EXISTS( 
		SELECT 1 
			FROM teacher t1 
				inner join [user] t2 
					on t1.userid = t2.userid 
			where t1.did = @did 
				and t2.deletetag = 1)
	BEGIN
		RETURN (-3)
	END
	ELSE
	BEGIN	
	Begin tran   
	BEGIN TRY  
		UPDATE department 
			SET deletetag = 0 
			WHERE did = @did
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return (-1)       
	end Catch 
		Return ( 1)   
	END
END	

GO
