USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[get_stu_mc_Day]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[get_stu_mc_Day]
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY  
		select kid, stuid ,card ,tw ,zz ,cdate, ftype 
		INTO #T
			from stu_mc_Day 
			where ftype in(0,2)		
				and Status = 0
		
		UPDATE stu_mc_Day 
			SET ftype = ftype + 1 
			where ftype in(0,2)		
				and Status = 0 
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran  
	end Catch     

	SELECT * FROM #T


END 

GO
