USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetChildInfoToExcel]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[sp_GetChildInfoToExcel]
@kid int
AS
	SELECT t3.name as classname, t1.name as username,dbo.DictionaryCaptionfromID(t1.gender) as gender, 
	t2.loginname, t1.mobile,t1.enrollmentdate,birthday
	FROM T_child t1, t_users t2, t_class t3 
	WHERE t1.userid=t2.id and t1.classid=t3.id and t1.kindergartenid=@kid
	and t1.status=1
	order by t3.[order]
GO
