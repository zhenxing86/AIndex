USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[GetDictList]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-11-12
-- Description:	
-- Memo:	
exec GetDictList @kid = 12511, @type = '园长'
exec GetDictList @kid = 12511, @type = '物品管理员'
exec GetDictList @kid = 12511, @type = '管理员'
exec GetDictList @kid = 12511, @type = '医生'
*/
CREATE PROC [dbo].[GetDictList]
	@kid int,
	@type varchar(10)
AS
BEGIN
	SET NOCOUNT ON
	IF @type in('园长','管理员','老师','物品管理员','医生') 
	BEGIN
		select u.userid keyCol, u.name valueCol 
			from KWebCMS..site_user s
				inner join KWebCMS_Right.dbo.sac_user su on su.[user_id]=[UID]
				inner join KWebCMS_Right.dbo.sac_user_role r on r.[user_id]=su.[user_id]
				inner join KWebCMS_Right.dbo.sac_role l on l.role_id=r.role_id
				inner join BasicData..[user] u on u.userid = s.appuserid
			where s.siteid = @kid 
				and l.role_name = @type 
			order by keyCol
	END
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取下拉列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDictList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDictList', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDictList', @level2type=N'PARAMETER',@level2name=N'@type'
GO
