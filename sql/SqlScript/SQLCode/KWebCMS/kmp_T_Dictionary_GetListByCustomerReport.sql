USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_Dictionary_GetListByCustomerReport]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-08-11
-- Description:	客户情况统计表所有数据字典类型
-- =============================================
create PROCEDURE [dbo].[kmp_T_Dictionary_GetListByCustomerReport]
AS
BEGIN
	SELECT ID,Caption,'count'=count(kid) FROM zgyey_OM..kindergarten_attach_info k,zgyey_OM..T_Dictionary t
	WHERE ContractStatus=t.ID OR Customer_Desc=t.ID OR Content_Desc=t.ID 
	OR Register_Source=t.ID OR Real_Source=t.ID OR Agent_Desc=t.ID
	GROUP BY Caption,t.ID
	ORDER BY t.ID ASC
END






GO
