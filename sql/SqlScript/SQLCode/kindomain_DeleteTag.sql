USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kindomain_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[kindomain_DeleteTag]
@id int
 AS 
	update  [kindomain] set status=0
	 WHERE id=@id 



GO
