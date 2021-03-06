USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_VIPDataFromExcel]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：从Excel导VIP数据
--项目名称：kmp
--说明：
------------------------------------
CREATE PROCEDURE [dbo].[Manage_VIPDataFromExcel]
@loginname nvarchar(200),
@startdate datetime,
@enddate datetime
AS
	DECLARE @userid int
	SELECT @userid=userid FROM basicdata.dbo.[user] WHERE account=@loginname AND deletetag=1 
	IF(@userid is not null)
	BEGIN
		INSERT INTO zgyey_om.dbo.VIPDetails(UserId,IsCurrent,StartDate,EndDate,FeeAmount) values (@userid,1,@startdate,@enddate,0.00)
		UPDATE basicdata.dbo.child SET VIPStatus=1 WHERE userid=@userid

		INSERT INTO kwebcms.dbo.vipsetlog([userid],[startdate],[enddate],[actiondatetime],[dredgeStatus])
		VALUES(@userid,@startdate,@enddate,GETDATE(),1) 
	END
	ELSE
	BEGIN
		RETURN (-2)
	END

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END

GO
