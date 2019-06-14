USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_Delete]    Script Date: 03/20/2014 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--Delete
------------------------------------
ALTER PROCEDURE [dbo].[kinbaseinfo_Delete]
@id int
 AS 
	DELETE [kinbaseinfo]  WHERE kid=@id 

update kwebcms..site set status=0 where siteid=@id

update basicdata..kindergarten set deletetag=0 where kid=@id 

delete kwebcms..site_domain where siteid=@id

update basicdata..[user] set deletetag=0 where kid=@id 

delete kwebcms..site_user where siteid=@id and usertype=98
