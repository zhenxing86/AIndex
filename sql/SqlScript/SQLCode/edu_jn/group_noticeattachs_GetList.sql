USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_noticeattachs_GetList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/6 14:22:20
------------------------------------
CREATE PROCEDURE [dbo].[group_noticeattachs_GetList]
@nid int
 AS 
	SELECT 
	attachsid,nid,title,filepath,[filename],filesize,filetype,createdatetime
	 FROM [group_noticeattachs] where nid=@nid











GO
