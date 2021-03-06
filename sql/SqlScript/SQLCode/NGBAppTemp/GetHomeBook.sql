USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetHomeBook]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-21
-- Description:	读取家园联系册的数据
-- Memo:
GetHomeBook 5
update 
*/
--
CREATE PROC [dbo].[GetHomeBook]
	@hbid int
AS
BEGIN
	SET NOCOUNT ON
	--1、家园联系册基础信息、模块配置，填写周期配置数据集
	SELECT	hb.kid, k.kname, hb.grade, hb.cid, c.cname, hb.term, 
					ISNULL(hb.Teacher,dbo.GetHomeBookTercher(hb.cid))Teacher, 
					hb.Foreword,hb.ForewordPic,hb.ClassNotice,hb.ClassPic,
					k.NGB_Descript,k.NGB_Pic,fm.hbModList,fm.Monadvset,fm.cellset,fm.celltype
		FROM HomeBook hb 
			inner join BasicData..kindergarten k
				on hb.kid = k.kid
			inner join BasicData..class c 
				on hb.cid = c.cid
			CROSS apply(select * from dbo.fn_ModuleSet(hb.kid,hb.term))fm
		where hb.hbid = @hbid
	
	SELECT gb.gbid, gb.userid, u.name 
		INTO #gbidlist
		from HomeBook hb
				inner join BasicData..class c 
						on hb.cid = c.cid
				inner join BasicData..user_class uc
					on c.cid = uc.cid
				inner join BasicData..[user] u
					on u.userid = uc.userid
					and u.deletetag = 1
					and u.usertype = 0
				inner join GrowthBook gb
					on gb.userid = u.userid
					and gb.term = hb.term		
			WHERE hb.hbid = @hbid	
		
	--2、全班小朋友列表数据集
	SELECT gb.userid, gb.gbid, gb.name,oa1.lpcnt, oa2.wpcnt
		FROM #gbidlist gb 
				outer apply
				(
					select COUNT(1)lpcnt 
						from tea_UpPhoto 								
						where gbid = gb.gbid 
							AND pictype = 1	and deletetag=1	--生活剪影	
				)oa1
				outer apply
				(
					select COUNT(1)wpcnt 
						from tea_UpPhoto 								
						where gbid = gb.gbid 
							AND pictype = 2 and deletetag=1	--手工作品				
				)oa2
		
	--3、幼儿表现数据集	
	select	gb.gbid, d.diaryid, @hbid hbid, gb.userid, pc.title, 
					pc.TeaPoint, pc.TeaWord, pc.ParPoint, pc.ParWord 
		FROM #gbidlist gb 
			inner join diary d
				on d.gbid = gb.gbid
			inner join page_cell pc
				on pc.diaryid = d.diaryid

	--4、在园表现观察目标数据集	
	SELECT hbid,title,target 
		FROM celltarget
		WHERE hbid = @hbid
		
  --5、每月进步数据集
	select	gb.gbid, d.diaryid, @hbid hbid, gb.userid, pm.title, 
					pm.MyPic, pm.TeaWord, pm.ParWord, pm.MyWord
		FROM #gbidlist gb 
			inner join diary d
				on d.gbid = gb.gbid
			inner join page_month_sec pm
				on pm.diaryid = d.diaryid

  --6、月观察与评价目标：   
  SELECT mt.months, mt.target 
		FROM HomeBook hb 
			inner join BasicData..grade g
				on hb.grade=g.gid
			inner join monthtarget mt 
				on g.gtype = mt.grade 
				and CAST(RIGHT(hb.term,1) AS INT) = mt.semester
		WHERE hb.hbid = @hbid
			
		
  --7、月观察与评价
	select	gb.gbid, d.diaryid, @hbid hbid, gb.userid, 
					pm.months, pm.TeaPoint, pm.ParPoint
		FROM #gbidlist gb 
			inner join diary d
				on d.gbid = gb.gbid
			inner join page_month_evl pm
				on pm.diaryid = d.diaryid

  --8、发展评估与期末总评
	select	gb.gbid, gb.TeaWord, gb.Height, gb.Weight, gb.Eye, gb.Blood, 
					gb.Tooth, gb.DocWord, gb.MyWord, gb.ParWord, gb.DevEvlPoint
		FROM #gbidlist gb1 			
			inner join GrowthBook gb
				on gb1.gbid = gb.gbid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取家园联系册的数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetHomeBook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家园联系册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetHomeBook', @level2type=N'PARAMETER',@level2name=N'@hbid'
GO
