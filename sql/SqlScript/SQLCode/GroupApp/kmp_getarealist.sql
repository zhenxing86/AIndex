USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[kmp_getarealist]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取地区列表
--项目名称：zgyeyblog
--说明：
--时间：2008-10-21 07:54:31
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[kmp_getarealist]
	@superior int
 AS 
	select id,title,superior,level,code From [kmp]..[t_area] where superior=@superior





GO
