USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_Delete]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--鐢ㄩ€旓細鍒犻櫎涓€鏉¤褰?
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[cms_category_Delete]
@id int
 AS 
	DELETE [cms_category]
	 WHERE catid=@id 








GO
