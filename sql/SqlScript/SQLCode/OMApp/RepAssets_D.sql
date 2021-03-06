USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepAssets_D]    Script Date: 2014/11/24 23:20:50 ******/
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
EXEC RepAssets_D 12511,'01','001'
*/
CREATE PROC [dbo].[RepAssets_D]
	@kid int,	
	@GroupType int,--0 大类 1 小类
	@ID bigint
AS
BEGIN
	SET NOCOUNT ON
	IF @GroupType = 0
	SELECT	o.BarCode, o.Name, o.Size, o.Qty, o.Unit, 
					o.Price, o.Qty + o.Price Assets --	品名	规格	库存数量	单位	单价	总价值
		FROM Object_M o 
			inner join Sort s
				on o.kid = s.kid 
				and o.SortCode = s.SortCode
		where o.kid = @kid
			and s.ID = @ID
	else IF @GroupType = 1
	SELECT	o.BarCode, o.Name, o.Size, o.Qty, o.Unit, 
					o.Price, o.Qty + o.Price Assets --	品名	规格	库存数量	单位	单价	总价值
		FROM Object_M o 
			inner join SortSub sub
				on o.kid = sub.kid 
				and o.SortCode = sub.SortCode
				and o.SortSubCode = sub.SortSubCode
		where o.kid = @kid
			and sub.ID = @ID
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'资产统计明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepAssets_D'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepAssets_D', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepAssets_D', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepAssets_D', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
