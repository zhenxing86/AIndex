USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[webtempplate_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[webtempplate_DeleteTag]
@id int
 AS 
	update  [webtempplate] set deletetag=0
	 WHERE ID=@id 



GO
