USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portal_company_GetListByProductCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[portal_company_GetListByProductCount]
@count INT
 AS 

exec gyszq..[company_GetListByProductCount] @count
GO
