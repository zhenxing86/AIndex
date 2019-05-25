USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[site_domain_GetModel]
@id int
as

 select 1,d.ID,d.siteid,domain
,case when d.domain=s.sitedns then 1 else 0 end isdefault
 from kwebcms.dbo.site_domain d
inner join   Kwebcms..site s on d.siteid=s.siteid 

where d.id=@id



GO
