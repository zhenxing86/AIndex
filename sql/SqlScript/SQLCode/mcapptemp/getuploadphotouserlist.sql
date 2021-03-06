USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[getuploadphotouserlist]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[getuploadphotouserlist] 12511,'001251101'
CREATE PROCEDURE [dbo].[getuploadphotouserlist]
	@kid int,
	@devid varchar(10)
 AS 
BEGIN 
	SET NOCOUNT ON
	select mas.stuid, mad.photodate 
		from mc_applyphoto ma  
			join mc_applyphoto_stuid mas
				on ma.mc_pid = mas.mc_pid
			join mc_applyphoto_date mad
				on ma.mc_pid = mad.mc_pid
			join cardinfo c
				on mas.stuid = c.userid 
	where ma.applystate = 1 
		and c.kid = @kid
END


GO
