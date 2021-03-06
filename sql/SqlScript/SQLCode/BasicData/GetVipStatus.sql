USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetVipStatus]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
-- 
--项目名称：
--说明：
--时间：2011-5-20 16:57:46
------------------------------------
CREATE PROCEDURE [dbo].[GetVipStatus]
@userid int
 AS 
	declare @vipstatus int
	
	if exists (select * from blogapp..permissionsetting t1 left join basicdata..[user] t2 on t1.kid=t2.kid  where 
	t2.userid=@userid and t1.ptype=25)
	begin
		RETURN 1
	end
	else
	begin
		select @vipstatus=vipstatus from basicdata..child where userid=@userid
		if(@vipstatus is not null)
		begin
			RETURN @vipstatus
		end
		else
		begin	
			RETURN 0
		end

	end

GO
