USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetKindergartenListOnTimeCount]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	按日期幼儿园列表总数
-- Memo:
DECLARE @T INT
EXEC @T = Manage_GetKindergartenListOnTimeCount '2013-05-05','2013-06-05'
SELECT @T

*/ 
CREATE PROCEDURE [dbo].[Manage_GetKindergartenListOnTimeCount]
@begintime datetime,
@endtime datetime
 AS
BEGIN 
	SET NOCOUNT ON
		DECLARE @TempID int
		select
			 @TempID=count(1)
		FROM
			 basicdata.dbo.Kindergarten k 
					INNER JOIN basicdata.dbo.[user] u 
						ON k.kid=u.kid
					WHERE k.ActionDate BETWEEN @begintime AND @endtime 
						AND u.UserType=98 
						and k.deletetag=1
	RETURN @TempID
END

GO
