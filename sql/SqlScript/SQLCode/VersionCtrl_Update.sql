USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[VersionCtrl_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：更新网站版本信息
--项目名称：网站版本管理
--说明：
--时间：2013-4-7 11:50:29

------------------------------------ 
CREATE PROCEDURE [dbo].[VersionCtrl_Update]
@id int
,@username nvarchar(100)
,@batchid int
,@updatetime datetime
,@remark nvarchar(500)
,@state int
AS
begin
     UPDATE [version_ctrl]
	   SET [user_name] = @username
		  ,[batch_id] = @batchid
		  ,[update_time] = @updatetime
		  ,[remark] = @remark
		  ,[state] = @state
		where id = @id
end




GO
