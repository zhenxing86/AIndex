USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_partinfo_GetModel]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/2/6 11:34:55
------------------------------------
CREATE PROCEDURE [dbo].[group_partinfo_GetModel]
@pid int
 AS 
	SELECT 
	pid,gid,g_kid,p_kid,name,nickname,descript,logopic,mastername,inuserid,intime,[order],deletetag
	 FROM [group_partinfo]
	 WHERE pid=@pid 








GO
