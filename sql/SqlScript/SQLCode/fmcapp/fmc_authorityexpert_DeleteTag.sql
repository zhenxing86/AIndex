USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[fmc_authorityexpert_DeleteTag]    Script Date: 06/18/2013 16:02:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：根据id删除专家讲坛信息
--项目名称：家庭教育中心 com.zgyey.fmcapp.cms  
--说明: 业务上的删除
--时间：2013-6-17 15:50:29
--exec fmc_authorityexpert_Delete 1
------------------------------------
ALTER PROCEDURE [dbo].[fmc_authorityexpert_DeleteTag]
@id int
 AS 
	update [fmc_authorityexpert] set deletetag=0
	 WHERE ID=@id 
	 
   update [fmc_expertsforum] set deletetag=0
	 WHERE expertid=@id 
