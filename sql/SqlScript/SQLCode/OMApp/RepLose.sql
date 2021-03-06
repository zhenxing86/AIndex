USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepLose]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-10
-- Description:	
-- Memo:	
EXEC RepLose 12511, '2013-11-1','2013-12-11',0
EXEC RepLose 12511, '2013-11-1','2013-12-11',1
EXEC RepLose 12511, '2013-11-1','2013-12-11',2
EXEC RepLose 12511, '2013-11-1','2013-12-11',3
EXEC RepLose 12511, '2013-11-1','2013-12-11',4
*/
CREATE PROC [dbo].[RepLose]
	@kid int,
	@bgndate date,
	@enddate date,
	@GroupType int --0大类 1小类 2责任班级 3责任老师 4物品
AS
BEGIN
	SET NOCOUNT ON
	IF @GroupType = 0
		select s.Title Item, SUM(d.LoseNum) SumLoseNum, 1.0 * SUM(d.LoseNum)/SUM(d.Num) PerLoseNum, s.ID 
			from Apply_M m 
				inner join Apply_D d 
					on m.kid = d.kid 
					and m.AppSigNo = d.AppSigNo
					and d.LoseNum <> 0
				inner join Object_M o
					on d.kid = o.kid
					and d.BarCode = o.BarCode
				inner join Sort s
					on o.kid = s.kid
						and o.SortCode = s.SortCode
			WHERE m.RetDate >= @bgndate 
				and m.RetDate < DATEADD(DD,1,@enddate)
				and m.kid = @kid
			GROUP BY s.Title, s.ID 
	else if @GroupType = 1
		select sub.Title Item, SUM(d.LoseNum) SumLoseNum, 1.0 * SUM(d.LoseNum)/SUM(d.Num) PerLoseNum, sub.ID 
			from Apply_M m 
				inner join Apply_D d 
					on m.kid = d.kid 
					and m.AppSigNo = d.AppSigNo
					and d.LoseNum <> 0
				inner join Object_M o
					on d.kid = o.kid
					and d.BarCode = o.BarCode
				inner join SortSub sub
					on o.kid = sub.kid
					and o.SortCode = sub.SortCode
					and o.SortSubCode = sub.SortSubCode
			WHERE m.RetDate >= @bgndate 
				and m.RetDate < DATEADD(DD,1,@enddate)
				and m.kid = @kid
			GROUP BY sub.Title, sub.ID 
	else if @GroupType = 2
		select c.cname Item, SUM(d.LoseNum) SumLoseNum, 1.0 * SUM(d.LoseNum)/SUM(d.Num) PerLoseNum, c.cid ID
			from Apply_M m 
				inner join Apply_D d 
					on m.kid = d.kid 
					and m.AppSigNo = d.AppSigNo
					and d.LoseNum <> 0
				inner JOIN BasicData..class c
					on m.cid = c.cid
			WHERE m.RetDate >= @bgndate 
				and m.RetDate < DATEADD(DD,1,@enddate)
				and m.kid = @kid
			GROUP BY c.cname, c.cid
	else if @GroupType = 3
		select u.name Item, SUM(d.LoseNum) SumLoseNum, 1.0 * SUM(d.LoseNum)/SUM(d.Num) PerLoseNum, u.userid ID
			from Apply_M m 
				inner join Apply_D d 
					on m.kid = d.kid 
					and m.AppSigNo = d.AppSigNo
					and d.LoseNum <> 0
				INNER JOIN BasicData..[user] u
					on m.appuserid = u.userid
			WHERE m.RetDate >= @bgndate 
				and m.RetDate < DATEADD(DD,1,@enddate)
				and m.kid = @kid
			GROUP BY u.name, u.userid
	else if @GroupType = 4
		select o.Name Item, SUM(d.LoseNum) SumLoseNum, 1.0 * SUM(d.LoseNum)/SUM(d.Num) PerLoseNum, o.ID
			from Apply_M m 
				inner join Apply_D d 
					on m.kid = d.kid 
					and m.AppSigNo = d.AppSigNo
					and d.LoseNum <> 0
				inner join Object_M o
					on d.kid = o.kid
					and d.BarCode = o.BarCode
			WHERE m.RetDate >= @bgndate 
				and m.RetDate < DATEADD(DD,1,@enddate)
				and m.kid = @kid
			GROUP BY o.name, o.ID
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'遗失物品统计报表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
