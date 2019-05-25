USE mcapp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 
-- Description:	
-- Memo:		
mc_upload_D_LIST 12511,'2013-02-01',0

*/
ALTER PROC mc_upload_D_LIST
	@kid int,
	@date datetime,
	@type int
AS
BEGIN
	SET NOCOUNT ON
	IF @type = 0
	SELECT cast(CONVERT(VARCHAR(16),sm.adate,120) AS DATETIME) uploaddate, count(1)uploadcnt
		from stu_mc_month sm
			inner join BasicData.dbo.[user] u 
				on sm.stuid = u.userid 
				and u.kid = @kid 
		WHERE sm.cdate >= CONVERT(VARCHAR(10),@date,120)
			and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
			and (ISNULL(sm.tw,'0') <> '0' or ISNULL(sm.zz,'') <> ''	)	
		GROUP BY CONVERT(VARCHAR(16),sm.adate,120)
		ORDER BY uploaddate
	IF @type = 1
	SELECT cast(CONVERT(VARCHAR(16),sm.adate,120) AS DATETIME) uploaddate, count(1)uploadcnt
		from stu_month_a_V sm
			inner join BasicData.dbo.[user] u 
				on sm.stuid = u.userid 
				and u.kid = @kid 
		WHERE sm.cdate >= CONVERT(VARCHAR(10),@date,120)
			and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
		GROUP BY CONVERT(VARCHAR(16),sm.adate,120)
		ORDER BY uploaddate
	IF @type = 2
	SELECT cast(CONVERT(VARCHAR(16),sm.adate,120) AS DATETIME) uploaddate, count(1)uploadcnt
		from tea_at_month sm
			inner join BasicData.dbo.[user] u 
				on sm.teaid = u.userid 
				and u.kid = @kid 
		WHERE sm.cdate >= CONVERT(VARCHAR(10),@date,120)
			and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
		GROUP BY CONVERT(VARCHAR(16),sm.adate,120)
		ORDER BY uploaddate
END
GO

exec mc_upload_D_LIST 12511,'2013-02-01',1