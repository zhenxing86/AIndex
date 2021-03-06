USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinLoginReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-09-01>
-- Description:	<Description,,幼儿园登录报表>
-- =============================================
CREATE PROCEDURE [dbo].[GetKinLoginReport] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select ROW_NUMBER() OVER (ORDER BY t1.actiondatetime desc) AS 序号, t2.id as id, t2.name as 幼儿园, t3.loginname as 登录名,
t1.actiondatetime as 登录时间, t1.actionerip as IP ,
case t3.UserType when 98 then '管理员' when 1 then '老师' else '家长' end as 用户类型
from t_actionlogs t1 
left join t_kindergarten t2 on t1.actionobjectid = t2.id 
right join t_users t3  on t1.actioner = t3.id
where (actiontype = '平台登录' or actiontype = '家园互动登录' or actiontype = '门户登录') and actioner <> 1 
and t1.actiondatetime between @sd and @ed
order by t1.actiondatetime desc
END









GO
