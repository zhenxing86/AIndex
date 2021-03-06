USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[UpLoadPicBatch]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-21
-- Description:	支持批量多照片，分给多用户，根据模板类型随机选择模板
-- Memo:
EXEC 	UpLoadPicBatch
@pictype= 0,
@term = '2013-1',
@s = '文字内容测试1&$#图片地址测试1#$&文字内容测试2&$#图片地址测试2#$&文字内容测试3&$#图片地址测试3#$&文字内容测试4&$#图片地址测试4#$&文字内容测试5&$#图片地址测试5',
@useridList = '295765,295767,295768,295769'
*/
--
CREATE PROC [dbo].[UpLoadPicBatch]
	@pictype int, --  0生活剪影， 1手工作品
	@term varchar(6),
	@s NVARCHAR(MAX), -- 
	@useridList NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON	
	SELECT pos,col1,col2 
		INTO #TA 
		from commonfun.dbo.fn_MutiSplitTSQL(@s,'#$&','&$#')
		
	SELECT pos,col userid
		INTO #TB 
		from commonfun.dbo.f_split(@useridList,',')

	Begin tran   
	BEGIN TRY  
			INSERT INTO tea_UpPhoto(gbid,photo_desc,m_path,pictype)
			SELECT gb.gbid, t.col1, t.col2, @pictype 
				FROM GrowthBook gb 
					inner join #TB tb 
						on gb.userid = tb.userid 
						and gb.term = @term
					cross join #TA t 
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  -1      
	end Catch  
	Return 1
	drop table #TA,#TB
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支持批量多照片，分给多用户，根据模板类型随机选择模板' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPicBatch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'照片类型 1生活剪影，2手工作品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPicBatch', @level2type=N'PARAMETER',@level2name=N'@pictype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPicBatch', @level2type=N'PARAMETER',@level2name=N'@term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPicBatch', @level2type=N'PARAMETER',@level2name=N'@s'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID字串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpLoadPicBatch', @level2type=N'PARAMETER',@level2name=N'@useridList'
GO
