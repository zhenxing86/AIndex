USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_noticeattachs_GetModel]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/2/6 14:22:20
------------------------------------
CREATE PROCEDURE [dbo].[group_noticeattachs_GetModel]
@attachsid int
 AS 
	SELECT 
	attachsid,nid,title,filepath,filename,filesize,filetype,createdatetime
	 FROM [group_noticeattachs]
	 WHERE attachsid=@attachsid 








GO
