USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoUpdateByPerson]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-5
-- Description:	管理层填写修改功能的基本信息
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoUpdateByPerson] 
   (
        @funChangeTrackID int,  --主键ID，自增
        @currentDes nvarchar(1000), --当前进度，问题描述
        @trackStatus int--进度状态
)
AS
UPDATE 
    functionChangeTracking
SET
   currentDes=@currentDes,finishDate=getdate(),
   trackStatus=@trackStatus
WHERE funChangeTrackID=@funChangeTrackID AND status=1
RETURN @@ROWCOUNT


GO
