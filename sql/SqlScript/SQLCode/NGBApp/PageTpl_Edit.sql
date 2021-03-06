USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[PageTpl_Edit]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	设置模版，PageTpl表
-- Memo:	
DECLARE	@I INT
exec @I = PageTpl_Edit '生活剪影4', 16,1, 'shjy_4_1.swf',1,0
SELECT @I
SELECT * FROM PageTpl 
*/
CREATE PROC [dbo].[PageTpl_Edit]
	@tplname	varchar(20),
	@tpltype	int,
	@tplsubtype	int,
	@url	varchar(100),
	@img	varchar(100),
	@lazy	int,
	@pagetplid int = 0
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY
		IF @pagetplid = 0
		BEGIN		
			INSERT INTO PageTpl(tplname,tpltype,tplsubtype,url,img,lazy)
				VALUES(@tplname,@tpltype,@tplsubtype,@url,@img,@lazy)
		END
		ELSE 
		BEGIN
			UPDATE PageTpl 
				set tplname = @tplname,
						tpltype = @tpltype,
						tplsubtype = @tplsubtype,
						url = @url,
						img = @img,
						lazy = @lazy
				WHERE pagetplid = @pagetplid 
		END		
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch     
		RETURN 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑PageTpl' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PageTpl_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PageTpl_Edit', @level2type=N'PARAMETER',@level2name=N'@tplname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板类型 16图文版 17纯文版 18图音版 19视文版' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PageTpl_Edit', @level2type=N'PARAMETER',@level2name=N'@tpltype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板子类型 （视音图文 如 二文一图 12）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PageTpl_Edit', @level2type=N'PARAMETER',@level2name=N'@tplsubtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PageTpl_Edit', @level2type=N'PARAMETER',@level2name=N'@url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缩略图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PageTpl_Edit', @level2type=N'PARAMETER',@level2name=N'@img'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'加载策略(0预加载1延时加载)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PageTpl_Edit', @level2type=N'PARAMETER',@level2name=N'@lazy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志模版ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PageTpl_Edit', @level2type=N'PARAMETER',@level2name=N'@pagetplid'
GO
