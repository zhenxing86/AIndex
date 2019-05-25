USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[class_stafferclass_ADD]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：新增老师和班级联系信息
--项目名称：classhomepage
--说明：
--时间：2009-3-2 15:20:13
-----------------------------------
CREATE PROCEDURE [dbo].[class_stafferclass_ADD]
@userid int,
@classid int	
 AS 	
	EXEC BasicData.dbo.user_class_add @classid,@userid
	
	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END


GO
