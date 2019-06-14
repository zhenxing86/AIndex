USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManageattachs_GetList]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/29 17:05:42
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_SafeManageattachs_GetList]
@sid int,
@sname varchar(50)
 AS 
	SELECT 
	attachsid,sid,sname,title,filepath,[filename],filesize,filetype,createdatetime
	 FROM [SchoolBus_SafeManageattachs] where sid=@sid and sname=@sname


GO
