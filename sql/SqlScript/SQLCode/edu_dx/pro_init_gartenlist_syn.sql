USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_gartenlist_syn]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[pro_init_gartenlist_syn]
 AS 
 update 
	 [gartenlist] set syn=1 where syn is null or syn<>1
GO
