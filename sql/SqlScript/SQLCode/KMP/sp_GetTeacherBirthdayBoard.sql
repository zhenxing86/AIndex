USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTeacherBirthdayBoard]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_GetTeacherBirthdayBoard]
@KID int
AS
--	declare @KID int
--	set @KID=1170
	select userid, name from t_staffer 
	where datepart(mm,convert(datetime,birthday)) = datepart(mm,getdate()) and kindergartenid = @KID and status = 1



GO
