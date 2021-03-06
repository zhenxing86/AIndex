USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetEnterReadList]    Script Date: 2014/11/24 23:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-02-12
-- Description:	用于读取阅读计划报名人数
-- Memo:	
GetEnterReadList @Kid = 12511, @flag = 1, @cid = @cid
*/
CREATE PROCEDURE [dbo].[GetEnterReadList] 
	@Kid int,
	@flag int = 0, --0报名的姓名列表， 1交给老师的姓名列表
	@cid int = -1
AS
BEGIN
	SET NOCOUNT ON;	
	IF @flag = 0
	begin
		select UserID, Kid, Name 
			from sbapp..EnterRead 
			where kid = @Kid
	end
	if @flag = 1
	BEGIN	
		DECLARE @SQL NVARCHAR(MAX)
		DECLARE @bgndate datetime, @enddate datetime    
		SELECT @bgndate = bgndate, @enddate = enddate    
			FROM CommonFun.[dbo].getTerm_bgn_end(GETDATE(),@kid)  
			
		SET @SQL = N' 	
		SELECT UserID, Name, Cid, CName, CASE WHEN EXISTS(SELECT * 
						FROM payapp..order_record o
						where o.userid = uc.UserID 
						AND o.actiondatetime BETWEEN @bgndate And @enddate
						AND o.Status = 1
						AND o.[from] = ''809'') THEN 1 ELSE 0 END Status
			FROM BasicData..[User_Child] uc 
			WHERE uc.kid = @Kid
				AND EXISTS(
					SELECT * 
						FROM payapp..order_record o
						where o.userid = uc.UserID 
						AND o.actiondatetime BETWEEN @bgndate And @enddate
						AND o.PayType = 1
						AND o.[from] = ''809'' )
		'	
		IF @cid <> -1 
		SET @SQL = @SQL + ' AND uc.cid = @cid '
		EXEC SP_EXECUTESQL @SQL, 
			N'@Kid int,
				@bgndate datetime,
				@enddate datetime,
				@Cid int',
				@Kid = @Kid,
				@bgndate = @bgndate,
				@enddate = @enddate,
				@Cid = @Cid	
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用于读取阅读计划报名名单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetEnterReadList'
GO
