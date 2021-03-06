USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[page_month_evl_Edit]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	保存幼儿月观察与评价，page_month_evl表
-- Memo:	
DECLARE	@I INT
exec  page_month_evl_Edit 50,72,10, '1,1,2,3,2,1,2,3,1','每月观察与评价爸妈评分测试aaa',296418
SELECT @I 
SELECT * FROM page_month_evl 
*/
CREATE PROC [dbo].[page_month_evl_Edit]
	@gbid int,  -- hbid 老师操作时使用
	@diaryid int, --日记id 家长操作时使用
	@months	tinyint,
	@TeaPoint	varchar(50),
	@ParPoint	varchar(50),
	@userid int
AS
BEGIN
	SET NOCOUNT ON
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
					INNER JOIN page_month_evl pm
						on d.diaryid = pm.diaryid
						AND d.pagetplid = 4
						AND d.gbid = @gbid
						and pm.months = @months
			--diaryid不存在则插入每月进步
			IF @diaryid IS NULL
			BEGIN
				INSERT INTO diary(gbid, pagetplid, Author)
					select @gbid, 4, @userid
				SET @diaryid = ident_current('diary')  	
			END									
			--更改或新增评分记录
			;MERGE page_month_evl AS pm
			USING (SELECT @diaryid diaryid, @months months, @TeaPoint TeaPoint)AS mu
			ON (pm.diaryid = mu.diaryid and pm.months = mu.months)
			WHEN MATCHED THEN
			UPDATE SET 
				pm.TeaPoint = mu.TeaPoint
			WHEN NOT MATCHED THEN
			INSERT (diaryid, months,TeaPoint)
			VALUES (mu.diaryid, mu.months,mu.TeaPoint);
			IF @@ROWCOUNT = 0
			SET @RESULT = -1
		END
		ELSE IF @usertype = 0
		BEGIN
			--家长只允许通过diaryid 进行记录更新
			UPDATE page_month_evl 
				set ParPoint = @ParPoint
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑page_month_evl' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_evl_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_evl_Edit', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_evl_Edit', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'月' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_evl_Edit', @level2type=N'PARAMETER',@level2name=N'@months'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'老师评分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_evl_Edit', @level2type=N'PARAMETER',@level2name=N'@TeaPoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'爸妈评分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_evl_Edit', @level2type=N'PARAMETER',@level2name=N'@ParPoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_month_evl_Edit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
