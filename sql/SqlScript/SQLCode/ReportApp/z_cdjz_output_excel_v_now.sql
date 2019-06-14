USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[z_cdjz_output_excel_v_now]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[z_cdjz_output_excel_v1]    Script Date: 03/24/2014 17:09:34 ******/

CREATE   PROCEDURE [dbo].[z_cdjz_output_excel_v_now]
@kid int
AS		

select k.kname,u.name,a.describe,a.ftime from basicdata..[user] u
left join ossapp..addservice a on a.[uid]=u.userid
left join BasicData..kindergarten k on u.kid=k.kid
inner join BasicData..user_class uc on uc.userid=u.userid
where u.kid=@kid and u.deletetag=1 and u.usertype=0
order by a.describe desc 
	

GO
