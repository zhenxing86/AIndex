USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetEnterReadInfo]    Script Date: 2014/11/24 23:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-02-13
-- Description:	获取亲子阅读报名信息
-- Memo:	GetEnterReadInfo 295765,12511
*/
CREATE PROCEDURE [dbo].[GetEnterReadInfo]
	@userid int,
	@kid int 
AS
BEGIN
	SET NOCOUNT ON;
	declare @proxyprice int = 50, @Status int = 0
	select @proxyprice = proxyprice 
		from ossapp..feestandard 
		where kid = @kid 
			and a2 = 0 and a3 = 0 and a4 = 0 and a5 = 0 and a6 = 0 and a7 = 0 
			and a8 = 0 and a9 = 0 and a11 = 0 and a12 = 0 and a13 = 0 and a10 = 809
			
	DECLARE @bgndate datetime, @enddate datetime		
	SELECT @bgndate = bgndate, @enddate = enddate  
		FROM CommonFun.[dbo].getTerm_bgn_end(GETDATE(),@kid)  
	IF exists(select * from payapp..order_record WHERE userid = @userid AND [from] = '809' and status = 1 and actiondatetime BETWEEN @bgndate And @enddate)
	SET @Status = 2
	ELSE IF exists(select * from payapp..order_record WHERE userid = @userid AND [from] = '809' AND status = 0 AND PayType = 1 AND actiondatetime BETWEEN @bgndate And @enddate)
	SET @Status = 1
		
	select @Status Status,@proxyprice proxyprice
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取亲子阅读报名信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetEnterReadInfo'
GO
