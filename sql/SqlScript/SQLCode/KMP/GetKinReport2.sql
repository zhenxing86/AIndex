USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinReport2]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,最新加入幼儿园报表2>
-- =============================================
CREATE PROCEDURE [dbo].[GetKinReport2] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN

	
	SET NOCOUNT ON;
	select k.id, k.name as 幼儿园名 , 
(select top 1 t_users.loginname from t_staffer , t_users where t_users.id = t_staffer.userid
 and t_staffer.kindergartenid = k.id and t_users.usertype = 98) as 管理员登录名,
(select top 1 t_users.password from t_staffer , t_users where t_users.id = t_staffer.userid
 and t_staffer.kindergartenid = k.id and t_users.usertype = 98) as 密码,
k.url as 网址,
k.actiondate as 注册时间
 from t_kindergarten k where k.status = 1
 and actiondate between @sd and @ed order by k.id desc
END


GO
