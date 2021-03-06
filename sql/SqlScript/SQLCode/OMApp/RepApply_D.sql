USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepApply_D]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-09
-- Description:	
-- Memo:	
EXEC RepApply 12511,1,'2013-10-1','2013-12-12',0
EXEC RepApply_D 12511,1,'2013-10-1','2013-12-12',0,22
*/
CREATE PROC [dbo].[RepApply_D]
	@kid int,
	@AppType int,--申请类型(1借用,2领用)
	@bgndate date,
	@enddate date,
	@GroupType int = 0,--0大类 1小类 2班级 3老师 4物品
	@ID int 
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @SQL NVARCHAR(2000), @SelectStr NVARCHAR(200)	
	IF @AppType = 1	
		SET @SelectStr = ' ,d.Num - d.BadNum - d.LoseNum - d.ReturnNum NoReturn'
	
	SELECT @SQL = 
	'SELECT m.AppSigNo, c.cname, u.name, o.BarCode, s.Title, sub.Title SubTitle, 
		o.name ObjName, o.Unit, o.Size, d.Num, u1.name ChkName ' + ISNULL(@SelectStr,'')+', m.FirDate CrtDate'
 + '	from Apply_M m 
		inner join Apply_D d 
			on m.kid = d.kid 
			and m.AppSigNo = d.AppSigNo
		inner join Object_M o
			on d.kid = o.kid
			and d.BarCode = o.BarCode
		inner join Sort s
			on o.kid = s.kid
				and o.SortCode = s.SortCode 
		inner join SortSub sub
			on o.kid = sub.kid
			and o.SortCode = sub.SortCode
			and o.SortSubCode = sub.SortSubCode 
		INNER JOIN BasicData..[user] u
			on m.appuserid = u.userid 
		INNER JOIN BasicData..[user] u1
			on m.ChkUserID = u1.userid 
		LEFT JOIN BasicData..class c
			on m.cid = c.cid 
		WHERE m.ChkDate >= @bgndate 
			and m.ChkDate < DATEADD(DD,1,@enddate)
			and m.kid = @kid
			and m.AppType = @AppType
	'
	IF @GroupType = 0		
	SET @SQL = @SQL + ' AND s.ID = @ID'
	ELSE IF @GroupType = 1		
	SET @SQL = @SQL + ' AND sub.ID = @ID'
	ELSE IF @GroupType = 2		
	SET @SQL = @SQL + ' AND c.cid = @ID'
	ELSE IF @GroupType = 3		
	SET @SQL = @SQL + ' AND u.userid = @ID'
	ELSE IF @GroupType = 4		
	SET @SQL = @SQL + ' AND o.ID = @ID'
	SET @SQL = @SQL + '  '
	print @SQL
	EXEC SP_EXECUTESQL @SQL,
						N'@kid int,
						@bgndate datetime, 
						@enddate datetime, 
						@ID bigint,
						@AppType int',
						@kid = @kid,
						@bgndate = @bgndate,
						@enddate = @enddate, 
						@ID = @ID, 
						@AppType = @AppType; 	
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领用（借用）物品统计明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply_D'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply_D', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请类型(1借用,2领用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply_D', @level2type=N'PARAMETER',@level2name=N'@AppType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply_D', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply_D', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply_D', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepApply_D', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
