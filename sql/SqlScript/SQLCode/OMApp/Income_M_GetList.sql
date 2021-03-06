USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Income_M_GetList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-26
-- Description:	
-- Memo:		
 Income_M_GetList
	@kid = 12511,
	@page = 1,
	@size = 10,
	@IncSigNo = -1,
	@bgndate = null,
	@enddate = null	
*/
CREATE PROC [dbo].[Income_M_GetList]
	@kid int,
	@page int,
	@size int,
	@IncSigNo int,
	@bgndate date = null,
	@enddate date = null,
	@IsCheck int = -1	
AS
BEGIN
	SET NOCOUNT ON
	if @bgndate = '1900-01-01' set @bgndate = null	
	if @enddate = '1900-01-01' set @enddate = null	
	DECLARE 
		@fromstring NVARCHAR(2000),				--数据集
		@selectstring NVARCHAR(800),      --查询字段
		@returnstring NVARCHAR(800)       --返回字段
	SET @fromstring  = '
	Income_M i
		left join BasicData..[user] u on i.FirUserid = u.userid 
		left join BasicData..[user] u1 on i.ChkUserID = u1.userid 
	where	i.kid = @D1 '
	IF @IncSigNo <> -1 SET @fromstring = @fromstring + '
			AND i.IncSigNo = @D2'  
	IF @bgndate IS NOT NULL SET @fromstring = @fromstring + '
			AND i.FirDate >= @T1'  
	IF @enddate IS NOT NULL SET @fromstring = @fromstring + '
			AND i.FirDate < DATEADD(DD,1,@T2)' 
	IF @IsCheck <> -1 SET @fromstring = @fromstring + '
			AND i.IsCheck = CAST(@D3 AS BIT)' 
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		'i.ID, i.kid, i.IncSigNo, u.name FirName, i.FirDate, i.PurSigNo, i.IsCheck, u1.name ChkName, i.ChkDate',      --查询字段
		@returnstring = 
		'ID, kid, IncSigNo, FirName, FirDate, PurSigNo, IsCheck, ChkName, ChkDate',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' i.IncSigNo DESC',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid,	
		@D2 = @IncSigNo,
		@D3 = @IsCheck,
		@T1 = @bgndate,	
		@T2 = @enddate
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取入库单主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_M_GetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_M_GetList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_M_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_M_GetList', @level2type=N'PARAMETER',@level2name=N'@size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_M_GetList', @level2type=N'PARAMETER',@level2name=N'@IncSigNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_M_GetList', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_M_GetList', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否确认' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_M_GetList', @level2type=N'PARAMETER',@level2name=N'@IsCheck'
GO
