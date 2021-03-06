USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinAccessTotal]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,幼儿园访问报表2>
-- =============================================
CREATE PROCEDURE [dbo].[GetKinAccessTotal] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select t2.url, t2.name as 幼儿园名, t2.actiondate as 注册时间, 
(select count(*) from siteaccessdetail where kid = t2.id and createtime between @sd and @ed) as 访问次数  
from t_kindergarten t2  where t2.status = 1
 order by 访问次数 desc
END



GO
