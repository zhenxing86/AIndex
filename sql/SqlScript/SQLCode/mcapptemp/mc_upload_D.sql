USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_upload_D]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
mc_upload_D 12511,'2013-02-01','2013-02-01'

*/
CREATE PROC [dbo].[mc_upload_D]
	@kid int,
	@bgndate datetime, 
	@enddate datetime
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @totalcnt int
	CREATE TABLE #T(cdate datetime, weekname varchar(10), uploadcnt int, totalcnt int)  	
	
	select @totalcnt = kc.Totalcnt 
		from BasicData.dbo.ChildCnt_ForKid kc 
		where kc.kid = @kid
	
	INSERT INTO #T(cdate, weekname, uploadcnt, totalcnt) 
		SELECT	CONVERT(VARCHAR(10),cdate,120), datename(dw,cdate), 
						count(distinct stuid), @totalcnt 
			from stu_at_all_V 
			WHERE kid = @kid	
				and cdate >= CONVERT(VARCHAR(10),@bgndate,120)
				and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)	
			GROUP BY CONVERT(VARCHAR(10),cdate,120), datename(dw,cdate)
		
	select cdate, weekname, uploadcnt, totalcnt, CAST(1.0*uploadcnt/totalcnt as numeric(9,4)) uploadrate 
		from #T
		ORDER BY cdate
	
END

GO
