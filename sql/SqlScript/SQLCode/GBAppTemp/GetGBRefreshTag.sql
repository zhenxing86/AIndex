USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetGBRefreshTag]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[GetGBRefreshTag]
@gbid int
 AS 	


	if exists(select 1 from gbrefreshtag where gbid=@gbid)
	begin
		delete gbrefreshtag where gbid=@gbid
		return 1
	end
	else
	begin
		return -1
	end
GO
