USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepBad_D]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-10
-- Description:	
-- Memo:	
EXEC RepBad_D 12511, '2013-11-1','2013-12-11',0
EXEC RepBad_D 12511, '2013-11-1','2013-12-11',1
EXEC RepBad_D 12511, '2013-11-1','2013-12-11',3
EXEC RepBad_D 12511, '2013-11-1','2013-12-11',4,8
*/
CREATE PROC [dbo].[RepBad_D]
	@kid int,
	@bgndate date,
	@enddate date,
	@GroupType int, --0大类 1小类 3责任老师 4物品
	@ID int 
AS
BEGIN	
	SET NOCOUNT ON
	DECLARE @SQL NVARCHAR(1000)
	set @SQL = 
	'select s.title, sub.Title SubTitle, o.BarCode, o.Name ObjName, o.Unit, 
					o.Size, u.name DutyName, v.VarNum, v.VarDate CrtDate
			from Variation v 
				inner join Object_M o
					on v.kid = o.kid
					and v.BarCode = o.BarCode
				inner join Sort s
					on o.kid = s.kid
						and o.SortCode = s.SortCode
				inner join SortSub sub
					on o.kid = sub.kid
					and o.SortCode = sub.SortCode
					and o.SortsubCode = sub.SortsubCode
				INNER JOIN BasicData..[user] u
					on v.DutyUserID = u.userid
			WHERE v.VarDate >= @bgndate 
				and v.VarDate < DATEADD(DD,1,@enddate)
				and v.VarType = 3
				and v.kid = @kid 
	'
	IF @GroupType = 0		
	SET @SQL = @SQL + ' AND s.ID = @ID'
	ELSE IF @GroupType = 1		
	SET @SQL = @SQL + ' AND sub.ID = @ID'
	ELSE IF @GroupType = 3		
	SET @SQL = @SQL + ' AND u.userid = @ID'
	ELSE IF @GroupType = 4		
	SET @SQL = @SQL + ' AND o.ID = @ID'
	
	EXEC SP_EXECUTESQL @SQL,
						N'@kid int,
						@bgndate datetime, 
						@enddate datetime, 
						@ID bigint',
						@kid = @kid,
						@bgndate = @bgndate,
						@enddate = @enddate, 
						@ID = @ID; 		
	
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报废物品统计明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad_D'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad_D', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad_D', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad_D', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad_D', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepBad_D', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
