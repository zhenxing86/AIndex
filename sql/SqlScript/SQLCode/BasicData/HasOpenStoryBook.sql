USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[HasOpenStoryBook]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
--exec [class_getclassinfobyclassid] 18579
------------------------------------
CREATE  PROCEDURE [dbo].[HasOpenStoryBook]
@kid int,
@userid int
 AS 
declare @isvip_ysdw int
declare @isvip_status int
declare @hasvipcontrol int
declare @haskid int
declare @returnvalue int

select @isvip_ysdw =ptype from blogapp..permissionsetting t1 left join basicdata..[user] t2
on t1.kid=t2.kid where t2.userid=@userid and t1.ptype=98
select @hasvipcontrol=ptype from blogapp..permissionsetting where ptype=95 and kid=@kid

if(@isvip_ysdw>0)
begin
	if(@hasvipcontrol>0)
	begin
		select @isvip_status=vipstatus from basicdata..child where userid=@userid	
		if(@isvip_status>0)	
			set  @returnvalue =1
		else
			set  @returnvalue = 0
	end
	else
	begin
		select @haskid=ptype from blogapp..permissionsetting where ptype=99 and kid=@kid
	if(@haskid>0)
		set  @returnvalue = 1
	else
		set  @returnvalue = 0
	end
end
else
begin
	select @haskid=ptype from blogapp..permissionsetting where ptype=99 and kid=@kid
	if(@haskid>0)
		set  @returnvalue = 1
	else
		set  @returnvalue = 0
end
   -- print @returnvalue

  return 1

GO
