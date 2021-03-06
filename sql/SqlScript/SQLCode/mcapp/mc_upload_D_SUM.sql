USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_upload_D_SUM]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
mc_upload_D_SUM 0,null

*/
CREATE PROC [dbo].[mc_upload_D_SUM]
	@kid int,
	@date date
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @stu_mc_cnt int, @stu_at_cnt int, @tea_at_cnt int
	
	SELECT @stu_at_cnt = COUNT(DISTINCT stuid)  
		from stu_at_all_V
		WHERE kid = @kid
			and cdate >= CONVERT(VARCHAR(10),@date,120)
			and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)	
			
	SELECT @stu_mc_cnt = COUNT(DISTINCT stuid)  
		from stu_mc_day
		WHERE kid = @kid
			and CheckDate = @date		

	SELECT @tea_at_cnt = COUNT(DISTINCT teaid)  
		from tea_at_all_V
		WHERE kid = @kid
			and cdate >= CONVERT(VARCHAR(10),@date,120)
			and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)	
	
	SELECT stu_mc_cnt = @stu_mc_cnt, stu_at_cnt = @stu_at_cnt, tea_at_cnt = @tea_at_cnt
	
	SELECT cast(CONVERT(VARCHAR(13),adate,120)+':00:00' AS DATETIME) uploaddate, count(1)uploadcnt
		from all_at_all_V
		WHERE kid = @kid
			and cdate >= CONVERT(VARCHAR(10),@date,120)
			and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
		GROUP BY CONVERT(VARCHAR(13),adate,120)
		ORDER BY uploaddate
	
		
END

GO
