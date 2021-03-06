USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoGetSingle]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-5-7
-- Description:	获取指定ID的修改追踪信息
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoGetSingle] 
(
    @funChangeTrackID int
)
AS
SELECT
    funChangeTrackID,funContent,personID,changeDate,currentDes,finishDate,remark,
    feedback,trackStatus,username
FROM
    FunctionChangeTracking,sac_User
WHERE
    FunctionChangeTracking.status=1 AND sac_User.status=1
    AND FunctionChangeTracking.personID=sac_User.[user_id]
    AND funChangeTrackID=@funChangeTrackID 


GO
