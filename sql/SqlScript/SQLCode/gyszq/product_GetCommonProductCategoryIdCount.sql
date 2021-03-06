USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetCommonProductCategoryIdCount]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-08
-- Description:	查询专区显示商品列表 数
-- Memo:	项目名称：ServicePlatform  	
*/  
CREATE PROCEDURE [dbo].[product_GetCommonProductCategoryIdCount]  
	@commonproductcategoryid int  
AS
BEGIN 
	SET NOCOUNT ON 
	
	DECLARE @count int  

 ;with cet as
 (
		select @commonproductcategoryid as commonproductcategoryid
		union
		select commonproductcategoryid 
			from commonproductcategory 
			where parentid = @commonproductcategoryid 
 ) 
	SELECT @count = count(1) 
		FROM product t1 
			INNER JOIN company t2 
			ON t1.companyid = t2.companyid 
			inner join cet c 
			on t1.commonproductcategoryid = c.commonproductcategoryid
		WHERE t1.status = 1 
			and t2.status = 1 
 
	RETURN @count  

END
GO
