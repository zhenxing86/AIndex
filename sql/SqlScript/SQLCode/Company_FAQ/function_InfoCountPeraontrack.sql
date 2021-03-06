USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoCountPeraontrack]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 20105-14
-- Description:	获取指定负责人已完成数量
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoCountPeraontrack]
(
    @personID int,
    @trackStatus int
)
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM FunctionChangeTracking
     WHERE status=1 AND personID=@personID AND @trackStatus=1),0)
RETURN @RESULT


GO
