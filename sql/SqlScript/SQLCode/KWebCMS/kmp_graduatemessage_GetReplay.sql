USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_graduatemessage_GetReplay]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		lx
-- Create date: 2010-9-2
-- Description:	根据留言ID查询回复
-- =============================================
CREATE PROCEDURE [dbo].[kmp_graduatemessage_GetReplay]
	@parentid int,@userid int
AS
BEGIN
select * from kmp..GraduateMessage where parentid=@parentid and userid=@userid
END

GO
