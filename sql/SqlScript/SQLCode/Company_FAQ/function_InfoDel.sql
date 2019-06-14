USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoDel]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-5
-- Description:	管理层删除系统功能修改表信息
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoDel]
(
   @funChangeTrackID int  --主键ID，自增
)
AS
DELETE FROM
     functionChangeTracking
WHERE
   funChangeTrackID=@funChangeTrackID
RETURN @@ROWCOUNT


GO
