USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_kindergarten_enrollmentcount]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_mc_kindergarten_enrollmentcount] 
@kid int,
@time1 datetime,
@time2 datetime
as 

	select convert(varchar(7),StartT,120),COUNT(userid) 
	from [CommonFun].dbo.[fn_MonthList] (1,0) 
		outer apply(
			select u.userid 
			from  BasicData..[user] u 
			where kid=@kid 
			and convert(varchar(7),enrollmentdate,120)=convert(varchar(7),StartT,120)
			and u.deletetag=1
		) as cet
	where StartT between @time1 and @time2
	group by convert(varchar(7),StartT,120)

GO
