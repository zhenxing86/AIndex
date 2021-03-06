USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[Init_StaRep]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	自动生成示例报表
-- Memo:		
*/
CREATE PROC [dbo].[Init_StaRep]
	@bgn datetime,
	@end datetime
AS
BEGIN
	SET NOCOUNT ON
	--TRUNCATE TABLE 乐奇家园答题统计报表
	--TRUNCATE TABLE 乐奇家园访问统计报表
	--TRUNCATE TABLE 乐奇家园领域分类统计报表
	--TRUNCATE TABLE 内容商结算清单
	--TRUNCATE TABLE 数字图书馆地域访问量统计
	--TRUNCATE TABLE 数字图书馆缴费用户转化率分析报表
	--TRUNCATE TABLE 数字图书馆年龄段访问量统计
	--TRUNCATE TABLE 数字图书馆时段访问量统计
	--TRUNCATE TABLE 数字图书馆新用户分析报表
	--TRUNCATE TABLE 数字图书馆用户每月消费分析报表
	--TRUNCATE TABLE 数字图书销售排名统计
	--TRUNCATE TABLE 用户与交易统计报表
	--TRUNCATE TABLE 智慧豆充值地域统计报表


	delete 乐奇家园答题统计报表 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 乐奇家园访问统计报表 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 乐奇家园领域分类统计报表 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 内容商结算清单 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 数字图书馆地域访问量统计 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 数字图书馆缴费用户转化率分析报表 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 数字图书馆年龄段访问量统计 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 数字图书馆时段访问量统计 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 数字图书馆新用户分析报表 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 数字图书馆用户每月消费分析报表 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 数字图书销售排名统计 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 用户与交易统计报表 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
	delete 智慧豆充值地域统计报表 WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 	
			
	SELECT StartT 
		into #TA 
		from Commonfun.dbo.fn_MonthList(1,0) 
		where StartT between @bgn And @end

	INSERT INTO 用户与交易统计报表(日期)
		SELECT StartT 
		FROM #TA
		
	INSERT INTO 内容商结算清单(日期,图书名称,馆别,内容商,单价)
		SELECT distinct	a.StartT, sb.book_title, lc.cat_title, 
						CASE lc.catid WHEN 19 then '双美' ELSE '好学宝' END, sb.bean_price / 5.0   
		FROM #TA a, sbapp.dbo.sb_book sb, sbapp.dbo.lib_category lc where sb.catid = lc.catid
	
	INSERT INTO 智慧豆充值地域统计报表(日期,地域,[30元],[50元],[100元],套餐充值,消费金额)
		SELECT a.StartT, b.name, 
		([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
		([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
		([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
		([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
		([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per
		FROM #TA a, 地区 b

		
	;WITH Ability AS
	(SELECT '辨别能力' aname
		union all
	SELECT '图形认知' 
		union all
	SELECT '分类思维' 
		union all
	SELECT '顺序排列' 
		union all
	SELECT '常识认知' 
		union all
	SELECT '情绪认知' 
		union all
	SELECT '逻辑思维' 
		union all
	SELECT '数学启蒙' 
		union all
	SELECT '空间知觉' 
),
Lev as
(
	SELECT '启蒙' lname
		union all
	SELECT '探索' 
		union all
	SELECT '拓展' 
),
Hard as
(
	SELECT '初阶' hname
		union all
	SELECT '中阶' 
)
	INSERT INTO 乐奇家园访问统计报表(日期,培养能力,阶段,难度)
		SELECT a.StartT, al.aname, l.lname, h.hname
		FROM #TA a,Ability al,Lev l,Hard h
		
	UPDATE 乐奇家园访问统计报表 
		SET 本月统计完成次数 = ([dbo].[fn_Random_Num]((70),(100),newid(),(2)))/100.0 * 本月统计进入次数,
				历史累计完成次数 = ([dbo].[fn_Random_Num]((70),(100),newid(),(2)))/100.0 * 历史累计进入次数
	WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 			
	
  INSERT INTO 乐奇家园领域分类统计报表(日期,培养能力,阶段,难度)
		SELECT 日期,培养能力,阶段,难度
			FROM 乐奇家园访问统计报表
	WHERE 日期 >= @bgn and 日期 < DATEADD(DD,1,@end) 			
			

	INSERT INTO 乐奇家园答题统计报表(日期,题目名称,培养能力,阶段,难度)		
			SELECT a.StartT, j.标题, j.领域,j.阶段,j.难度
		FROM #TA a,乐奇家园题目 j		
			
	;WITH dtime AS
	(SELECT '08-09' dname, 0.1 per
		union all
	SELECT '09-10', 0.2 
		union all
	SELECT '10-11', 1 
		union all
	SELECT '11-12', 1 
		union all
	SELECT '12-13', 0.1 
		union all
	SELECT '13-14', 0.2
		union all
	SELECT '14-15', 0.4
		union all
	SELECT '15-16', 0.2
		union all
	SELECT '16-17', 0.1 
		union all
	SELECT '17-18', 0.1 
		union all
	SELECT '18-19', 0.2 
		union all
	SELECT '19-20', 1 
		union all
	SELECT '20-21', 1.5 
		union all
	SELECT '21-22', 1 
)
	INSERT INTO 数字图书馆时段访问量统计(日期,访问时段,在线用户数,[阅读图书(本)],国学,学前,绘本,成长,科学,故事,益智)		
			SELECT a.StartT, d.dname,
			([dbo].[fn_Random_Num]((3000),(5000),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((6000),(12000),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per
		FROM #TA a,dtime d
		
	INSERT INTO 数字图书馆地域访问量统计(	日期,地域,[总阅读图书(本)],总阅读次数,[人均每次登录阅读图书(本)],
																				[人均每次登录阅读次数],[人均购买图书(本)],人均充值金额,平均加载时间)		
		SELECT a.StartT, b.name, 
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((1),(5),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((2),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((20),(100),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per
		FROM #TA a, 地区 b		
		
	INSERT INTO 数字图书销售排名统计(日期,图书名称,	所属馆藏,	内容商,	上线时间)
		SELECT	a.StartT, sb.book_title, lc.cat_title, 
						CASE lc.catid WHEN 19 then '双美' ELSE '好学宝' END, sb.onlinetime   
		FROM #TA a, sbapp.dbo.sb_book sb, sbapp.dbo.lib_category lc where sb.catid = lc.catid
		
			
	INSERT INTO 数字图书馆新用户分析报表
								(	日期,地域,本月新用户数,购买图书新用户数,无购买行为用户数,
									沉默用户数,新用户充值次数,新用户充值金额,新用户购买图书总数,
									总阅读次数,购买图书册数,平均每天阅读时间,平均每天阅读册数)		
		SELECT a.StartT, b.name, 
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per
		FROM #TA a, 地区 b			
			
	INSERT INTO 数字图书馆用户每月消费分析报表
								(	日期,地域,用户总数,购买用户数,无购买行为用户数,
									沉默用户数,用户充值次数,用户充值金额,购买图书总数,
									阅读次数,购买图书册数,平均每天阅读时间,平均每天阅读册数)		
		SELECT a.StartT, b.name, 
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((50),(200),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((5),(10),newid(),(2)))*b.per
		FROM #TA a, 地区 b	
					
	INSERT INTO 数字图书馆缴费用户转化率分析报表
								(	日期,地域,用户总数,缴费用户,上线新书,
									[1个月缴费用户数],[1个月转化率],
									[2个月缴费用户数],[2个月转化率],
									[3个月缴费用户数],[3个月转化率],
									半年缴费用户数,半年转化率,
									[≥6个月缴费用户数],[≥6个月转化率])		
		SELECT a.StartT, b.name, 
			([dbo].[fn_Random_Num]((10000),(20000),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((10000),(20000),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((10),(20),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((500),(1000),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((20),(50),newid(),(2)))/100.0	*b.per,
			([dbo].[fn_Random_Num]((500),(1000),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((20),(50),newid(),(2)))/100.0	*b.per,
			([dbo].[fn_Random_Num]((500),(1000),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((20),(50),newid(),(2)))/100.0	*b.per,
			([dbo].[fn_Random_Num]((500),(1000),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((20),(50),newid(),(2)))/100.0	*b.per,
			([dbo].[fn_Random_Num]((500),(1000),newid(),(2)))*b.per,
			([dbo].[fn_Random_Num]((20),(50),newid(),(2)))/100.0	*b.per
		FROM #TA a, 地区 b	
		
		

		
	;WITH age AS
	(SELECT '2岁以下' dname, 0.1 per
		union all
	SELECT '2-3岁', 0.2 
		union all
	SELECT '3-4岁', 0.6 
		union all
	SELECT '4-5岁',  0.6 
		union all
	SELECT '5-6岁',1
		union all
	SELECT '6岁以上',1.5
)
	INSERT INTO 数字图书馆年龄段访问量统计(日期,幼儿年龄,用户数,缴费用户数,缴费总额,国学,学前,绘本,成长,科学,故事,益智)		
			SELECT a.StartT, d.dname,
			([dbo].[fn_Random_Num]((100000),(300000),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((50000),(150000),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((600000),(1200000),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per, 
			([dbo].[fn_Random_Num]((1000),(1700),newid(),(2)))*d.per
		FROM #TA a,age d		
		
END

GO
