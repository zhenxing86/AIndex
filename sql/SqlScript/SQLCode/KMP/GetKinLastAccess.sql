USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinLastAccess]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,幼儿园last访问报表2>
-- =============================================
CREATE PROCEDURE [dbo].[GetKinLastAccess] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select t2.id, t2.name as 幼儿园名,t2.actiondate as 注册时间,
(select top 1 actiondatetime from t_actionlogs where actionobjectid = t2.id and actiontype='平台登录'  order by actiondatetime desc) as 最后一次登录平台,
(select top 1 CreateTime  from siteaccessdetail where KID = t2.id order by CreateTime desc) as 最后一次访问幼儿园网站
from t_kindergarten t2  where t2.status = 1
order by 最后一次访问幼儿园网站 desc
END





GO
