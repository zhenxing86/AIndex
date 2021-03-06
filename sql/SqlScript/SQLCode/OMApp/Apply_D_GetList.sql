USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Apply_D_GetList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-10-26
-- Description:	
-- Memo:		
 Apply_D_GetList
	@kid = 12511,
	@AppSigNo = 1311140003
*/
CREATE PROC [dbo].[Apply_D_GetList]
	@kid int,
	@AppSigNo int
AS
BEGIN
	SET NOCOUNT ON
	SELECT	a.ID, a.AppSigNo, a.BarCode, a.Num, o.Qty, 
					s.Title, ss.Title SubTitle, o.Name,
					a.BadNum, a.LoseNum, a.ReturnNum, a.IsReturn, 
					a.ReturnDate, s.Audit, ISNULL(op.cnt,0) PicCnt
		FROM Apply_D a 
			inner join Object_M o on a.kid = o.kid and a.BarCode = o.BarCode
			inner join Sort s on s.kid = o.kid and o.SortCode = s.SortCode
			inner join SortSub ss on ss.kid = o.kid and o.SortCode = ss.SortCode and o.SortSubCode = ss.SortSubCode
			LEFT JOIN Object_PicCnt_v op
				on o.kid = op.kid
				and o.BarCode = op.BarCode
		WHERE a.kid = @kid 
			AND a.AppSigNo = @AppSigNo
		ORDER BY a.ID DESC
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取领用（借用）明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_D_GetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_D_GetList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_D_GetList', @level2type=N'PARAMETER',@level2name=N'@AppSigNo'
GO
