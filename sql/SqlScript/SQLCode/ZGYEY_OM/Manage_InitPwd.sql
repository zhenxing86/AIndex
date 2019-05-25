USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_InitPwd]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Manage_InitPwd]   
@userid int
AS

	update basicdata.dbo.[user] set [password]='7C4A8D09CA3762AF61E59520943DC26494F8941B' where userid=@userid
	
	if(@@ERROR<>0)
	begin
		return (-1)
	end
	else
	begin
		return (1)
	end 



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码重置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Manage_InitPwd'
GO
