USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepBad]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-10
-- Description:	
-- Memo:	
EXEC RepBad 12511, '2013-11-1','2013-12-30',0
EXEC RepBad 12511, '2013-11-1','2013-12-30',1
EXEC RepBad 12511, '2013-11-1','2013-12-30',3
EXEC RepBad 12511, '2013-11-1','2013-12-30',4
*/
CREATE PROC [dbo].[RepBad]
	@kid int,
	@bgndate date,
	@enddate date,
	@GroupType int --0大类 1小类 3责任老师 4物品
AS
BEGIN
	SET NOCOUNT ON
	IF @GroupType = 0
		select s.Title Item, SUM(v.VarNum) SumBadNum, 0 PerBadNum, s.ID 
			from Variation v 
				inner join Object_M o
					on v.kid = o.kid
					and v.BarCode = o.BarCode
				inner join Sort s
					on o.kid = s.kid
						and o.SortCode = s.SortCode
			WHERE v.VarDate >= @bgndate 
				and v.VarDate < DATEADD(DD,1,@enddate)
				and v.VarType = 3
				and v.kid = @kid 
			GROUP BY s.Title, s.ID 
	else if @GroupType = 1
		select sub.Title Item, SUM(v.VarNum) SumBadNum, 0 PerBadNum, sub.ID 
			from Variation v 
				inner join Object_M o
					on v.kid = o.kid
					and v.BarCode = o.BarCode
				inner join SortSub sub
					on o.kid = sub.kid
					and o.SortCode = sub.SortCode
					and o.SortSubCode = sub.SortSubCode
			WHERE v.VarDate >= @bgndate 
				and v.VarDate < DATEADD(DD,1,@enddate)
				and v.VarType = 3
				and v.kid = @kid 
			GROUP BY sub.Title, sub.ID 
	else if @GroupType = 3
		select u.name Item, SUM(v.VarNum) SumBadNum, 0 PerBadNum, u.userid ID 
			from Variation v 
				INNER JOIN BasicData..[user] u
					on v.DutyUserID = u.userid
			WHERE v.VarDate >= @bgndate 
				and v.VarDate < DATEADD(DD,1,@enddate)
				and v.VarType = 3
				and v.kid = @kid 
			GROUP BY u.name, u.userid
	else if @GroupType = 4
		select o.name Item, SUM(v.VarNum) SumBadNum, 0 PerBadNum, o.ID 
			from Variation v 				
				inner join Object_M o
					on v.kid = o.kid
					and v.BarCode = o.BarCode
			WHERE v.VarDate >= @bgndate 
				and v.VarDate < DATEADD(DD,1,@enddate)
				and v.VarType = 3
				and v.kid = @kid 
			GROUP BY o.name, o.ID 			
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报废物品统计报表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
