USE [SMS_History]
GO
/****** Object:  StoredProcedure [dbo].[rep_HistoryMonth_SMS_detail]    Script Date: 2014/11/24 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-05-30
-- Description:	
-- Paradef: 
-- Memo:	
exec rep_HistoryMonth_SMS_detail '2013-05-01', '2013-05-31',12511,0, 1,5	
*/ 
CREATE PROCEDURE [dbo].[rep_HistoryMonth_SMS_detail] 
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
						SELECT	ROW_NUMBER() OVER(order by sb.sendtime) AS rows, 
										COUNT(1)over() as pcount ,sb.taskid, u.name, 
										sb.smscontent, sb.sendtime, sendusercount,sendsmscount
							from DBO.sms_batch sb
								inner join BasicData.dbo.[user] u 
									on sb.sender = u.userid 
									and sb.cid = @cid
							where sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
								AND sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
								and sb.kid = @kid
					) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow
		
END	

GO
