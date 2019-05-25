USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManage_Update]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：修改一条记录 
--项目名称：
--说明：
--时间：2012/2/16 11:45:11
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_SafeManage_Update]
@ID int,
@bid int,
@childsafe nchar(10),
@teachersafe nchar(10),
@carsafe nchar(10),
@childinsuran nchar(10),
@childeducation nchar(10),
@teachereducation nchar(10),
@opinion varchar(2000),
@inuserid int,
@intime datetime
 AS 
	UPDATE [SchoolBus_SafeManage] SET 
	[bid] = @bid,[childsafe] = @childsafe,[teachersafe] = @teachersafe,[carsafe] = @carsafe,[childinsuran] = @childinsuran,[childeducation] = @childeducation,[teachereducation] = @teachereducation,[opinion] = @opinion,[inuserid] = @inuserid,[intime] = @intime
	WHERE ID=@ID 








GO
