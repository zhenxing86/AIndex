USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[page_public_tpl_Edit]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	设置在园表现观察目标，CellTarget表
-- Memo:	
DECLARE	@I INT
exec @I = PageTpl_Edit '测试模版2', '2', '测试地址2',1,2
SELECT @I
SELECT * FROM PageTpl 
*/
CREATE PROC [dbo].[page_public_tpl_Edit]
	@pagetplid	int,
	@ckey	varchar(20),	
	@cvalue	varchar(1000),	
	@ctype	int
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY
		 ;MERGE page_public_tpl AS pp
			USING (SELECT @pagetplid pagetplid, @ckey ckey, @cvalue cvalue, @ctype ctype )AS mu
			ON (pp.pagetplid = mu.pagetplid and pp.ckey = mu.ckey)
			WHEN MATCHED THEN
			UPDATE SET 
				pp.cvalue = mu.cvalue,
				pp.ctype = mu.ctype
			WHEN NOT MATCHED THEN
			INSERT (pagetplid, ckey, cvalue, ctype)
			VALUES (mu.pagetplid, mu.ckey,mu.cvalue,mu.ctype);
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch     
		RETURN 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑page_public_tpl' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_tpl_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志模版ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_tpl_Edit', @level2type=N'PARAMETER',@level2name=N'@pagetplid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组件参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_tpl_Edit', @level2type=N'PARAMETER',@level2name=N'@ckey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组件值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_tpl_Edit', @level2type=N'PARAMETER',@level2name=N'@cvalue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_tpl_Edit', @level2type=N'PARAMETER',@level2name=N'@ctype'
GO
