USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[sitelog_count]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-13
-- Description:	幼儿园资料修改日志数量
-- =============================================
CREATE PROCEDURE [dbo].[sitelog_count] 
@begindate datetime,
@enddate datetime
AS
	DECLARE @count int
	SELECT @count=count(*) FROM site_log WHERE operDate BETWEEN @begindate AND @enddate
	RETURN @count


GO
