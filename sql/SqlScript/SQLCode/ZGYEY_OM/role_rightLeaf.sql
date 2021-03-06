USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightLeaf]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-5
-- Description:	判断是否为叶子节点（返回0表示为叶子节点）
-- =============================================
CREATE PROCEDURE [dbo].[role_rightLeaf]
@role_id int,
@right_id int
AS
DECLARE @RESULT INT
SET @RESULT=ISNULL((
SELECT COUNT(*) FROM sac_role_right 
INNER JOIN sac_right ON sac_role_right.right_id=sac_right.right_id
WHERE
   role_id=@role_id AND up_right_id=@right_id),0)
RETURN @RESULT



GO
