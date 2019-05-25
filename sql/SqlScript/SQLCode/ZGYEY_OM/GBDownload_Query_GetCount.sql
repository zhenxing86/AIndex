USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[GBDownload_Query_GetCount]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--select * from ebook..gbdownloadlist where status=3
------------------------------------
CREATE PROCEDURE [dbo].[GBDownload_Query_GetCount]
@time_star datetime,
@time_end datetime,
@status int
 AS 
	DECLARE @TempID int
	
SELECT
         @TempID=count(1) from EBook..gbdownloadlist where applydate between @time_star and @time_end-- and status=@status	
	RETURN @TempID		















GO
