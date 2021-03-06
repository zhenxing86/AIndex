USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepInCome]    Script Date: 2014/11/24 23:20:50 ******/
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
EXEC RepInCome 12511,'2013-10-25','2013-11-25',0
*/
CREATE PROC [dbo].[RepInCome]
	@kid int,
	@bgndate date,
	@enddate date,
	@GroupType int = 0--0 大类 1 小类
AS
BEGIN
	SET NOCOUNT ON
	if @GroupType = 0
	BEGIN
		SELECT s.Title,SUM(d.Num ) NumCnt, SUM(d.Num * isnull(d.Price,0)) Assets, s.ID
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
		WHERE m.kid = @kid
			and m.FirDate >= @bgndate 
			and m.FirDate < DATEADD(DD,1,@enddate)
		GROUP BY s.Title, s.ID
		ORDER BY Assets desc
	
	END
	ELSE if @GroupType = 1
	BEGIN
		SELECT sub.Title,SUM(d.Num ) NumCnt, SUM(d.Num * isnull(d.Price,0)) Assets, sub.ID
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
		WHERE m.kid = @kid
			and m.FirDate >= @bgndate 
			and m.FirDate < DATEADD(DD,1,@enddate)
		GROUP BY sub.Title, sub.ID
		ORDER BY Assets desc		
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库统计报表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInCome', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
