USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[TEMP_init]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TEMP_init]    
@date datetime    
as    



--整体情况描述，处理三日内趋势
select	kid, CAST(convert(varchar(10),@date,120) AS DATETIME) cdate,
				totalcount, realcount, absentcount, fs, ks, hlfy, 
				lbt, pz, fx, hy, szk, jzj, fytx, parentstake, 
				hyremark = 
							CASE WHEN hy > 0 and LEN(hyClass) > 0  then '本园有<span class="red">'+CAST(hy AS varchar(10)) 
						+ '例疑似红眼病</span>例出现，分别出现在<span class="red">'+ STUFF(hyClass,1,1,'')+ '</span>。' else '' end,
				normalremark = 				
							'实际晨检<span class="red">'+CAST(realcount AS varchar(10)) 
						+ '人</span>，缺勤<span class="red">'+ CAST(absentcount AS varchar(10)) 
						+ '人</span>，出勤率<span class="red">'+ STR(100.0 - absentcount * 100.0 / totalcount,4,2)+'%</span>。',
	muchremark = 	
							CAST(CASE WHEN szk * 1.0 / realcount >= 0.1 THEN '重点观察、' ELSE '' END
						+	CASE WHEN fs * 1.0 / realcount >= 0.1 THEN '发烧、' ELSE '' END
						+	CASE WHEN hlfy * 1.0 / realcount >= 0.1 THEN '喉咙发炎、' ELSE '' END
						+	CASE WHEN fx * 1.0 / realcount >= 0.1 THEN '腹泻、' ELSE '' END
						+	CASE WHEN fytx * 1.0 / realcount >= 0.1 THEN '服药提醒、' ELSE '' END AS varchar(400)),
				riseremark = 				
							CAST(STUFF(CASE WHEN fs > fs1 and fs1 > fs2 and (fs - fs2)*1.0/fs2 > 0.25 and fs > totalcount * 0.1 then '，发烧' ELSE '' END
						+	CASE WHEN ks > ks1 and ks1 > ks2 and (ks - ks2)*1.0/ks2 > 0.25 and ks > totalcount * 0.1 then '，咳嗽' ELSE '' END
						+	CASE WHEN hlfy > hlfy1 and hlfy1 > hlfy2 and (hlfy - hlfy2)*1.0/hlfy2 > 0.25 and hlfy > totalcount * 0.1 then '，喉咙发炎' ELSE '' END
						+	CASE WHEN lbt > lbt1 and lbt1 > lbt2 and (lbt - lbt2)*1.0/lbt2 > 0.25 and lbt > totalcount * 0.1 then '，流鼻涕' ELSE '' END
						+	CASE WHEN pz > pz1 and pz1 > pz2 and (pz - pz2)*1.0/pz2 > 0.25 and pz > totalcount * 0.1 then '，皮疹' ELSE '' END
						+	CASE WHEN fx > fx1 and fx1 > fx2 and (fx - fx2)*1.0/fx2 > 0.25 and fx > totalcount * 0.1 then '，腹泻' ELSE '' END
						+	CASE WHEN hy > hy1 and hy1 > hy2 and (hy - hy2)*1.0/hy2 > 0.25 and hy > totalcount * 0.1 then '，红眼病' ELSE '' END
						+	CASE WHEN szk > szk1 and szk1 > szk2 and (szk - szk2)*1.0/szk2 > 0.25 and szk > totalcount * 0.1 then '，重点观察' ELSE '' END
						+	CASE WHEN jzj > jzj1 and jzj1 > jzj2 and (jzj - jzj2)*1.0/jzj2 > 0.25 and jzj > totalcount * 0.1 then '，剪指甲' ELSE '' END
						+	CASE WHEN parentstake > parentstake1 and parentstake1 > parentstake2 
								and (parentstake - parentstake2)*1.0/parentstake2 > 0.25 and parentstake > totalcount * 0.1 then '，家长带回' ELSE '' END
						+	CASE WHEN fytx > fytx1 and fytx1 > fytx2 and (fytx - fytx2)*1.0/fytx2 > 0.25 and fytx > totalcount * 0.1 then '，服药提醒' ELSE '' END 
						+ '。',1,1,'') AS varchar(400)) 
into #T1
	from #sum_kid sk 
		OUTER APPLY
			(
				select top(1)kid as kid1, cdate as cdate1,totalcount as totalcount1, 
						realcount as realcount1, absentcount as absentcount1,
						fs as fs1, ks as ks1, hlfy as hlfy1, lbt as lbt1, pz as pz1, 
						fx as fx1,hy as hy1, szk as szk1, jzj as jzj1, 
						fytx as fytx1,parentstake as parentstake1 
					from record_mc_kid_day 
					where kid = sk.kid 
						and convert(varchar(10),@date ,120) > cdate 
					order by cdate desc
			)rm1
   OUTER APPLY
			(
				select top(1)totalcount as totalcount2, 
						realcount as realcount2, absentcount as absentcount2,
						fs as fs2, ks as ks2, hlfy as hlfy2, lbt as lbt2, pz as pz2, 
						fx as fx2,hy as hy2, szk as szk2, jzj as jzj2, 
						fytx as fytx2,parentstake as parentstake2  
					from record_mc_kid_day 
					where kid = rm1.kid1 
						and rm1.cdate1 > cdate 
					order by cdate desc
			)rm2

 where gdate = @date   
 
