USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_kindergarten_leavecount]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_mc_kindergarten_leavecount] 
@kid int,
@time1 datetime,
@time2 datetime
as 

	select convert(varchar(7),StartT,120),COUNT(lk.userid) 
	from [CommonFun].dbo.[fn_MonthList] (1,0) 
		left join BasicData..leave_kindergarten lk on convert(varchar(7),lk.outtime,120)=convert(varchar(7),StartT,120) and lk.kid=@kid 
	where StartT between @time1 and @time2
	group by convert(varchar(7),StartT,120)

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离园计数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mc_kindergarten_leavecount'
GO
