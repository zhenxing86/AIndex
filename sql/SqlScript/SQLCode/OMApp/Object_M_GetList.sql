USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Object_M_GetList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-10-26
-- Description:	
-- Memo:		
Object_M_GetList 	@kid = 12511,
	@page = 1,
	@size = 10,
	@Name = '',
	@SortCode = '',
	@SortSubCode = '',
	@BarCode = '',
	@bgndate = null,
	@enddate = null,
	@bgnqty = -1,
	@endqty = -1
*/
CREATE PROC [dbo].[Object_M_GetList]
	@kid int,
	@page int,
	@size int,
	@Name varchar(50),
	@SortCode varchar(2),
	@SortSubCode varchar(3),
	@BarCode varchar(50),
	@bgndate date = null,
	@enddate date = null,
	@bgnqty int,
	@endqty int,
	@IsConsum int = -1
AS
BEGIN
	SET NOCOUNT ON
	--SQL注入过滤
	select @Name = CommonFun.dbo.FilterSQLInjection(@Name)
	select @BarCode = CommonFun.dbo.FilterSQLInjection(@BarCode)
	if @bgndate = '1900-01-01' set @bgndate = null	
	if @enddate = '1900-01-01' set @enddate = null	
	DECLARE 
		@fromstring NVARCHAR(2000),				--数据集
		@selectstring NVARCHAR(800),      --查询字段
		@returnstring NVARCHAR(800)       --返回字段
	SET @fromstring  = '
	Object_M o 
			inner join Sort s 
				on s.kid = o.kid 
				and s.SortCode = o.SortCode
			inner join SortSub ss
				on ss.kid = o.kid 
				and ss.SortCode = o.SortCode 
				and ss.SortSubCode = o.SortSubCode 
			LEFT JOIN Object_PicCnt_v op
				on o.kid = op.kid
				and o.BarCode = op.BarCode
		where	o.kid = @D1 '
	IF @Name <> '' SET @fromstring = @fromstring + '
			AND o.Name LIKE ''%''+@S1+''%''' 
	IF @SortCode <> '' and @SortSubCode <> '' SET @fromstring = @fromstring + '
			AND o.SortCode = @S2 AND o.SortSubCode = @S3'  	
	ELSE IF @SortCode <> '' SET @fromstring = @fromstring + '
			AND o.SortCode = @S2'  
	IF @BarCode <> '' SET @fromstring = @fromstring + '
			AND o.BarCode = @S4'  
	IF @bgndate IS NOT NULL SET @fromstring = @fromstring + '
			AND o.CrtDate >= @T1'  
	IF @enddate IS NOT NULL SET @fromstring = @fromstring + '
			AND o.CrtDate < DATEADD(DD,1,@T2)'  
	IF @bgnqty <> -1 SET @fromstring = @fromstring + '
			AND o.Qty >= @D2'  
	IF @endqty <> -1 SET @fromstring = @fromstring + '
			AND o.Qty <= @D3' 
	IF @IsConsum <> -1 SET @fromstring = @fromstring + '
			AND s.IsConsum = @D4' 	 
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		'o.ID, o.kid, s.Title, ss.Title SubTitle, 
					o.BarCode, o.Name, o.SortCode, o.SortSubCode, o.Qty, o.WarnQty, o.Unit, o.Size, 
					o.CrtDate, o.udate, o.Price, CASE WHEN s.IsConsum = 1 then ''是'' ELSE ''否'' END ConsumStr, 
					CASE WHEN s.Audit = 1 then ''是'' ELSE ''否'' END AuditStr, ISNULL(op.cnt,0) PicCnt',      --查询字段
		@returnstring = 
		'ID, kid, Title, SubTitle, BarCode, Name, SortCode, SortSubCode, 
		Qty, WarnQty, Unit, Size, CrtDate, udate, Price,ConsumStr, AuditStr, PicCnt ',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' o.BarCode',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid,										
		@D4 = @IsConsum,	
		@S1 = @Name,	
		@S2 = @SortCode,	
		@S3 = @SortSubCode,	
		@S4 = @BarCode,	
		@T1 = @bgndate,	
		@T2 = @enddate,	
		@D2 = @bgnqty,	
		@D3 = @endqty
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取物品表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@SortSubCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品条码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@BarCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@bgnqty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@endqty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否消耗品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_M_GetList', @level2type=N'PARAMETER',@level2name=N'@IsConsum'
GO
