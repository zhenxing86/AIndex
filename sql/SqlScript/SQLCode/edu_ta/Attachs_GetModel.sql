USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[Attachs_GetModel]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
CREATE PROCEDURE [dbo].[Attachs_GetModel]
  @pid int                      	
 AS 
	select * from [Attachs]
	 WHERE   [pid] = @pid   






GO
