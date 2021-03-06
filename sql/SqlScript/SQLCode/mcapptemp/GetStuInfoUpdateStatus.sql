USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[GetStuInfoUpdateStatus]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012-10-16 21:55:38
--[GetStuInfoUpdateStatus] 12511,'000824700',0,'2013-08-09 09:02:01'
------------------------------------
CREATE PROCEDURE [dbo].[GetStuInfoUpdateStatus]
	@kid int,
	@devid varchar(10),
	@s_cnt int,
	@lupdate datetime
 AS
BEGIN
	SET NOCOUNT ON
	declare @client_stucnt int, @server_stucnt int
	if(@s_cnt = 0)
	begin
		set @lupdate = '2000-01-01';
	end	
		select @server_stucnt = COUNT(*) 
			from basicdata..User_Child u 			
				where u.kid = @kid 
					and u.updatetime >= @lupdate
		if(@server_stucnt = 0)
			select 0	
		else if(@s_cnt = 0 or @server_stucnt > 0)
			select 1
		else
			select 0
END

GO
