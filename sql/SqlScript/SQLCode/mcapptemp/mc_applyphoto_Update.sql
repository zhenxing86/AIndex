USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_applyphoto_Update]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[mc_applyphoto_Update] 
@mc_pid int
,@applystate int
 AS 

update dbo.mc_applyphoto set applystate=@applystate where mc_pid=@mc_pid



GO
