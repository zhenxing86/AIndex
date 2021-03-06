USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_kindergarten_enrollmentreason]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[rep_mc_kindergarten_enrollmentreason] 12511,'1900-1-1','2900-1-1'
CREATE PROCEDURE [dbo].[rep_mc_kindergarten_enrollmentreason] 
@kid int,
@time1 datetime,
@time2 datetime
as 

select Caption,COUNT(userid) 
	from BasicData..dict_xml 
		outer apply 
		(
			select u.userid 
			from BasicData..[user] u 
			where kid=@kid 
				and enrollmentdate between @time1 and @time2
				and enrollmentreason in (Caption,Code)
				and u.deletetag=1
		) as cet
	where [Catalog]='入园原因' group by Caption
	
union all

select '其他',COUNT(1) 
from BasicData..[user] u 
	where kid=@kid 
	and u.deletetag=1
	and enrollmentdate between @time1 and @time2
	and (enrollmentreason is null or enrollmentreason ='')

GO
