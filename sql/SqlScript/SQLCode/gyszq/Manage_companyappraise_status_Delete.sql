USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_companyappraise_status_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商家评价删除
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-15 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_companyappraise_status_Delete]
@companyappraiseid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION

	UPDATE t1 SET companyappraisecount=companyappraisecount-1 FROM company t1 INNER JOIN companyappraise t2 ON t1.companyid=t2.companyid WHERE t2.companyappraiseid=@companyappraiseid
	UPDATE companyappraise SET status=-1 WHERE companyappraiseid=@companyappraiseid

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
