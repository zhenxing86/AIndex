USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetListByCommonProductCategoryIdPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-28
-- Description:	查询专区显示商品列表
-- Memo:		
*/  
CREATE PROCEDURE [dbo].[product_GetListByCommonProductCategoryIdPage]
	@commonproductcategoryid int,  
	@page int,  
	@size int  
 AS   
BEGIN
	SET NOCOUNT ON 
select @commonproductcategoryid commonproductcategoryid
		into #T
	union 
	select distinct commonproductcategoryid 
		from commonproductcategory 
		where parentid=@commonproductcategoryid
exec	sp_MutiGridViewByPager
		@fromstring = 'product p 
			INNER JOIN company c 
				ON p.companyid=c.companyid  
			inner join #T t
				on t.commonproductcategoryid = p.commonproductcategoryid
		WHERE p.status = 1 
			and c.status = 1  ',      --数据集
		@selectstring = 
		'	p.productid, p.companyid, p.title, p.imgpath, p.imgfilename,
					p.targethref, p.createdatetime, c.companyname, c.shortname',      --查询字段
		@returnstring = 
		'	productid, companyid, title, imgpath, imgfilename,
					targethref, createdatetime, companyname, shortname',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' p.createdatetime  desc',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0										 --是否输出行号	

END

GO
