USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[GetKinMasterLoginName]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-24
-- Description:	获取园长的登录帐号
-- =============================================
CREATE PROCEDURE [dbo].[GetKinMasterLoginName]
@siteid int
AS
BEGIN
	select top(1)loginname 
	from kmp..t_users t1 inner join kmp..t_staffer t2 on t1.id=t2.userid
	where t1.usertype IN (97,98) and t2.status=1 and t2.KindergartenID=@siteid
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetKinMasterLoginName', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
