USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_sum_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_sum_DeleteTag]
@id int
 AS 
	update  [proxysettlement_sum] set deletetag=0
	 WHERE ID=@id 



GO
