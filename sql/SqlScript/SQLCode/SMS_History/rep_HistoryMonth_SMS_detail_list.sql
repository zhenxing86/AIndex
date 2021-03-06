USE [SMS_History]
GO
/****** Object:  StoredProcedure [dbo].[rep_HistoryMonth_SMS_detail_list]    Script Date: 2014/11/24 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-05-29
-- Description:	过程返回发送短信的 小朋友姓名和手机号码列表
-- Paradef: 
-- Memo:	
exec rep_HistoryMonth_SMS_detail_list 60,1,10
	
*/ 
CREATE PROCEDURE [dbo].[rep_HistoryMonth_SMS_detail_list] 
	@taskid int,
	@page int,
	@size int
AS 
BEGIN
-- 
    DECLARE @beginRow INT
    DECLARE @endRow INT
    DECLARE @pcount INT
    
    SET @beginRow = (@page - 1) * @size    + 1
    SET @endRow = @page * @size		
		
			
    SELECT pcount, uname, mobile
			FROM 
					(
						SELECT	ROW_NUMBER() OVER(order by u.name) AS rows, 
										COUNT(1)over() as pcount, u.name as uname, u.mobile
							from dbo.sms_message sm
								inner join BasicData..[user] u 
									on sm.recuserid = u.userid
									AND sm.taskid = @taskid
					) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow


END    

GO
