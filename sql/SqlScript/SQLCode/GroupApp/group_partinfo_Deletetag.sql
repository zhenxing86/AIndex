USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_partinfo_Deletetag]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[group_partinfo_Deletetag]
@pid int
 AS 
	update  [group_partinfo] set deletetag=0
	 WHERE pid=@pid 



GO
