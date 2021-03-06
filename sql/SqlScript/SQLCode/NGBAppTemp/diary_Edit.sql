USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[diary_Edit]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-16
-- Description:	编辑日记，diary表  --1新增日记，2删除日记，3更改模版， 4切换公开标志
-- Memo:	
DECLARE	@I INT
exec @I = diary_Edit 1,11,null, 1,295765
SELECT @I
SELECT * FROM diary
SELECT * FROM page_public
*/
CREATE PROC [dbo].[diary_Edit]
	@gbid	int,
	@pagetplid	int,
	@diaryid	bigint = -1,
	@EditType	int, --1新增日记，2删除日记，3更改模版， 4切换公开标志
	@userid int,
	@CrtDate datetime = null,
	@Share int = 0,
	@Src int = 0
AS
BEGIN
	SET NOCOUNT ON	
	if @CrtDate is null or @CrtDate = '1900-01-01'
	set @CrtDate = GETDATE()
	Begin tran   
	BEGIN TRY
		IF @EditType = 1
		BEGIN
			INSERT INTO diary(gbid,pagetplid, Author,CrtDate, Share, Src)
				VALUES(@gbid,@pagetplid,@userid,@CrtDate,@Share,@Src)			
			SET @diaryid = ident_current('diary') 
			
			INSERT INTO page_public(diaryid,ckey,cvalue,ctype)
				SELECT @diaryid, ckey, cvalue, ctype 
					FROM page_public_tpl 
					WHERE pagetplid = @pagetplid
			IF @@ROWCOUNT = 0 
			SET @diaryid = -2
		END
		ELSE IF @EditType = 2
		BEGIN
			UPDATE diary SET deletetag = 0 
				WHERE diaryid = @diaryid
		END
		ELSE IF @EditType = 3
		BEGIN

		 DELETE  page_public WHERE diaryid = @diaryid
		 
		 UPDATE diary SET pagetplid = @pagetplid ,share=@share  
			WHERE diaryid = @diaryid  		
	      
		 INSERT INTO page_public(diaryid,ckey,cvalue,ctype)  
			SELECT @diaryid, ckey, cvalue, ctype   
			 FROM page_public_tpl   
			 WHERE pagetplid = @pagetplid  
     
		END
		ELSE IF @EditType = 4
		BEGIN
			UPDATE diary SET Share = Case ISNULL(Share,1) when 0 THEN 1 else 0 END 
				WHERE diaryid = @diaryid
		END
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch     
		RETURN @diaryid -- -1失败， -2 未插入组件， >0 成功
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑diary' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志模版ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit', @level2type=N'PARAMETER',@level2name=N'@pagetplid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1新增日记，2删除日记，3更改模版， 4切换公开标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit', @level2type=N'PARAMETER',@level2name=N'@EditType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit', @level2type=N'PARAMETER',@level2name=N'@CrtDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公开标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit', @level2type=N'PARAMETER',@level2name=N'@Share'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 Pc,1 App' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'diary_Edit', @level2type=N'PARAMETER',@level2name=N'@Src'
GO
