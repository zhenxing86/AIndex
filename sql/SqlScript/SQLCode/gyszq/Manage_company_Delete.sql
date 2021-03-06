USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_company_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除商家 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-06 09:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_company_Delete] 
@companyid int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION

	DECLARE @companycategoryid int
	DECLARE @companystatus int
	DECLARE @status int
	SELECT @companycategoryid=companycategoryid,@companystatus=companystatus,@status=status FROM company WHERE companyid=@companyid

	DELETE t1 FROM productappraise t1 INNER JOIN  product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid
	DELETE t1 FROM productcomment t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid
	DELETE t1 FROM productphoto t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid	
	DELETE t1 FROM commonproduct t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid
	DELETE productcategory WHERE companyid=@companyid
	DELETE product WHERE companyid=@companyid
	DELETE t1 FROM activitycomment t1 INNER JOIN companyactivity t2 ON t1.activityid=t2.activityid WHERE t2.companyid=@companyid
	DELETE companyactivity WHERE companyid=@companyid
	DELETE companyappraise WHERE companyid=@companyid	
	DELETE companycomment WHERE companyid=@companyid
	DELETE companycontact WHERE	companyid=@companyid
	DELETE accesslog WHERE companyid=@companyid
	DELETE supplyanddemand WHERE companyid=@companyid
	DELETE commoncompany WHERE companyid=@companyid
	DELETE company	WHERE companyid=@companyid

	IF(@companystatus=1 AND @status=1)
	BEGIN
		UPDATE companycategory SET companycount=companycount-1 WHERE companycategoryid=@companycategoryid
	END
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END
GO
