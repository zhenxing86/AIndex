USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productphoto_GetListByPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询商品图片记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 11:04:18
------------------------------------
CREATE PROCEDURE [dbo].[productphoto_GetListByPage]
@productid int,
@page int,
@size int
 AS 
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT productphotoid FROM productphoto WHERE productid=@productid and status=1 ORDER BY orderno desc

		SET ROWCOUNT @size
		SELECT productphotoid,productid,imgname,imgpath,imgfile,orderno,uploaddatetime
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			productphoto t1 ON tmptable.tmptableid=t1.productphotoid
		WHERE 
			row >  @ignore ORDER BY orderno 
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		productphotoid,productid,imgname,imgpath,imgfile,orderno,uploaddatetime
		 FROM [productphoto] WHERE productid=@productid and status=1 ORDER BY orderno desc
	END


GO
