USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Apply_M_GetList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-26
-- Description:	
-- Memo:		
 Apply_M_GetList
	@kid = 12511,
	@page = 1,
	@size = 10,
	@AppType = 2,
	@AppSigNo = -1,
	@Status = 1,
	@userid = 288556,-- == 物管288556 -- 园长466920
	@AppName = null,
	@bgndate = null,
	@enddate = null	
*/
CREATE PROC [dbo].[Apply_M_GetList]
	@kid int,
	@page int,
	@size int,
	@AppType int,
	@AppSigNo int,
	@Status int,
	@userid int,
	@AppName varchar(50) = null,
	@bgndate date = null,
	@enddate date = null	
AS
BEGIN
	SET NOCOUNT ON
	if @bgndate = '1900-01-01' set @bgndate = null	
	if @enddate = '1900-01-01' set @enddate = null	
	DECLARE 
		@fromstring NVARCHAR(4000),				--数据集
		@selectstring NVARCHAR(800),      --查询字段
		@returnstring NVARCHAR(800)       --返回字段
	SET @fromstring  = '
	Apply_M m
		OUTER APPLY(
				SELECT TOP(1) 1 Audit
				FROM Apply_D d 
					inner join Object_M o 
					on d.kid = o.kid 
					and d.BarCode = o.BarCode 
					inner join Sort s 
					on s.kid = o.kid 
					and s.SortCode = o.SortCode 
					and s.Audit = 1
				WHERE d.kid = m.kid
					and d.AppSigNo = m.AppSigNo
			)oa
		left join BasicData..[user] u on m.FirUserid = u.userid 
		left join BasicData..[user] u1 on m.AppUserID = u1.userid 
		left join BasicData..[user] u2 on m.AuditUserID = u2.userid 
		left join BasicData..[user] u3 on m.PassUserID = u3.userid 
		left join BasicData..[user] u4 on m.ChkUserID = u4.userid 
		left join BasicData..[user] u5 on m.NeedUserID = u5.userid 
		left join BasicData..[class] c on m.cid = c.cid 
	where	m.kid = @D1 
		and m.AppType = ' + CAST(@AppType AS VARCHAR(10))
	IF @AppSigNo <> -1 SET @fromstring = @fromstring + '
			AND m.AppSigNo = @D3'  
	IF ISNULL(@AppName,'') <> '' SET @fromstring = @fromstring + '
			AND u1.name = @S1'  
	IF @Status <> -1 SET @fromstring = @fromstring + '
			AND m.Status = @D4'  
	IF @bgndate IS NOT NULL SET @fromstring = @fromstring + '
			AND m.FirDate >= @T1'  
	IF @enddate IS NOT NULL SET @fromstring = @fromstring + '
			AND m.FirDate < DATEADD(DD,1,@T2)' 
	IF CommonFun.dbo.GetRight(@kid, @userid, '物品管理员') = 1
		SET @fromstring = @fromstring + ' ' 
	ELSE 
		SET @fromstring = @fromstring + '
			AND (m.AppUserID = @D2 or m.AuditUserID = @D2) ' 
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		'm.ID, m.AppSigNo, m.Title, u.name FirName, m.FirDate, u1.name AppName, c.cname,
		m.AppDate, u2.name AuditName, m.AuditDate, u3.name PassName,
		m.PassDate, u4.name ChkName, m.ChkDate, m.Memo, m.Status, m.RetDate, u5.Name NeedName, 
		m.NeedDate, ISNULL(oa.Audit,0) Audit, u2.userid AuditUserID',      --查询字段
		@returnstring = 
		'ID, AppSigNo, Title, FirName, FirDate, AppName, cname,	AppDate, AuditName, 
		AuditDate, PassName, PassDate, ChkName, ChkDate, Memo, Status, RetDate, NeedName, NeedDate, Audit, AuditUserID',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' m.AppSigNo desc',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid,	
		@D2 = @userid,
		@D3 = @AppSigNo,
		@D4 = @Status,
		@T1 = @bgndate,	
		@T2 = @enddate,	
		@S1 = @AppName
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取领用（借用）主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请类型(1借用,2领用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@AppType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@AppSigNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前状态(0未提交申请、1申请已提交，等待管理员确认、2等待园长审批、3园长已审批，等待管理员确认、4等待领取、5已出库、6部分归还、7全部归还(包括损毁、遗失))' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请人姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@AppName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetList', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
