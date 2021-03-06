USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetJGXJGL]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-09-02>
-- Description:	<Description,,教工学籍管理>
-- =============================================
create PROCEDURE [dbo].[GetJGXJGL] 
	@sd nvarchar(30),
	@end nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select k.id, k.name as 幼儿园,
(select count(id) from t_actionlogs where (actionmodule='教工管理' or actionmodule='学籍管理')
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 教工学籍管理,
(select count(id) from t_actionlogs where actiontype ='教工花名册' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 教工花名册,
(select count(id) from t_actionlogs where actiontype ='组织架构' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 组织架构,
(select count(id) from t_actionlogs where actiontype ='班级管理' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 班级管理,
(select count(id) from t_actionlogs where actiontype ='幼儿花名册' 
	and actionobjectid = k.id and actiondatetime between @sd and @end) as 幼儿花名册
from t_kindergarten k 
where k.status = 1 order by 教工学籍管理 desc
END



GO
