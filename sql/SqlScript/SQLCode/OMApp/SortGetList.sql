USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[SortGetList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-24
-- Description:	
-- Memo:		
SortGetList 58
*/
CREATE PROC [dbo].[SortGetList]
	@kid int
as
BEGIN
	SET NOCOUNT ON
	SELECT s.ID, s.SortCode, s.Title, s.IsConsum, s.Audit, s.CrtDate, ISNULL(o.cnt ,0)cnt 
		FROM Sort s 
			left join Object_M_SortNo_V o 
				on s.kid = o.kid 
				and s.SortCode = o.SortCode
		where s.kid = @kid
			order by s.IsConsum desc, SortCode
	SELECT s.ID, s.SortCode, s.SortSubCode, s.Title, s.CrtDate, ISNULL(o.cnt ,0)cnt 
		FROM SortSub s 
			left join Object_M_SortSubNo_V o 
			on s.kid = o.kid 
			and s.SortCode = o.SortCode 
			and s.SortSubCode = o.SortSubCode
		where s.kid = @kid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取大类表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortGetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortGetList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
