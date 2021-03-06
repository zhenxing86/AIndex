USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Base_ADD]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2012/2/16 11:39:06
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Base_ADD]
@kid int,
@number nvarchar(50),
@regtime datetime,
@unitname nvarchar(50),
@cartype nvarchar(50),
@carcolor nvarchar(50),
@ishandle nvarchar(10),
@allowtime nvarchar(50),
@allowman int,
@transfer int,
@transfertimes int,
@transferneedtime int,
@transferalltime int,
@transferman int,
@information nvarchar(500),
@stronginsuran nvarchar(50),
@otherinsuran nvarchar(50),
@maninsuran nvarchar(50),
@numinsuran nvarchar(50),
@inuserid int

 AS 
	INSERT INTO [SchoolBus_Base](
	[kid],[number],[regtime],[unitname],[cartype],[carcolor],[ishandle],[allowtime],[allowman],[transfer],[transfertimes],[transferneedtime],[transferalltime],[transferman],[information],[stronginsuran],[otherinsuran],[maninsuran],numinsuran,[inuserid],[intime],deletetag
	)VALUES(
	@kid,@number,@regtime,@unitname,@cartype,@carcolor,@ishandle,@allowtime,@allowman,@transfer,@transfertimes,@transferneedtime,@transferalltime,@transferman,@information,@stronginsuran,@otherinsuran,@maninsuran,@numinsuran,@inuserid,getdate(),1
	)
	return  @@IDENTITY





GO
