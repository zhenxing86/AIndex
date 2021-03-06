USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[UpLoadPic]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-09
-- Description:	上传照片，分给多用户
-- Memo:
EXEC 	UpLoadPic
@gbids = '50,51',
@net= 0,
@url = 'http://img393.zgyey.com/NGBPhoto/20130914/15277402045417_small.jpg',
@desc = '生活剪影测试',
@pictype= 2--  1生活剪影， 2手工作品

*/
--
CREATE PROC [dbo].[UpLoadPic]
	@gbids NVARCHAR(MAX),
	@net int = 0,
	@url NVARCHAR(200), -- 
	@desc NVARCHAR(100), -- 
	@pictype int --  1生活剪影， 2手工作品
AS
BEGIN
	SET NOCOUNT ON			
	Begin tran   
	BEGIN TRY 
			INSERT INTO tea_UpPhoto(gbid,photo_desc,m_path,pictype,net)
				SELECT col, @desc, @url, @pictype,@net 
					FROM commonfun.dbo.f_split(@gbids,',')
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  -1      
	end Catch  
	Return 1
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传照片，分给多用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'gbid的字串，用'',''分隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPic', @level2type=N'PARAMETER',@level2name=N'@gbids'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片服务器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPic', @level2type=N'PARAMETER',@level2name=N'@net'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPic', @level2type=N'PARAMETER',@level2name=N'@url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPic', @level2type=N'PARAMETER',@level2name=N'@desc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'照片类型 1生活剪影，2手工作品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPic', @level2type=N'PARAMETER',@level2name=N'@pictype'
GO
