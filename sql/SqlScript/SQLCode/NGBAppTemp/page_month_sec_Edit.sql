USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[page_month_sec_Edit]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	保存幼儿每月进步，page_month_sec表
-- Memo:	
DECLARE	@I INT
exec @I = page_month_sec_Edit 1,71,'三月', '', '每月进步老师的话测试f3','每月进步父母的话测试3','每月进步我的话测试d3',296418
SELECT @I
SELECT * FROM page_month_sec 
*/
CREATE PROC [dbo].[page_month_sec_Edit]
	@gbid int,  -- hbid 老师操作时使用
	@diaryid int, --日记id 家长操作时使用
	@title nvarchar(40),
	@MyPic nvarchar(200),
	@TeaWord nvarchar(2000),
	@ParWord nvarchar(2000),
	@MyWord  nvarchar(2000),
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	IF @MyPic ='null' set @MyPic = null
	IF @TeaWord = 'null'  set @TeaWord = null
	DECLARE @RESULT INT = 1,	@usertype int -- 0 家长， 1老师	
	select @usertype = CASE WHEN usertype = 0 then 0 else 1 end 
		from BasicData..[user] where userid = @userid
	Begin tran   
	BEGIN TRY
		IF @usertype = 1
		BEGIN		
			SET @diaryid = NULL
		--	DECLARE 	@hbid int = 1,	@userid int = 295765 
		--判断diaryid是否已存在
			SELECT @diaryid = d.diaryid			
				FROM diary d 
					INNER JOIN page_month_sec pm
						on d.diaryid = pm.diaryid
						AND d.pagetplid = 3
						AND d.gbid = @gbid
						and pm.title = @title
			--diaryid不存在则插入每月进步
			IF @diaryid IS NULL
			BEGIN
				INSERT INTO diary(gbid, pagetplid, Author)
					select @gbid, 3, @userid
				SET @diaryid = ident_current('diary')  	
			END									
			--更改或新增评分记录	
				;MERGE page_month_sec AS pm
				USING (SELECT @diaryid diaryid, NULLIF(@title,'') title, @MyPic MyPic,
							 @TeaWord TeaWord)AS mu
				ON (pm.diaryid = mu.diaryid and pm.title = mu.title)
				WHEN MATCHED THEN
				UPDATE SET 
					pm.TeaWord = isnull(mu.TeaWord,pm.TeaWord),
					pm.MyPic = isnull(mu.MyPic,pm.MyPic)
				WHEN NOT MATCHED THEN
				INSERT (diaryid, title,TeaWord,MyPic)
				VALUES (mu.diaryid, mu.title,mu.TeaWord,mu.MyPic);
				IF @@ROWCOUNT = 0
				SET @RESULT = -1
			
		END
		ELSE IF @usertype = 0
		BEGIN
			--家长只允许通过diaryid 进行记录更新
			UPDATE page_month_sec 
				set ParWord = @ParWord,
						MyWord = @MyWord
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑page_month_sec' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit', @level2type=N'PARAMETER',@level2name=N'@title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小朋友照片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit', @level2type=N'PARAMETER',@level2name=N'@MyPic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'老师的话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit', @level2type=N'PARAMETER',@level2name=N'@TeaWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'爸妈的话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit', @level2type=N'PARAMETER',@level2name=N'@ParWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小朋友的话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit', @level2type=N'PARAMETER',@level2name=N'@MyWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_sec_Edit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
