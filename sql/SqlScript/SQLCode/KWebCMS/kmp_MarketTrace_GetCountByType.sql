USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_MarketTrace_GetCountByType]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-08-11
-- Description:	客户情况搜索 
-- =============================================
create PROCEDURE [dbo].[kmp_MarketTrace_GetCountByType]
@searchtype int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(m.kid) FROM zgyey_om..MarketTrace m,zgyey_om..kindergarten_attach_info k,site s
	WHERE m.Kid=k.KID AND m.Kid=s.siteid 
	AND (ContractStatus=@searchtype OR Customer_Desc=@searchtype OR Content_Desc=@searchtype 
	OR Register_Source=@searchtype OR Real_Source=@searchtype OR Agent_Desc=@searchtype OR KinStatus=@searchtype
	--OR [name] LIKE '%'+@sitename+'%'
	--OR k.UpdateTime BETWEEN @regstartdatetime AND @regenddatetime
	)
	RETURN @count
END







GO
