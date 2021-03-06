USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinPTLoginTotal]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,幼儿园访问报表2>
-- =============================================
CREATE PROCEDURE [dbo].[GetKinPTLoginTotal] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select t2.id, t2.name as 幼儿园名, t2.actiondate as 注册时间, 
(select count(*) from t_actionlogs where actiontype='平台登录' and  actionobjectid = t2.id and actiondatetime between @sd and @ed) as 平台,
(select count(*) from t_actionlogs where actiontype='家园互动登录' and  actionobjectid = t2.id and actiondatetime between @sd and @ed) as 家园互动,
(select count(*) from t_actionlogs where actiontype='门户登录' and  actionobjectid = t2.id and actiondatetime between @sd and @ed) as 门户,
(select count(*) from t_actionlogs where actionmodule='登录' and  actionobjectid = t2.id and (actiontype='平台登录' or actiontype='家园互动登录' or actiontype='门户登录') and actiondatetime between @sd and @ed) as 总数,
(select count(*) from siteaccessdetail where KID = t2.id and CreateTime between @sd and @ed) as 网站,
(select top 1 CreateTime  from siteaccessdetail where KID = t2.id order by CreateTime desc) as 最后一次网站
from t_kindergarten t2  where t2.status = 1
 order by 总数 desc
END






GO
