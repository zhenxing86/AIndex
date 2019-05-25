USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[rep_CurrentMonth_SMS_detail]    Script Date: 07/03/2013 09:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      MasterÌ·
-- Create date: 2013-05-30
-- Description:	
-- Paradef: 
-- Memo:	
exec rep_CurrentMonth_SMS_detail 0,'2013-06-01', '2013-06-14',12511,-1, 1,5	
*/ 
ALTER PROCEDURE [dbo].[rep_CurrentMonth_SMS_detail] 
	@issended int, -- 0ÒÑ·¢ËÍ£¬1´ý·¢ËÍ
	@bgndate datetime,
	@enddate datetime,
	@kid int,
	@cid int,
	@page int,
	@size int
AS 
BEGIN
    DECLARE @beginRow INT
    DECLARE @endRow INT
    DECLARE @pcount INT
    SET @beginRow = (@page - 1) * @size + 1
    SET @endRow = @page * @size		

			SELECT pcount,taskid, name, smscontent, sendtime, sendusercount,sendsmscount
				FROM 
						(
							SELECT	ROW_NUMBER() OVER(order by sb.sendtime desc) AS rows, 
											COUNT(1)over() as pcount ,sb.taskid, u.name, 
											sb.smscontent, sb.sendtime, sendusercount,sendsmscount
								from sms_batch sb
									inner join BasicData.dbo.[user]   u
										on sb.sender = u.userid 
										and sb.cid = @cid
								where sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
									AND sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
									and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = @issended  
									and sb.kid = @kid
						) AS main_temp 
				WHERE rows BETWEEN @beginRow AND @endRow		

END	
GO

--exec rep_CurrentMonth_SMS_detail 0,'2013-06-01', '2013-07-14',12511,-1,1,15	