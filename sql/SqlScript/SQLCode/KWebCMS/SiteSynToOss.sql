USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[SiteSynToOss]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[SiteSynToOss] 

as

 if(exists(select 1 from synkid))
	begin
		exec ossapp..[init_kinbaseinfo]

		delete from synkid
	end


GO
