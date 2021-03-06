USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[Transfer_Init_GrowthBook]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	初始化成长档案，growthbook表
-- Memo:		
exec Init_GrowthBook 46144, '2013-1'
exec Init_GrowthBook 81185, '2013-1'
exec Init_GrowthBook 46149, '2013-1'
exec Init_GrowthBook 46142, '2013-1'
delete homebook
select * from basicdata..class where kid=12511
*/
create PROC [dbo].[Transfer_Init_GrowthBook]
	@cid int,
	@term varchar(6)
AS
BEGIN
	SET NOCOUNT ON
	declare @gbid table(gbid int)
	declare @diaryid table(diaryid bigint, pagetplid int,crtdate datetime)
	
		INSERT INTO GrowthBook(kid, grade, userid, term)
			output inserted.gbid
			into @gbid
			SELECT kid, grade, userid, @term
				FROM BasicData.dbo.User_Child
					where cid = @cid
	;WITH CET AS
	(
		SELECT 11 AS pagetplid
		UNION ALL
		SELECT 12
		UNION ALL
		SELECT 13
	)				
			INSERT INTO diary(gbid,pagetplid,CrtDate)
				output inserted.diaryid, inserted.pagetplid,'2013-09-01'
				into @diaryid(diaryid, pagetplid,crtdate)
				SELECT g.gbid, c.pagetplid ,'2013-09-01'
					from CET c cross join @gbid g
								
			INSERT INTO page_public(diaryid,ckey,cvalue,ctype)
				SELECT d.diaryid, ckey, cvalue, ctype 
					FROM page_public_tpl pp
						inner join @diaryid d
							on pp.pagetplid = d.pagetplid
							
		DECLARE @hbid int
		
		select @hbid = hbid 
			from HomeBook 
			where cid = @cid 
				and term = @term
		IF @hbid IS NOT NULL
			RETURN @hbid
		ELSE
		BEGIN
			INSERT INTO HomeBook(kid, grade, cid, term)
				SELECT kid, grade, cid, @term
					FROM BasicData.dbo.class 
					where cid = @cid
			RETURN ident_current('HomeBook') 	
		END 
			
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'旧版转新版' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Transfer_Init_GrowthBook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Transfer_Init_GrowthBook', @level2type=N'PARAMETER',@level2name=N'@cid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Transfer_Init_GrowthBook', @level2type=N'PARAMETER',@level2name=N'@term'
GO
