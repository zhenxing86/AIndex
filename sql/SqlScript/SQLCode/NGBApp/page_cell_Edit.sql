USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[page_cell_Edit]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	保存幼儿表现评分，评语，page_cell表
-- Memo:	
DECLARE	@I INT
exec @I = page_cell_Edit 1,0,'七月', '幼儿表现老师评分测试37', '幼儿表现老师评语测试7',296418
exec @I = page_cell_Edit 1,0,'四月', '幼儿表现老师评分测试4a', '幼儿表现老师评语测试4',296418
SELECT @I
exec @I = page_cell_Edit 0,87,'', '幼儿表现家长评分测试7', '幼儿表现家长评语测试7',295765
----SELECT @I
SELECT * FROM diary 
SELECT * FROM page_cell 

*/
CREATE PROC [dbo].[page_cell_Edit]
	@gbid int,  -- hbid 老师操作时使用
	@diaryid int, --日记id 家长操作时使用
	@title nvarchar(40),
	@Point varchar(50),
	@Word nvarchar(2000),
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @RESULT INT = 1, @kid int, @term varchar(6), @IsAdv bit,	@usertype int -- 0 家长， 1老师	
	select @usertype = CASE WHEN usertype = 0 then 0 else 1 end 
		from BasicData..[user] where userid = @userid
		
	IF @usertype = 1
	begin
	--判断是普通版或是高级版 @IsAdv = 0 普通版，> 0 高级版
		select @kid = kid, @term = term 
			from GrowthBook where gbid = @gbid
		select @IsAdv = CHARINDEX('AdvCell',hbModList) from dbo.fn_ModuleSet(@kid,@term) 
	end
	
	Begin tran   
	BEGIN TRY
		IF @usertype = 1
		BEGIN		
			SET @diaryid = NULL
		--	DECLARE 	@hbid int = 1,	@userid int = 295765 
		--判断diaryid是否已存在
			SELECT @diaryid = d.diaryid			
				FROM diary d 
					INNER JOIN page_cell pc
						on d.diaryid = pc.diaryid
						AND d.pagetplid = CASE WHEN @IsAdv = 0 THEN 1 ELSE 2 END
						AND d.gbid = @gbid
						and pc.title = @title
			--diaryid不存在则插入幼儿表现日记
			IF @diaryid IS NULL
			BEGIN
				INSERT INTO diary(gbid, pagetplid, Author)
					select @gbid, CASE WHEN @IsAdv = 0 THEN 1 ELSE 2 END, @userid
				SET @diaryid = ident_current('diary')  	
			END									
			--更改或新增评分记录
			;MERGE page_cell AS pc
			USING (SELECT @diaryid diaryid, @title title, @Point TeaPoint, @Word TeaWord )AS mu
			ON (pc.diaryid = mu.diaryid and pc.title = mu.title)
			WHEN MATCHED THEN
			UPDATE SET 
				pc.TeaPoint = mu.TeaPoint,
				pc.TeaWord = mu.TeaWord
			WHEN NOT MATCHED THEN
			INSERT (diaryid, title,TeaPoint,TeaWord)
			VALUES (mu.diaryid, mu.title,mu.TeaPoint,mu.TeaWord);
			IF @@ROWCOUNT = 0
			SET @RESULT = -1
		END
		ELSE IF @usertype = 0
		BEGIN
			--家长只允许通过diaryid 进行记录更新
			UPDATE page_cell 
				set ParPoint = @Point,
						ParWord = @Word
				WHERE diaryid = @diaryid 				
			IF @@ROWCOUNT = 0
			SET @RESULT = -1
		END		
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch     
		RETURN @RESULT
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑page_cell' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_cell_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_cell_Edit', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_cell_Edit', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_cell_Edit', @level2type=N'PARAMETER',@level2name=N'@title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_cell_Edit', @level2type=N'PARAMETER',@level2name=N'@Point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评语' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_cell_Edit', @level2type=N'PARAMETER',@level2name=N'@Word'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_cell_Edit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
