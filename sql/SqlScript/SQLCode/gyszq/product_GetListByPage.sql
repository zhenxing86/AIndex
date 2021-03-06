USE gyszq
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-29
-- Description:	查询商品记录信息
-- Memo:		
*/
ALTER PROCEDURE dbo.product_GetListByPage
	@companyid int,
	@page int,
	@size int,
	@productcategoryid int
AS
BEGIN
	SET NOCOUNT ON 
	CREATE TABLE #productcategoryid(productcategoryid INT primary key) 
	
	IF(@productcategoryid>0)
	BEGIN
		INSERT INTO #productcategoryid
			SELECT productcategoryid 
				FROM productcategory 
				WHERE parentid = @productcategoryid
			UNION 
			SELECT @productcategoryid
	END
	DECLARE @fromstring NVARCHAR(2000)
		SET @fromstring = 'product p 
			 LEFT JOIN productcategory pc 
			 on p.productcategoryid=pc.productcategoryid
					LEFT JOIN commonproductcategory cc 
					on p.commonproductcategoryid=cc.commonproductcategoryid
			 WHERE p.companyid=@D1 
			 AND p.status=1 
			 '
			 
	if(@productcategoryid>0)
		SET @fromstring = @fromstring + 'AND exists(SELECT 1 FROM #productcategoryid WHERE p.productcategoryid=productcategoryid)'  	 
	ELSE IF(@productcategoryid=0)
		SET @fromstring = @fromstring
	ELSE 
		SET @fromstring = @fromstring + 'AND isnull(p.productcategoryid,0)=0 '
		
		exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集
			@selectstring = 
			'p.productid,p.companyid,p.title,p.description,p.imgpath,p.imgfilename,
			p.targethref,p.createdatetime,p.commentcount,p.imgcount,p.price,
			p.productcategoryid,p.viewcount,p.productappraisecount,p.recommend,
			pc.title as categorytitle,cc.title as commoncategorytitle',      --查询字段
			@returnstring = 
			'productid,companyid,title,description,imgpath,imgfilename,
			targethref,createdatetime,commentcount,imgcount,price,
			productcategoryid,viewcount,productappraisecount,recommend,
			categorytitle,commoncategorytitle',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' p.createdatetime DESC ',          --排序条件
			@IsRecordTotal = 0,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@D1 = @companyid
END
GO
