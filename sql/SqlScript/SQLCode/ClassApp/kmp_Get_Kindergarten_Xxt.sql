USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Get_Kindergarten_Xxt]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<wuzy>
-- ALTER date: <2010-09-20>
-- Description:	<判断幼儿园是否是校讯通园>
-- =============================================
CREATE PROCEDURE [dbo].[kmp_Get_Kindergarten_Xxt]
@kid int
AS
	IF EXISTS(select 1 from xxt_kid where kid=@kid)
	BEGIN
		RETURN (1)
	END
	ELSE
	BEGIN
		RETURN (0)
	END


--
--insert into xxt_kid(kid)
--select siteid from KWebCMS.dbo.site_config where memo like '%校讯通%' or memo like '%园讯通%'
--
--
--select * from xxt_kid where kid=7672
GO
