USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      MasterÃ∑
-- Create date: 
-- Description:	
-- Memo:		
*/
ALTER FUNCTION dbo.GetRight(@kid int, @userid int, @role_name varchar(50))
	returns bit
as
BEGIN
	DECLARE @Result bit = 0
	IF EXISTS(
		select * 
			from KWebCMS..site_user s
				inner join KWebCMS_Right.dbo.sac_user u on u.[user_id]=s.[UID]
				inner join KWebCMS_Right.dbo.sac_user_role r on r.[user_id]=u.[user_id]
				inner join KWebCMS_Right.dbo.sac_role l on l.role_id=r.role_id
			where s.appuserid = @userid
				and l.role_name = 'π‹¿Ì‘±'
	)
	SET @Result = 1
	ELSE IF EXISTS(
		select * 
			from KWebCMS..site_user s
				inner join KWebCMS_Right.dbo.sac_user u on u.[user_id]=s.[UID]
				inner join KWebCMS_Right.dbo.sac_user_role r on r.[user_id]=u.[user_id]
				inner join KWebCMS_Right.dbo.sac_role l on l.role_id=r.role_id
			where s.appuserid = @userid
				and l.role_name = @role_name
	)
	SET @Result = 1
	RETURN @Result
END