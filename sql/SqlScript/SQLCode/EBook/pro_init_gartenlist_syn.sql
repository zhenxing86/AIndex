USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_gartenlist_syn]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[pro_init_gartenlist_syn]
 AS 
 update 
	 [gartenlist] set syn=1 where syn is null or syn<>1
	    


GO
