USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[RepInComeSat]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-11-13
-- Description:	
--入库统计	指定时间范围查询物品入库情况，按分类汇总
-- Memo:	
RepInComeSat 12511, '2013-09-01','2013-12-01'
*/
CREATE PROC [dbo].[RepInComeSat]
	@kid int,
	@BgnDate date,
	@EndDate date
as
BEGIN
	SET NOCOUNT ON
	select * 
		from Income_M m
			inner join Income_D d
				on m.kid = d.kid
				and m.IncSigNo = d.IncSigNo
			inner join Object_M o
				on m.kid = o.kid
				and d.BarCode = o.BarCode
		where m.kid = @kid
			and m.FirDate >= @BgnDate
			and m.FirDate < DATEADD(DD,1,@EndDate)
			and m.IsCheck = 1

END


GO
EXEC sys.sp_addextendedproperty @name=N'Abolish', @value=N'作废' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInComeSat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'无用（作废）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInComeSat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInComeSat', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInComeSat', @level2type=N'PARAMETER',@level2name=N'@BgnDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'RepInComeSat', @level2type=N'PARAMETER',@level2name=N'@EndDate'
GO
