USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherToExcel_v0]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-01
-- Description:	得到教师列表
-- Memo:		
exec user_GetTeacherToExcel_v0 12511
*/ 
CREATE PROCEDURE [dbo].[user_GetTeacherToExcel_v0]
	@kid int
AS
BEGIN 	
	SET NOCOUNT ON
	SELECT	name, case gender when 2 then '女' when 3 then '男' end,
					account, mobile, birthday, userid
		FROM [user]  
		WHERE	kid = @kid 
			and deletetag = 1 
			and usertype in (1,97)
END

GO
