USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[SortSubDropList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-24
-- Description:	
-- Memo:		SortSubDropList 12511,'01'
*/
CREATE PROC [dbo].[SortSubDropList]
	@kid int,
	@SortCode varchar(10)
AS
BEGIN
	SET NOCOUNT ON 
	SELECT SortSubCode, Title 
		FROM SortSub
			WHERE kid = @kid
				and SortCode = @SortCode
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小类下拉列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubDropList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubDropList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubDropList', @level2type=N'PARAMETER',@level2name=N'@SortCode'
GO
