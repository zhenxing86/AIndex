USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Income_D_GetList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-10-26
-- Description:	
-- Memo:		
 Income_D_GetList
	@kid = 12511,
	@IncSigNo = 12345678
*/
CREATE PROC [dbo].[Income_D_GetList]
	@kid int,
	@IncSigNo int
AS
BEGIN
	SET NOCOUNT ON
	SELECT	i.ID, i.kid, i.IncSigNo, i.BarCode, i.Num, 
					i.Price, s.Title, ss.Title SubTitle, o.Name, ISNULL(op.cnt,0) PicCnt
		FROM Income_D i 
			inner join Object_M o 
				on i.kid = o.kid 
				and i.BarCode = o.BarCode
			inner join Sort s 
				on s.kid = o.kid 
				and o.SortCode = s.SortCode
			inner join SortSub ss 
				on ss.kid = o.kid 
				and o.SortCode = ss.SortCode 
				and o.SortSubCode = ss.SortSubCode
			LEFT JOIN Object_PicCnt_v op
				on o.kid = op.kid
				and o.BarCode = op.BarCode
		WHERE i.kid = @kid 
			AND i.IncSigNo = @IncSigNo
		ORDER BY i.ID
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取入库单明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_D_GetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_D_GetList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_D_GetList', @level2type=N'PARAMETER',@level2name=N'@IncSigNo'
GO
