USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoGetByUnfinishStatus]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-5-5
-- Description:	查询未完成项目追踪信息
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoGetByUnfinishStatus]

AS
SELECT
    funChangeTrackID,funContent,changeDate,personID,
    currentDes,finishDate,remark,feedback,trackStatus,
    username
FROM
    FunctionChangeTracking,sac_User
WHERE
    sac_User.status=1 AND FunctionChangeTracking.status=1 
    AND sac_User.[user_id]=FunctionChangeTracking.personID
    AND trackStatus!=1
ORDER BY
    funChangeTrackID DESC


GO
