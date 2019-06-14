USE [GameApp]
GO
/****** Object:  StoredProcedure [dbo].[IsPay]    Script Date: 2014/11/24 23:07:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsPay]
@userid int,
@gradeid int
 AS 

declare @result int
declare @isvip_ysdw int
declare @isvip_status int
select @isvip_status=vipstatus from basicdata..child where userid=@userid
select @isvip_ysdw =ptype from blogapp..permissionsetting t1 left join basicdata..[user] t2
on t1.kid=t2.kid where t2.userid=@userid and t1.ptype=97

declare @cdky int
select @cdky =ptype from blogapp..permissionsetting t1 left join basicdata..[user] t2
on t1.kid=t2.kid where t2.userid=@userid and t1.ptype=81


if((@isvip_status>0 and @isvip_ysdw=97) or @cdky>0)
begin
	return 1
end
else
begin
	select @result = count(*) from lq_paydetail where userid=@userid and lq_gradeid=@gradeid
end
	return @result

GO
