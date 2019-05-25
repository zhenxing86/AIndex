USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetAccessPeriod]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-09-07>
-- Description:	<Description,,模板使用统计>
-- =============================================
create PROCEDURE [dbo].[GetAccessPeriod] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select * from t_actionlogs where actiontype = '平台登录' and 
actioner not in ('1') and actionobjectid not in ('61','60','59','58','28') 
and actiondatetime between @sd and @ed
END
GO
