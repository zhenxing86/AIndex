USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_VIPDataCheckUser]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：从Excel导VIP数据
--项目名称：kmp
--说明：
------------------------------------
CREATE PROCEDURE [dbo].[Manage_VIPDataCheckUser]
@loginname nvarchar(200)
AS
	DECLARE @count int
	SELECT @count=count(1) FROM basicdata.dbo.[user] WHERE account=@loginname AND deletetag=1 
	IF(@count<>0)
	BEGIN
		RETURN (1)
	END
	ELSE
	BEGIN
		RETURN (-1)
	END






GO
