USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[pwdlog_count]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-13
-- Description:	密码修改日志数量
-- =============================================
CREATE PROCEDURE [dbo].[pwdlog_count] 
@begindate datetime,
@enddate datetime
AS
DECLARE @count int
	SELECT @count=count(*) FROM pwd_log WHERE operDate BETWEEN @begindate AND @enddate
	RETURN @count

GO
