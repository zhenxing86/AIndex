USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetKinTotalReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-09-02>
-- Description:	<Description,,教工学籍管理>
-- =============================================
CREATE PROCEDURE [dbo].[GetKinTotalReport] 
	@sd nvarchar(30),
	@end nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;

select * into #actionlogtemp1 from t_actionlogs where actionmodule='登录' and actiondatetime between @sd and @end

select top 100 k.id, k.name as 幼儿园,
(select count(id) from t_class  where status = 1
	and kindergartenid = k.id ) as 班级,
(select count(userid) from t_child where status =1
	and kindergartenid = k.id ) as 幼儿,
(select count(id) from t_department where status=1
	and kindergartenid = k.id ) as 部门,
(select count(userid) from t_staffer where status=1
	and kindergartenid = k.id) as 老师,
(select count(mbid) from messageboard where kid=k.id and commenttime between @sd and @end) as 班级论坛贴子数,
(select count(l.id) from #actionlogtemp1 l inner join t_child c on l.actioner=c.userid
	where c.kindergartenid=k.id  and l.actiondatetime between @sd and @end) as 家长登录,
(select count(l.id) from #actionlogtemp1 l inner join t_staffer s on l.actioner=s.userid 
	inner join t_users u on s.userid=u.id  
	where u.usertype=1 and l.actionmodule='登录' and s.kindergartenid=k.id  and l.actiondatetime between @sd and @end) as 老师登录,
(select count(l.id) from #actionlogtemp1 l inner join t_staffer s on l.actioner=s.userid 
	inner join t_users u on s.userid=u.id  
	where u.usertype=98 and l.actionmodule='登录' and s.kindergartenid=k.id  and l.actiondatetime between @sd and @end) as 管理员登录,
(select count(l.id) from #actionlogtemp1 l inner join t_staffer s on l.actioner=s.userid 
	inner join t_users u on s.userid=u.id 
	where u.usertype=-1 and l.actionmodule='登录' and s.kindergartenid=k.id  and l.actiondatetime between @sd and @end) as 游客登录,
(select count(*) from doc_document_photo ddp left join doc_document dd on ddp.recordid = dd.recordid
	inner join t_class c on dd.classid =c.id 
	where c.kindergartenid=k.id and ddp.datecreated  between @sd and @end) as 班级相片数
from t_kindergarten k 
where k.status = 1 order by 家长登录 desc, 幼儿 desc, 老师 desc,班级 desc

drop table #actionlogtemp1
END


GO
