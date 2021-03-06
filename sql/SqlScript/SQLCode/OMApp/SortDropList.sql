USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[SortDropList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-24
-- Description:	
-- Memo:		SortDropList 12511
*/
CREATE PROC [dbo].[SortDropList]
	@kid int
AS
BEGIN
	SET NOCOUNT ON 
	SELECT SortCode, Title, IsConsum
		FROM Sort
			WHERE kid = @kid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大类下拉列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortDropList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortDropList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
