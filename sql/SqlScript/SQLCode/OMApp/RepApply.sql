USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepApply]    Script Date: 2014/11/24 23:20:50 ******/
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
EXEC RepApply 12511,1,'2013-10-1','2013-12-12',0
EXEC RepApply 12511,1,'2013-10-1','2013-12-12',1
EXEC RepApply 12511,1,'2013-10-1','2013-12-12',2
EXEC RepApply 12511,1,'2013-10-1','2013-12-12',3
EXEC RepApply 12511,1,'2013-10-1','2013-12-12',4
EXEC RepApply 12511,2,'2013-10-1','2013-12-12',0
EXEC RepApply 12511,2,'2013-10-1','2013-12-12',1
EXEC RepApply 12511,2,'2013-10-1','2013-12-12',2
EXEC RepApply 12511,2,'2013-10-1','2013-12-12',3
EXEC RepApply 12511,2,'2013-10-1','2013-12-12',4
*/
CREATE PROC [dbo].[RepApply]
	@kid int,
	@AppType int,--申请类型(1借用,2领用)
	@bgndate date,
	@enddate date,
	@GroupType int = 0--0大类 1小类 2班级 3老师 4物品
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @SQL NVARCHAR(2000), @SelectStr NVARCHAR(200), @GroupStr NVARCHAR(200)  
	IF @GroupType = 0--0大类 1小类 2班级 3老师 4物品
		SET @SelectStr = ' ,s.ID, s.Title Item '
	ELSE IF @GroupType = 1
		SET @SelectStr = ' ,sub.ID, sub.Title Item '
	ELSE IF @GroupType = 2
		SET @SelectStr = ' ,c.cid ID, c.cname Item '
	ELSE IF @GroupType = 3
		SET @SelectStr = ' ,u.userid ID, u.name Item '
	ELSE IF @GroupType = 4
		SET @SelectStr = ' ,o.ID, o.name Item '
	
	IF @GroupType = 0--0大类 1小类 2班级 3老师 4物品
		SET @GroupStr = ' s.ID, s.Title '
	ELSE IF @GroupType = 1
		SET @GroupStr = ' sub.ID, sub.Title '
	ELSE IF @GroupType = 2
		SET @GroupStr = ' c.cid, c.cname '
	ELSE IF @GroupType = 3
		SET @GroupStr = ' u.userid, u.name '
	ELSE IF @GroupType = 4
		SET @GroupStr = ' o.ID, o.name '
	
	IF @AppType = 1	
		SET @SelectStr = @SelectStr + ' ,Sum(d.Num - d.BadNum - d.LoseNum - d.ReturnNum) SumNoReturn'
	
	SELECT @SQL = 
	'SELECT SUM(d.Num) SumNum, 1.0 * SUM(d.Num * isnull(o.Price,0)) Assets ' + @SelectStr
 + '	from Apply_M m 
		inner join Apply_D d 
			on m.kid = d.kid 
			and m.AppSigNo = d.AppSigNo
			and m.ChkDate >= @bgndate 
			and m.ChkDate < DATEADD(DD,1,@enddate)
			and m.kid = @kid
			and m.AppType = @AppType
		inner join Object_M o
			on d.kid = o.kid
			and d.BarCode = o.BarCode
	'
	IF @GroupType = 0		
	SET @SQL = @SQL + ' 
		inner join Sort s
			on o.kid = s.kid
				and o.SortCode = s.SortCode '
	ELSE IF @GroupType = 1		
	SET @SQL = @SQL + ' 
		inner join SortSub sub
			on o.kid = sub.kid
			and o.SortCode = sub.SortCode
			and o.SortSubCode = sub.SortSubCode '
	ELSE IF @GroupType = 2		
	SET @SQL = @SQL + ' 
		LEFT JOIN BasicData..class c
			on m.cid = c.cid '
	ELSE IF @GroupType = 3		
	SET @SQL = @SQL + ' 
		INNER JOIN BasicData..[user] u
			on m.appuserid = u.userid '
	ELSE IF @GroupType = 4		
	SET @SQL = @SQL + '  '
	SET @SQL = @SQL + ' GROUP BY ' + @GroupStr
	print @SQL
	EXEC SP_EXECUTESQL @SQL,
						N'@kid int,
						@bgndate datetime, 
						@enddate datetime, 
						@AppType int',
						@kid = @kid,
						@bgndate = @bgndate,
						@enddate = @enddate, 
						@AppType = @AppType; 	
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领用（借用）物品统计报表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请类型(1借用,2领用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply', @level2type=N'PARAMETER',@level2name=N'@AppType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
