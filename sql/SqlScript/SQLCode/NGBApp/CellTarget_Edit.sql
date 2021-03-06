USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[CellTarget_Edit]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	编辑HomeBook表
-- Memo:		
exec CellTarget_Edit 4,'2013年9月', '在园表现观察目标测试1#在园表现观察目标测试2#在园表现观察目标测试3#在园表现观察目标测试4#在园表现观察目标测试5#在园表现观察目标测试6#在园表现观察目标测试7#在园表现观察目标测试8#在园表现观察目标测试9#在园表现观察目标测试10#'
*/
CREATE PROC [dbo].[CellTarget_Edit]
	@hbid int,
	@title nvarchar(40),
	@target nvarchar(2000)
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY
		
		;MERGE CellTarget AS ct
		USING (SELECT @hbid hbid, @title title, @target target)AS mu
		ON (ct.hbid = mu.hbid and ct.title = mu.title)
		WHEN MATCHED THEN
		UPDATE SET 
			ct.target = mu.target,
			ct.CrtDate = getdate()
		WHEN NOT MATCHED THEN
		INSERT (hbid, title,target)
		VALUES (@hbid, @title, @target);		
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch     
		RETURN 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑CellTarget' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'CellTarget_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家园联系册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'CellTarget_Edit', @level2type=N'PARAMETER',@level2name=N'@hbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'CellTarget_Edit', @level2type=N'PARAMETER',@level2name=N'@title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'观察目标内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'CellTarget_Edit', @level2type=N'PARAMETER',@level2name=N'@target'
GO
