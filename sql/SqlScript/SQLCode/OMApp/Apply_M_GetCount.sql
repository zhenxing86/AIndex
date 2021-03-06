USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Apply_M_GetCount]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-26
-- Description:	
-- Memo:		
 Apply_M_GetCount
	@kid = 12511,
	@AppType = 0,
	@AppSigNo = 1310250001,
	@userid = 123,-- == 物管288556 -- 园长466920
	@AppName = '',
	@bgndate = null,
	@enddate = null	
*/
CREATE PROC [dbo].[Apply_M_GetCount]
	@kid int,
	@AppType int,
	@AppSigNo int,
	@userid int,
	@AppName varchar(50) = null,
	@bgndate date = null,
	@enddate date = null	
AS
BEGIN
	SET NOCOUNT ON
	IF ISNULL(@AppName, '') <> '' AND NOT EXISTS(SELECT * FROM BasicData..[User] where kid = @kid and name = @AppName)
	BEGIN
		SELECT TOP(0) 0 [Status], 0 CNT 
		RETURN
	END
	if @bgndate = '1900-01-01' set @bgndate = null	
	if @enddate = '1900-01-01' set @enddate = null	
	DECLARE @s NVARCHAR(2000), @ParmDefinition NVARCHAR(4000)  
	SET @s  = '
	SELECT i.Status, count(1)CNT
		FROM Apply_M i
			left join BasicData..[user] u1 on i.AppUserID = u1.userid 
		where	i.kid = @kid 
			and i.AppType = @AppType' 
	IF @AppSigNo <> -1 SET @s = @s + '
			AND i.AppSigNo = @AppSigNo'  
	IF ISNULL(@AppName, '') <> '' SET @s = @s + '
			AND u1.name = @AppName'  
	IF @bgndate IS NOT NULL SET @s = @s + '
			AND i.FirDate >= @bgndate'  
	IF @enddate IS NOT NULL SET @s = @s + '
			AND i.FirDate < DATEADD(DD, 1, @enddate)' 
	IF CommonFun.dbo.GetRight(@kid, @userid, '物品管理员') = 1
		SET @s = @s
	ELSE 
		SET @s = @s + '
			AND (i.AppUserID = @userid or (i.AuditUserID = @userid))' 
	SET @s = @s + ' 
	GROUP BY i.Status '

	SET @ParmDefinition = 
	N'	@kid INT = NULL,
			@userid INT = NULL, 
			@AppSigNo INT = NULL, 
			@AppType INT = NULL,
			@AppName varchar(50) = NULL,
			@bgndate DATETIME = NULL, 
			@enddate DATETIME = NULL';      
    --输出参数为总记录数			
		EXEC SP_EXECUTESQL @s,@ParmDefinition,
				@kid = @kid,
				@userid = @userid,
				@AppSigNo = @AppSigNo, 
				@AppType = @AppType, 
				@AppName = @AppName, 
				@bgndate = @bgndate, 
				@enddate = @enddate; 
    	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计算领用（借用）主表各状态的数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetCount', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请类型(1借用,2领用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetCount', @level2type=N'PARAMETER',@level2name=N'@AppType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetCount', @level2type=N'PARAMETER',@level2name=N'@AppSigNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetCount', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请人姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetCount', @level2type=N'PARAMETER',@level2name=N'@AppName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetCount', @level2type=N'PARAMETER',@level2name=N'@bgndate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_M_GetCount', @level2type=N'PARAMETER',@level2name=N'@enddate'
GO
