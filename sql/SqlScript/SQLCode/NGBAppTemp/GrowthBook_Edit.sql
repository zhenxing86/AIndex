USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GrowthBook_Edit]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	编辑GrowthBook表
-- Memo:		
exec GrowthBook_Edit @gbid = 50,@userid = 296418,@ColName = 'DevEvlPoint', @DevEvlPoint = '1,2,1,2,1,2,1,2,3,2,1,2,1,2,1,2,1,2,3,2'
exec GrowthBook_Edit @gbid = 50,@userid = 296418,@ColName = 'TeaWord', @TeaWord = '期末总评更新测试2',@Height	= '身高测试',	
	@Weight	= '体重测试',	@Eye = '眼睛测试', @Blood	= '血液测试',	@Tooth = '牙齿测试', @DocWord	= '医生的话测试'
exec GrowthBook_Edit @gbid = 50,@userid = 295765,@ColName = 'ParWord', @ParWord = '爸妈的话测试',@MyWord	= '我的话'

select * from GrowthBook where gbid = 1
SELECT * FROM diary WHERE gbid = 1 and pagetplid = 5
*/
CREATE PROC [dbo].[GrowthBook_Edit]
	@gbid int,
	@userid int,
	@ColName varchar(100),
	@TeaWord nvarchar(1000) = NULL,	
	@Height	varchar(20) = NULL,	
	@Weight	varchar(20) = NULL,	
	@Eye	varchar(20) = NULL,	
	@Blood	varchar(20) = NULL,	
	@Tooth	varchar(20) = NULL,	
	@DocWord	nvarchar(500) = NULL,	
	@MyWord	nvarchar(500) = NULL,	
	@ParWord	nvarchar(1000) = NULL,
	@FamilyPic	varchar(100) = NULL,
	@DadName	varchar(20) = NULL,	
	@DadJob	varchar(30) = NULL,	
	@MomName	varchar(20) = NULL,	
	@MomJob	varchar(30) = NULL,	
	@ParWish	nvarchar(1000) = NULL,	
	@DevEvlPoint	varchar(100) = NULL
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @diaryid BIGINT, @kid int, @term varchar(6), @IsAdvSummary bit

	Begin tran   
	BEGIN TRY
		IF @ColName = 'DevEvlPoint'
		BEGIN
			IF NOT EXISTS
			(			
				SELECT *	
					FROM diary d 
					WHERE d.pagetplid = 5
						AND d.gbid = @gbid
			) 
			INSERT INTO diary(gbid,pagetplid, Author)
			VALUES(@gbid,5,@userid) 

			UPDATE GrowthBook SET DevEvlPoint = @DevEvlPoint
				WHERE gbid = @gbid
		END
		ELSE IF @ColName = 'TeaWord'
		BEGIN
			IF NOT EXISTS
			(			
				SELECT *	
					FROM diary d 
					WHERE d.pagetplid IN(6,7)
						AND d.gbid = @gbid
			)
			BEGIN
				select @kid = kid, @term = term 
					from GrowthBook where gbid = @gbid
				select @IsAdvSummary = CHARINDEX('AdvSummary',hbModList) from dbo.fn_ModuleSet(@kid,@term)
				INSERT INTO diary(gbid,pagetplid, Author)
				SELECT @gbid, CASE @IsAdvSummary WHEN 0 THEN 6 ELSE 7 END, @userid			
			END

			UPDATE GrowthBook 
				SET TeaWord = @TeaWord,
						Height	= @Height,	
						Weight	= @Weight,	
						Eye = @Eye,	
						Blood = @Blood,	
						Tooth = @Tooth,	
						DocWord = @DocWord	
					WHERE gbid = @gbid
		END
		ELSE IF @ColName = 'ParWord'
		BEGIN
			UPDATE GrowthBook 
				SET ParWord = @ParWord,
						myword	= @myword
					WHERE gbid = @gbid
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑growthbook' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@ColName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'老师的话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@TeaWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身高' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@Height'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'体重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@Weight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'视力' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@Eye'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'血色素' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@Blood'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'龃齿' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@Tooth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'医生的话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@DocWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小朋友的话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@MyWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'爸妈的话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@ParWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家庭照片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@FamilyPic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'爸爸的姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@DadName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'爸爸的工作' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@DadJob'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'妈妈的姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@MomName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'妈妈的工作' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@MomJob'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'爸妈寄语' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@ParWish'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发展评估' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GrowthBook_Edit', @level2type=N'PARAMETER',@level2name=N'@DevEvlPoint'
GO
