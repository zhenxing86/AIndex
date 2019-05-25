USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[site_keyword_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[site_keyword_Update]
@siteid int,
@keyword varchar(1000),
@description varchar(5000),
@shortname varchar(500)
as
	update kwebcms..site set keyword=@keyword,description=@description
where siteid=@siteid

	update kwebcms..site_config set shortname=@shortname
where siteid=@siteid



GO
