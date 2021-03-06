USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_MarketTrace_GetCountBySearch]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-08-11
-- Description:	客户情况搜索 
-- =============================================
CREATE PROCEDURE [dbo].[kmp_MarketTrace_GetCountBySearch]
@searchtype int,
@siteid int,
@searchkey int,
@sitename nvarchar(50),
@regstartdatetime datetime,
@regenddatetime datetime
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(s.siteid) FROM site s 
			--left join zgyey_om..MarketTrace m on s.siteid=m.kid
			-- left join zgyey_om..kindergarten_attach_info k on m.kid=k.kid
	WHERE --m.Kid=k.KID AND m.Kid=s.siteid 
	--AND (m.Kid=@siteid OR ContractStatus=@searchkey OR Customer_Desc=@searchkey OR Content_Desc=@searchkey 
	--OR Register_Source=@searchkey OR Real_Source=@searchkey OR Agent_Desc=@searchkey OR KinStatus=@searchkey
	--OR [name] LIKE '%'+@sitename+'%'
	--OR )
	--and 
	s.regdatetime BETWEEN @regstartdatetime AND @regenddatetime
	RETURN @count
END







GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_MarketTrace_GetCountBySearch', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
