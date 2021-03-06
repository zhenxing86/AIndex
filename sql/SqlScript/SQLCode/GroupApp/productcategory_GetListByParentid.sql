USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcategory_GetListByParentid]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[productcategory_GetListByParentid]
@companyid int,
@parentid int
 AS 
		SELECT 
		productcategoryid,companyid,title,parentid,orderno,createdate,display,(SELECT count(1) FROM [productcategory] WHERE parentid=t1.productcategoryid) as childcategorycount
		 FROM [productcategory] t1 where companyid=@companyid and parentid=@parentid ORDER BY orderno

GO
