USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[keylog_DeleteTag]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[keylog_DeleteTag]
@id int
 AS 
	update  [keylog] set deletetag=0
	 WHERE ID=@id 





GO
