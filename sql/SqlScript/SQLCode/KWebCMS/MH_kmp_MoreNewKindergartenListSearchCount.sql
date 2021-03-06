USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_MoreNewKindergartenListSearchCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-02
-- Description:	搜索幼儿园的总数
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_MoreNewKindergartenListSearchCount]
@privince int,
@city int,
@name nvarchar(100)
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(t2.id)
	FROM kmp..t_kindergarten t2  WHERE t2.status = 1 and t2.ispublish = 1 and privince=@privince and city=@city and name like '%'+@name+'%'
	RETURN @count
END



GO
