USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Base_Update]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：修改一条记录 
--项目名称：
--说明：
--时间：2012/2/16 11:39:06
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Base_Update]
@ID int,
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
@inuserid int,
@intime datetime
 AS 
	UPDATE [SchoolBus_Base] SET 
	[kid] = @kid,[number] = @number,[regtime] = @regtime,[unitname] = @unitname,[cartype] = @cartype,[carcolor] = @carcolor,[ishandle] = @ishandle,[allowtime] = @allowtime,[allowman] = @allowman,[transfer] = @transfer,[transfertimes] = @transfertimes,[transferneedtime] = @transferneedtime,[transferalltime] = @transferalltime,[transferman] = @transferman,[information] = @information,[stronginsuran] = @stronginsuran,[otherinsuran] = @otherinsuran,[maninsuran] = @maninsuran,[inuserid] = @inuserid,numinsuran=@numinsuran
	WHERE ID=@ID 












GO
