USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[feestandard_Delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Delete
------------------------------------
CREATE PROCEDURE [dbo].[feestandard_Delete]
@id int
 AS 
	DELETE [feestandard]
	 WHERE ID=@id 



GO
