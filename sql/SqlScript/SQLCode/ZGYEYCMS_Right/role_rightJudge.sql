USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightJudge]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-5
-- Description:	判断是否已存在相同记录(sac_role_right表)
-- =============================================
CREATE PROCEDURE [dbo].[role_rightJudge]
@role_id int,
@right_id int
AS
DECLARE @RESULT INT
SET @RESULT=ISNULL((SELECT COUNT(*) FROM
   sac_role_right WHERE role_id=@role_id AND right_id=@right_id),0)
RETURN @RESULT
GO
