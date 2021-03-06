USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepLose_D]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-10
-- Description:	
-- Memo:	
EXEC RepLose_D 12511, '2013-11-1','2013-12-11',4,2061
*/
CREATE PROC [dbo].[RepLose_D]
	@kid int,
	@bgndate date,
	@enddate date,
	@GroupType int, --0大类 1小类 2责任班级 3责任老师 4物品
	@ID int 
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @SQL NVARCHAR(1000)
	set @SQL = 
	'select	m.AppSigNo, s.title, sub.Title SubTitle, o.BarCode, o.Name ObjName, o.Unit, 
					o.Size, c.cname, u.name DutyName, d.Num, d.LoseNum, m.FirDate CrtDate
	from Apply_M m 
		inner join Apply_D d 
			on m.kid = d.kid 
			and m.AppSigNo = d.AppSigNo
			and d.LoseNum <> 0
		INNER JOIN BasicData..[user] u
			on m.appuserid = u.userid
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
		LEFT JOIN BasicData..class c
			on m.cid = c.cid
	WHERE m.RetDate >= @bgndate 
		and m.RetDate < DATEADD(DD,1,@enddate)
		and m.kid = @kid
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'遗失物品统计明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose_D'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose_D', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose_D', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose_D', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0大类 1小类 2班级 3老师 4物品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose_D', @level2type=N'PARAMETER',@level2name=N'@GroupType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepLose_D', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
