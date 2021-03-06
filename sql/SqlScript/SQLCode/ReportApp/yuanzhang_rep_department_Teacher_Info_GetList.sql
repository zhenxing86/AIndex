USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuanzhang_rep_department_Teacher_Info_GetList]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[yuanzhang_rep_department_Teacher_Info_GetList] 
	@kid int
as 

	select d.dname,u.userid,u.[name],u.gender,u.mobile,t.title,CONVERT(varchar(10),u.birthday,120)
		from BasicData..department d
			inner join BasicData..teacher t
				on t.did=d.did
			inner join BasicData..[user] u
				on t.userid=u.userid 
			where u.kid=@kid
				and d.deletetag=1
				and u.usertype=1  
				and u.deletetag=1
			order by d.[order]
				

GO