--处理某些或语句	
update #T1 
	set muchremark = '<span class="red">' + stuff(muchremark,LEN(muchremark),1,'') + '</span>人数偏多。'
	where muchremark <> ''	
	
update #T1 
	set riseremark = '<span class="red">' + riseremark + '近期持续上升，需预防传染病在园内流行。'
	where riseremark <> ''	

--重点关注班级，处理三日内趋势
select	kid,cid,cname, CAST(convert(varchar(10),@date ,120) AS DATETIME) cdate, gid, gorderby,
				totalcount, realcount, absentcount, fs, ks, hlfy, lbt, pz, fx, hy, szk, jzj, fytx, parentstake,				
				absentremark = 
							'实际晨检<span class="red">' + CAST(realcount AS varchar(10)) 
						+	'人</span>，缺勤<span class="red">'+ CAST(absentcount AS varchar(10)) 
						+ '人</span>，出勤率<span class="red">'+ STR(100.0 - absentcount * 100.0 / totalcount,4,2)+'%</span>。',						 
			  bgnmark = 
							CAST(month(@date) AS varchar(10))+ '月' 
						+ CAST(day(@date) AS varchar(10))+'日'+cname+'班晨检报告：',
				hyremark = 		 
							CASE WHEN hy > 0 and LEN(hyClass) > 0  then '本班有<span class="red">'
						+ CAST(hy AS varchar(10)) +'例疑似红眼病</span>例出现。' else '' end,
				muchremark = 	
							CAST(CASE WHEN szk * 1.0 / realcount >= 0.15 THEN '重点观察、' ELSE '' END
						+	CASE WHEN fs * 1.0 / realcount >= 0.15 THEN '发烧、' ELSE '' END
						+	CASE WHEN hlfy * 1.0 / realcount >= 0.15 THEN '喉咙发炎、' ELSE '' END
						+	CASE WHEN fx * 1.0 / realcount >= 0.15 THEN '腹泻、' ELSE '' END
						+	CASE WHEN fytx * 1.0 / realcount >= 0.15 THEN '服药提醒、' ELSE '' END  AS varchar(400)),
				riseremark = 
							CAST(CASE WHEN fs > fs1 and fs1 > fs2 and (fs - fs2)*1.0/fs2 > 0.5 and fs > totalcount * 0.15 then '，发烧' ELSE '' END
						+	CASE WHEN ks > ks1 and ks1 > ks2 and (ks - ks2)*1.0/ks2 > 0.5 and ks > totalcount * 0.15 then '，咳嗽' ELSE '' END
						+	CASE WHEN hlfy > hlfy1 and hlfy1 > hlfy2 and (hlfy - hlfy2)*1.0/hlfy2 > 0.5 and hlfy > totalcount * 0.15 then '，喉咙发炎' ELSE '' END
						+	CASE WHEN lbt > lbt1 and lbt1 > lbt2 and (lbt - lbt2)*1.0/lbt2 > 0.5 and lbt > totalcount * 0.15 then '，流鼻涕' ELSE '' END
						+	CASE WHEN pz > pz1 and pz1 > pz2 and (pz - pz2)*1.0/pz2 > 0.5 and pz > totalcount * 0.15 then '，皮疹' ELSE '' END
						+	CASE WHEN fx > fx1 and fx1 > fx2 and (fx - fx2)*1.0/fx2 > 0.5 and fx > totalcount * 0.15 then '，腹泻' ELSE '' END
						+	CASE WHEN hy > hy1 and hy1 > hy2 and (hy - hy2)*1.0/hy2 > 0.5 and hy > totalcount * 0.15 then '，红眼病' ELSE '' END
						+	CASE WHEN szk > szk1 and szk1 > szk2 and (szk - szk2)*1.0/szk2 > 0.5 and szk > totalcount * 0.15 then '，重点观察' ELSE '' END
						+	CASE WHEN jzj > jzj1 and jzj1 > jzj2 and (jzj - jzj2)*1.0/jzj2 > 0.5 and jzj > totalcount * 0.15 then '，剪指甲' ELSE '' END
						+	CASE WHEN fytx > fytx1 and fytx1 > fytx2 and (fytx - fytx2)*1.0/fytx2 > 0.5 and fytx > totalcount * 0.15 then '，服药提醒' ELSE '' END AS varchar(400)),
				(fs+ks+hlfy+lbt+pz+fx+hy+szk+jzj+fytx+parentstake) totalbz, --症状人次总数  
				CAST(0 AS bit) as yd
