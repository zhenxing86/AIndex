USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_GetModel]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/2/6 11:47:05
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_GetModel] 
@nid int
 AS 
	SELECT 
	nid,title,[content],istype,inuserid,g.intime,[username],p_kid,[dbo].[GetknameByid](p_kid)
	 FROM [group_notice] g left join group_user on inuserid=userid
	 WHERE nid=@nid 



GO
