USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[rep_CurrentMonth_SMS_detail_list]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
-- Author:      Master谭
-- Create date: 2013-05-29
-- Description:	
-- Paradef: 
-- Memo:	
exec rep_CurrentMonth_SMS_detail_list 60,1,10
	
*/ 
CREATE PROCEDURE [dbo].[rep_CurrentMonth_SMS_detail_list] 
	@taskid int,
	@page int,
	@size int
AS 
BEGIN
-- 小朋友姓名和手机号码列表
--uname,mobile

    DECLARE @beginRow INT
    DECLARE @endRow INT
    DECLARE @pcount INT
    
    SET @beginRow = (@page - 1) * @size    + 1
    SET @endRow = @page * @size		
		
	;WITH CET AS
	(
		select recuserid as userid from  dbo.sms_message_ym where taskid = @taskid
		union all
		select recuserid from  dbo.sms_message_zy_ym where taskid = @taskid
		union all
		select recuserid from  dbo.sms_message where taskid = @taskid
		union all
		select recuserid from  dbo.sms_message_temp where taskid = @taskid
        union all
		select recuserid from  dbo.sms_message_curmonth where taskid = @taskid
	)					
			
    SELECT pcount, uname, mobile
			FROM 
					(
						SELECT	ROW_NUMBER() OVER(order by u.userid) AS rows, 
										COUNT(1)over() as pcount , u.name as uname, u.mobile
							from CET ul
								inner join BasicData..[user] u
									on ul.userid = u.userid
					) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow

END    


GO
