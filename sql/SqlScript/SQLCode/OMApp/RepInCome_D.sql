USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepInCome_D]    Script Date: 2014/11/24 23:20:50 ******/
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
EXEC RepInCome_D 12511,'2013-10-25','2013-11-25',0,11
*/
CREATE PROC [dbo].[RepInCome_D]
	@kid int,
	@bgndate date,
	@enddate date,	
	@GroupType int,--0 大类 1 小类
	@ID bigint
AS
BEGIN
	SET NOCOUNT ON
	if @GroupType = 0
		SELECT	m.IncSigNo, u.name FirName,m.FirDate, d.BarCode, 
						o.Name ObjName, o.Unit, o.Size, d.Num, d.Num * d.Price Assets
--入库单号	入库操作人	条码	品名	单位	规格	入库数量	总价值
		FROM Income_M m 
			inner join Income_D d
				on m.kid = d.kid 
				and m.IncSigNo = d.IncSigNo
			inner join Object_M o 
				on d.kid = o.kid
				and d.BarCode = o.BarCode	
			inner join Sort s
				on o.kid = s.kid 
				and o.SortCode = s.SortCode
			inner join BasicData..[user] u
				on m.FirUserid = u.userid
		WHERE m.kid = @kid
			and m.FirDate >= @bgndate 
			and m.FirDate < DATEADD(DD,1,@enddate)
			and s.ID = @ID
		ORDER BY m.FirDate desc
	ELSE if @GroupType = 1
		SELECT	m.IncSigNo, u.name FirName,m.FirDate, d.BarCode, 
						o.Name ObjName, o.Unit, o.Size, d.Num, d.Num * d.Price Assets
--入库单号	入库操作人	条码	品名	单位	规格	入库数量	总价值
		FROM Income_M m 
			inner join Income_D d
				on m.kid = d.kid 
				and m.IncSigNo = d.IncSigNo
			inner join Object_M o 
				on d.kid = o.kid
				and d.BarCode = o.BarCode	
			inner join SortSub sub
				on o.kid = sub.kid 
				and o.SortCode = sub.SortCode
				and o.SortSubCode = sub.SortSubCode
			inner join BasicData..[user] u
				on m.FirUserid = u.userid
		WHERE m.kid = @kid
			and m.FirDate >= @bgndate 
			and m.FirDate < DATEADD(DD,1,@enddate)
			and sub.ID = @ID
		ORDER BY m.FirDate desc

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库统计明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome_D'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome_D', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome_D', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome_D', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome_D', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome_D', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
