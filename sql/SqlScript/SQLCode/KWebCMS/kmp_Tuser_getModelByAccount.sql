USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Tuser_getModelByAccount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kmp_Tuser_getModelByAccount]
	@account varchar(20)
AS
BEGIN
  select pwd from blog..blog_user where account=@account
END

GO
