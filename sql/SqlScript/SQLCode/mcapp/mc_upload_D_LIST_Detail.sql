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
mc_upload_D_LIST_Detail 12511,'2013-02-01',0

*/
CREATE PROC mc_upload_D_LIST_Detail
	@kid int,
	@cdate datetime,
	@uploaddate datetime,
	@type int
AS
BEGIN
	SET NOCOUNT ON
	IF @type = 0
	SELECT ub.name, sm.cdate, sm.tw, sm.zz
		from stu_mc_month sm
			inner join BasicData.dbo.[user] u 
				on sm.stuid = u.userid 
				and u.kid = @kid
			inner join BasicData.dbo.[user_baseinfo] ub
				on u.userid = ub.userid 
		WHERE sm.cdate >= CONVERT(VARCHAR(10),@cdate,120)
			and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@cdate),120)
			and CONVERT(VARCHAR(16),sm.adate,120) = CONVERT(VARCHAR(16),@uploaddate,120)
			and (ISNULL(sm.tw,'0') <> '0' or ISNULL(sm.zz,'') <> ''	)	
	IF @type = 1
	SELECT ub.name, sm.cdate, cast(null as varchar(50))tw, cast(null as varchar(50)) zz
		from stu_month_a_V sm
			inner join BasicData.dbo.[user] u 
				on sm.stuid = u.userid 
				and u.kid = @kid
			inner join BasicData.dbo.[user_baseinfo] ub
				on u.userid = ub.userid  
		WHERE sm.cdate >= CONVERT(VARCHAR(10),@cdate,120)
			and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@cdate),120)
			and CONVERT(VARCHAR(16),sm.adate,120) = CONVERT(VARCHAR(16),@uploaddate,120)
	IF @type = 2
	SELECT ub.name, sm.cdate, cast(null as varchar(50))tw, cast(null as varchar(50)) zz
		from tea_at_month sm
			inner join BasicData.dbo.[user] u 
				on sm.teaid = u.userid 
				and u.kid = @kid
			inner join BasicData.dbo.[user_baseinfo] ub
				on u.userid = ub.userid  
		WHERE sm.cdate >= CONVERT(VARCHAR(10),@cdate,120)
			and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@cdate),120)
			and CONVERT(VARCHAR(16),sm.adate,120) = CONVERT(VARCHAR(16),@uploaddate,120)
END
GO

exec mc_upload_D_LIST 12511,'2013-02-01',0
exec mc_upload_D_LIST_Detail 12511,'2013-02-01','2013-02-01 12:11:00.000',0