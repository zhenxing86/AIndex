USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_teachertrain_Delete]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[group_teachertrain_Delete]
@id int
 AS 
	update  [group_teachertrain] set deletetag=0
	 WHERE ID=@id 








GO
