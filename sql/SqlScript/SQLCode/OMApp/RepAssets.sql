USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepAssets]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-09
-- Description:	
-- Memo:	
SELECT * FROM OBJECT_M WHERE KID = 12511
EXEC RepAssets 12511,0
*/
CREATE PROC [dbo].[RepAssets]
	@kid int,
	@GroupType int = 0--0 大类 1 小类
AS
BEGIN
	SET NOCOUNT ON
	if @GroupType = 0
	BEGIN
		SELECT s.Title,SUM(o.Qty ) QtyCnt, SUM(o.Qty * isnull(o.Price,0)) Assets, 
			SUM(o.Qty * o.Price)/NULLIF(SUM(SUM(o.Qty * isnull(o.Price,0)))OVER(),0)AssetsPct, s.ID
		FROM Object_M o 
			inner join Sort s
				on o.kid = s.kid 
				and o.SortCode = s.SortCode
		WHERE o.kid = @kid
		GROUP BY s.Title, s.ID
		ORDER BY QtyCnt desc
	
	END
	ELSE if @GroupType = 1
	BEGIN
		SELECT sub.Title,SUM(o.Qty ) QtyCnt, SUM(o.Qty * isnull(o.Price,0)) Assets, 
			SUM(o.Qty * o.Price)/NULLIF(SUM(SUM(o.Qty * isnull(o.Price,0)))OVER(),0)AssetsPct, sub.ID
		FROM Object_M o 
			inner join SortSub sub
				on o.kid = sub.kid 
				and o.SortCode = sub.SortCode
				and o.SortSubCode = sub.SortSubCode
		WHERE o.kid = @kid
		GROUP BY sub.Title, sub.ID
		ORDER BY QtyCnt desc
	
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'资产统计报表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepAssets'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepAssets', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepAssets', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
