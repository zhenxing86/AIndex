USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[site_domain_Update]
@ID int,
@siteid int,
@domain varchar(300)
as

update KWebCMS..site_domain
set 
siteid=@siteid
,domain=@domain where id=@ID


GO
