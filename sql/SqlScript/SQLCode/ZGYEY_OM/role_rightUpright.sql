USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightUpright]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-5
-- Description:	匹配父类
-- =============================================
CREATE PROCEDURE [dbo].[role_rightUpright]
@role_id int,
@right_id int
AS
DECLARE @RESULT INT
SET @RESULT=ISNULL((SELECT COUNT(*) FROM
   sac_role_right WHERE right_id=@right_id AND role_id=@role_id),0)
RETURN @RESULT



GO
