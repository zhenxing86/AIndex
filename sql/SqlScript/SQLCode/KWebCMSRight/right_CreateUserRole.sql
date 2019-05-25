USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_CreateUserRole]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	用户角色分配
-- =============================================
alter PROCEDURE [dbo].[right_CreateUserRole]
@user_id int,
@role_id int
AS
IF NOT EXISTS(SELECT * FROM sac_user_role WHERE [user_id]=@user_id AND role_id=@role_id)
BEGIN
declare @id int
INSERT INTO sac_user_role([user_id],role_id) VALUES(@user_id,@role_id)
set @id=@@IDENTITY


	--declare @usertype int
	--declare @appuserid int
	--declare @role_name varchar(100)

	--select @role_name=role_name from dbo.sac_role where role_id=@role_id
	
	
	--if(@role_name='园长')
	--begin
	--set @usertype=97
	--end
	--if(@role_name='管理员')
	--begin
	--set @usertype=98
	--end
	--select @appuserid=appuserid from KWebCMS..site_user where [UID]=@user_id
		
	--update BasicData..[user] set usertype=@usertype where userid=@appuserid and usertype>1
	


RETURN @id
END
ELSE
RETURN 0
GO
[right_CreateUserRole] 22825,24494