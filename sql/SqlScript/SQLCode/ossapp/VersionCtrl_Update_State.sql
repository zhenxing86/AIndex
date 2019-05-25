USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[VersionCtrl_Update_State]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：更新网站版本状态
--项目名称：网站版本管理
--说明：
--时间：2013-4-7 11:50:29

------------------------------------ 
CREATE PROCEDURE [dbo].[VersionCtrl_Update_State]
@id int
,@state int
AS
begin
     UPDATE [version_ctrl]
	   SET [state] = @state
		where id = @id
end




GO
