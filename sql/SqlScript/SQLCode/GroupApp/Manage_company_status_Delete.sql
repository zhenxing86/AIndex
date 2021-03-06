USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_company_status_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除商家 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-12 09:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_company_status_Delete] 
@companyid int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION

	DECLARE @companycategoryid int
	DECLARE @companystatus int
	DECLARE @status int
	SELECT @companycategoryid=companycategoryid,@companystatus=companystatus,@status=status FROM company WHERE companyid=@companyid
	
	IF(@status=1)
	BEGIN
		UPDATE t1 SET status=-1 FROM productappraise t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid
		UPDATE t1 SET status=-1 FROM productcomment t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid
		UPDATE t1 SET status=-1 FROM productphoto t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid
		UPDATE t1 SET status=-1 FROM commonproduct t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid
	--	DELETE productcategory WHERE companyid=@companyid
		UPDATE product SET status=-1 WHERE companyid=@companyid
		UPDATE t1 SET status=-1 FROM activitycomment t1 INNER JOIN companyactivity t2 ON t1.activityid=t2.activityid WHERE t2.companyid=@companyid
		UPDATE companyactivity SET status=-1 WHERE companyid=@companyid
		UPDATE companyappraise SET status=-1 WHERE companyid=@companyid
		UPDATE companycomment SET status=-1 WHERE companyid=@companyid
	--	DELETE companycontact WHERE	companyid=@companyid
	--	DELETE accesslog WHERE companyid=@companyid
		UPDATE supplyanddemand SET status=-1 WHERE companyid=@companyid
		UPDATE commoncompany SET status=-1 WHERE companyid=@companyid
		UPDATE company SET status=-1 WHERE companyid=@companyid
		IF(@companystatus=1 AND @status=1)
		BEGIN
			UPDATE companycategory SET companycount=companycount-1 WHERE companycategoryid=@companycategoryid
		END
	END
	ELSE
	BEGIN
		UPDATE t1 SET status=1 FROM productappraise t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid and t1.status=-1
		UPDATE t1 SET status=1 FROM productcomment t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid and t1.status=-1 
		UPDATE t1 SET status=1 FROM productphoto t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid and t1.status=-1
	--  UPDATE t1 SET status=1 FROM commonproduct t1 INNER JOIN product t2 ON t1.productid=t2.productid WHERE t2.companyid=@companyid and t1.status=-1
	--	DELETE productcategory WHERE companyid=@companyid
		UPDATE product SET status=1 WHERE companyid=@companyid and status=-1
		UPDATE t1 SET status=1 FROM activitycomment t1 INNER JOIN companyactivity t2 ON t1.activityid=t2.activityid WHERE t2.companyid=@companyid and t1.status=-1
		UPDATE companyactivity SET status=1 WHERE companyid=@companyid and status=-1
		UPDATE companyappraise SET status=1 WHERE companyid=@companyid and status=-1
		UPDATE companycomment SET status=1 WHERE companyid=@companyid and status=-1
	--	DELETE companycontact WHERE	companyid=@companyid
	--	DELETE accesslog WHERE companyid=@companyid
		UPDATE supplyanddemand SET status=1 WHERE companyid=@companyid and status=-1
	--	UPDATE commoncompany SET status=1 WHERE companyid=@companyid and status=-1
		UPDATE company SET status=1 WHERE companyid=@companyid and status=-1
		IF(@companystatus=1)
		BEGIN
			UPDATE companycategory SET companycount=companycount+1 WHERE companycategoryid=@companycategoryid
		END
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
