USE [BasicData]
GO
/****** Object:  UserDefinedFunction [dbo].[IsManager]    Script Date: 05/14/2013 14:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[IsManager]
	(
	@userid int,	
	@kid int
	)
RETURNS INT
AS
	BEGIN	
		declare @uid int
		DECLARE @ismanage int
		select @uid=[uid] from kwebcms.dbo.[site_user] where appuserid=@userid
		if(@uid is null)
		begin
			set @uid=0
		end
		IF EXISTS(SELECT 1 FROM KWebCMS_Right.dbo.sac_user_role INNER JOIN KWebCMS_Right.dbo.sac_role ON sac_role.role_id=sac_user_role.role_id WHERE [user_id]=@uid and (role_name='管理员' or role_name='园长'))
		BEGIN
			set @ismanage=1
		END 
		ELSE
		BEGIN
			set @ismanage=0
		END
		return @ismanage
	END
GO
