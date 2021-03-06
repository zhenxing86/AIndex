USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<张启平>
-- Create date: <2010-5-5>
-- Description:	<管理层修改系统功能修改追踪表>
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoUpdate]
(
        @funChangeTrackID int,  --主键ID，自增
        @funContent text,  --修改功能描述
        @username nvarchar(50), --主要负责人
        @changeDate datetime,--项目修改启动时间
        @remark nvarchar(1000),--备注
        @feedback nvarchar(1000)--公司反馈意见和建议
)
AS
DECLARE @personID int
SET @personID=ISNULL((SELECT [user_id] FROM sac_User WHERE username=@username),0)
IF @personID>0
BEGIN
UPDATE 
   functionChangeTracking
SET
   funContent=@funContent,personID=@personID,
   changeDate=@changeDate,remark=@remark,
   feedback=@feedback
WHERE funChangeTrackID=@funChangeTrackID AND FunctionChangeTracking.status=1
RETURN @@ROWCOUNT
END
ELSE
RETURN 0


GO
