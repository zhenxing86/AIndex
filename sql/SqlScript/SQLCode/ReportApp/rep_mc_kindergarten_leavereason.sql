USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_kindergarten_leavereason]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_mc_kindergarten_leavereason] 
@kid int,
@time1 datetime,
@time2 datetime
as 


select Caption,COUNT(userid) 
	from BasicData..dict_xml 
		outer apply 
		(
			select userid from BasicData..leave_kindergarten 
			where kid=@kid 
				and outtime between @time1 and @time2
				and leavereason in (Caption,Code)
		) as cet
	where [Catalog]='离园原因' group by Caption
	
union all

select '其他',COUNT(1) from BasicData..leave_kindergarten
	where kid=@kid 
	and outtime between @time1 and @time2
	and (leavereason is null or leavereason ='')

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离园理由统计' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mc_kindergarten_leavereason'
GO
