USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[site_GetProviceList]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		liaoxin
-- Create date: 2010.7.22
-- Description:	从KMP数据库中查询所有的省份
-- =============================================
CREATE PROCEDURE [dbo].[site_GetProviceList]
	@parentid int
AS
BEGIN
	 select ID,Title from T_Area where Superior=@parentid
END

GO
