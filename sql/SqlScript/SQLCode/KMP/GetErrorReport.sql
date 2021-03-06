USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetErrorReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,短信发送情况>
-- =============================================
create PROCEDURE [dbo].[GetErrorReport] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select actioner as 操作者,actiondesc as 错误信息, actionmodule as 模块, 
actionobjectid as 幼儿园ID,actionerIP as ip, actiondatetime as 时间
 from t_actionlogs 
where actiontype = 'Error' and actiondatetime between @sd and @ed
order by actiondatetime desc
END


GO