into #T2
	from #sum_cid sk 
		OUTER APPLY
			(
				select top(1)kid as kid1, cdate as cdate1,totalcount as totalcount1, 
						realcount as realcount1, notcome as absentcount1,
						fs as fs1, ks as ks1, hlfy as hlfy1, lbt as lbt1, pz as pz1, 
						fx as fx1,hy as hy1, szk as szk1, jzj as jzj1, fytx as fytx1 
					from rep_mc_class_checked_sum 
					where kid = sk.kid 
						and convert(varchar(10),@date ,120) > cdate 
					order by cdate desc
			)rm1
		OUTER APPLY
			(
				select top(1)totalcount as totalcount2, 
						realcount as realcount2, notcome as absentcount2,
						fs as fs2, ks as ks2, hlfy as hlfy2, lbt as lbt2, pz as pz2, 
						fx as fx2,hy as hy2, szk as szk2, jzj as jzj2, fytx as fytx2 
					from rep_mc_class_checked_sum 
					where kid = rm1.kid1 
						and rm1.cdate1 > cdate 
					order by cdate desc
			)rm2

 where gdate = @date   	
update #T2 
	set muchremark = '<span class="red">' + stuff(muchremark,LEN(muchremark),1,'') + '</span>人数偏多。'
	where muchremark <> ''	
	
update #T2 
	set riseremark = '<span class="red">' + riseremark + '</span>近期持续上升。'
	where riseremark <> ''	

--班级异动标志	
update #T2 
	set yd = 1
	where muchremark <> ''	
		 or riseremark <> ''
		 or hyremark <> ''

insert into dbo.rep_mc_class_checked_sum
(
	kid, cid, cname, totalcount, realcount, notcome, parentstake, exceptionsum, 
	fs, hlfy, ks, lbt, fx, hy, szk, pz, fytx, jzj, gorderby, cdate, yd, gid, [content]
) 
select t2.kid, t2.cid, t2.cname, t2.totalcount, 
		t2.realcount, t2.absentcount, t2.parentstake, t2.totalbz, t2.fs, t2.hlfy, t2.ks, t2.lbt, t2.fx,
		t2.hy, t2.szk, t2.pz, t2.fytx, t2.jzj,t2.gorderby, T2.cdate, T2.yd,t2.gid,''
	from #T2 t2 

update rep_mc_class_checked_sum 
set totalcount = t2.totalcount, 
		realcount = t2.realcount, 
		notcome = t2.absentcount, 
		parentstake = t2.parentstake, 
		exceptionsum = t2.totalbz, 
		fs = t2.fs,
		hlfy = t2.hlfy, 
		ks = t2.ks, 
		lbt = t2.lbt, 
		fx = t2.fx , 
		hy = t2.hy, 
		szk = t2.szk, 
		pz = t2.pz, 
		fytx = t2.fytx, 
		jzj = t2.jzj,
		yd = t2.yd, 
		formatecontent = 
				t2.absentremark + '$'
			+ t2.hyremark     + '$' 
			+ t2.muchremark		+ '$' 
			+ t2.riseremark		+ '$' ,
		[content] = 
				REPLACE(REPLACE(
					t2.bgnmark + 
					CASE WHEN t2.yd = 0 then '总体正常，感谢老师的细心工作，请继续保持！' 
					ELSE t2.hyremark + t2.muchremark + t2.riseremark      
						+'请加强本班的卫生清洁工作，防止传染病在本班流行。'
					END,
					'<span class="red">',''),'</span>','')		
--output inserted.*				
from rep_mc_class_checked_sum rm 
	inner join #T2 t2 
		on rm.kid = t2.kid
		and rm.cid = t2.cid
		and rm.cdate = t2.cdate 

INSERT INTO record_mc_kid_day(kid, cdate, totalcount, realcount, absentcount, fs, ks, hlfy, lbt, pz, fx, hy, szk, jzj, fytx,parentstake)  
	SELECT kid, cdate, totalcount, realcount, absentcount, fs, ks, hlfy, lbt, pz, fx, hy, szk, jzj, fytx,parentstake
		FROM #T1        

update record_mc_kid_day 
set totalcount = t2.totalcount, 
		realcount = t2.realcount, 
		absentcount = t2.absentcount, 
		parentstake = t2.parentstake, 
		fs = t2.fs,
		hlfy = t2.hlfy, 
		ks = t2.ks, 
		lbt = t2.lbt, 
		fx = t2.fx , 
		hy = t2.hy, 
		szk = t2.szk, 
		pz = t2.pz, 
		fytx = t2.fytx, 
		jzj = t2.jzj, 
		smscontent = 
				REPLACE(REPLACE(
					CAST(month(@date) AS varchar(10))+ '月'
				+ CAST(day(@date) AS varchar(10))+'日晨检报告：' 
				+ normalremark +  hyremark + muchremark + riseremark ,
				'<span class="red">',''),'</span>','')  ,		
		formatecontent =	
					hyremark			+ '$' 
				+ muchremark		+ '$'
				+ riseremark		+ '$'
				+ normalremark	+ '$'	
--output inserted.* 
from record_mc_kid_day rm 
	inner join #T1 t2 
		on rm.kid = t2.kid
		and rm.cdate = t2.cdate 		
if exists(select * from #T1)
select * from #T1
if exists(select * from #T2)
select * from #T2

GO
