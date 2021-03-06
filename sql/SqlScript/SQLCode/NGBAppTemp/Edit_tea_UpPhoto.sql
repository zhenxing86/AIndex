USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[Edit_tea_UpPhoto]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-09
-- Description:	0删除生活剪影手工作品照片，  1编辑生活剪影手工作品描述
-- Memo:
EXEC 	[Edit_tea_UpPhoto]
@pids = '7,8',
@type= 1,
@desc = '图片描述测试改'

*/
--
CREATE PROC [dbo].[Edit_tea_UpPhoto]
	@pids NVARCHAR(MAX),
	@type int, --0 删除, 1 修改描述
	@desc NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON			
	Begin tran   
	BEGIN TRY 
			IF @type = 0
			UPDATE tea_UpPhoto SET deletetag = 0
				from tea_UpPhoto t
					inner join commonfun.dbo.f_split(@pids,',')f
						on t.photoid = f.col
			ELSE IF @type = 1				
			UPDATE t SET photo_desc = @desc
				from tea_UpPhoto t
					inner join commonfun.dbo.f_split(@pids,',')f
						on t.photoid = f.col
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  -1      
	end Catch  
	Return 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑tea_UpPhoto' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Edit_tea_UpPhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'photoid的字串，用'',''分隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Edit_tea_UpPhoto', @level2type=N'PARAMETER',@level2name=N'@pids'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 删除, 1 修改描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Edit_tea_UpPhoto', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Edit_tea_UpPhoto', @level2type=N'PARAMETER',@level2name=N'@desc'
GO
