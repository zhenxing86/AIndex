USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[VersionCtrl_Add]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：新增网站版本信息
--项目名称：网站版本管理
--说明：
--时间：2013-4-7 11:50:29

------------------------------------ 
Create PROCEDURE [dbo].[VersionCtrl_Add]
@username nvarchar(50)
,@batchid int 
,@remark nvarchar(500)
AS
begin
	INSERT INTO [version_ctrl]
           ([user_name]
           ,[batch_id]
           ,[update_time]
           ,[remark]
           ,[state])
     VALUES(@username,@batchid,GETDATE(),@remark,0)
     
end




GO
