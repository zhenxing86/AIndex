USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[HBRemarkTemp_GetModel]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：storybook
--说明：
--时间：2011/11/20 21:20:08
------------------------------------
CREATE PROCEDURE [dbo].[HBRemarkTemp_GetModel]
@tempid int
 AS 
	SELECT 
	id,catid,tmptype,tmpcontent,status,lastUpdatetime
	 FROM hb_remark_temp
	 WHERE id=@tempid 

GO
