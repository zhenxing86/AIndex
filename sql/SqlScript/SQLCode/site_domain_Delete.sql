USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_Delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[site_domain_Delete]
@ID int
as

delete KWebCMS..site_domain
where id=@ID



GO
