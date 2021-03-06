USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesPay_GetModel_By_Kid]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：根据幼儿园Kid获取该幼儿园客户申请成长档案需要的智慧豆和金额
--项目名称：com.zgyey.ArchivesApply
--说明：不同幼儿园客户申请成长档案需要的智慧豆和金额不同
--时间：2013-1-15 12:43:20
------------------------------------
CREATE PROCEDURE [dbo].[ArchivesPay_GetModel_By_Kid]
@kId int
 AS 
 
select archives_pay_id,kid,apply_money,bean_count from archives_pay
where kid=@kId

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
		RETURN(1)
	END






GO
