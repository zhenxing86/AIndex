USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_baseinfo_DeleteTag]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[group_baseinfo_DeleteTag]
@gid int
 AS 
	update  [group_baseinfo] set deletetag=0
	 WHERE gid=@gid 








GO
