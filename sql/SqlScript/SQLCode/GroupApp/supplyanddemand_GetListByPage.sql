USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[supplyanddemand_GetListByPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询供求记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-26 15:00:28
------------------------------------
CREATE PROCEDURE [dbo].[supplyanddemand_GetListByPage]
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
		SELECT supplyanddemandid FROM [supplyanddemand] WHERE status=1 ORDER BY orderno 

		SET ROWCOUNT @size
		SELECT 	t1.supplyanddemandid,t1.companyid,t1.bloguserid,t1.content,t1.createdatetime,t1.orderno,t2.companyname,t3.nickname,t1.title
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			[supplyanddemand] t1  on tmptable.tmptableid=t1.supplyanddemandid
		left join 
			company t2 on t1.companyid=t2.companyid 
		left join blog..blog_user t3 on t1.bloguserid=t3.userid
		WHERE 
			row >  @ignore ORDER BY t1.orderno
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		t1.supplyanddemandid,t1.companyid,t1.bloguserid,t1.content,t1.createdatetime,t1.orderno,t2.companyname,t3.nickname,t1.title
		 FROM [supplyanddemand] t1 left join company t2 on t1.companyid=t2.companyid left join blog..blog_user t3 on t1.bloguserid=t3.userid
		 WHERE t1.status=1
		 ORDER BY t1.orderno
	END

GO
