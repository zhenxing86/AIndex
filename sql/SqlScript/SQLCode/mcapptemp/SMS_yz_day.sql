USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[SMS_yz_day]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-04-27
-- Description:	过程用于生成晨检每日园长短信
-- Paradef: @flag 0 早上执行
									1 晚上执行
-- Memo:		SMS_yz_day 1,'2013-09-20',0
*/  
CREATE PROCEDURE [dbo].[SMS_yz_day]
	@flag int = 0,
	@date date = null,
	@smstime int = 0
as
BEGIN
	SET NOCOUNT ON

	BEGIN--获取每日晨检信息
	IF @date = NULL SET @date = GETDATE()	 
	SELECT sm.stuid, sm.cdate, sm.tw, ',' + isnull(sm.zz,'')+',' zz, 
			uc.cid, uc.kid, uc.cname, uc.grade as gid, g.gname, g.[order] gorderby
		into #stu_mc_day 
		FROM stu_mc_day sm 
			inner join BasicData..user_Child uc 
				on uc.userid = sm.stuid			
			inner join BasicData..grade g 
				on g.gid = uc.grade 
				AND g.gid <> 38
			left join kindergarten k 
				on sm.kid = k.kid 
				and k.smstime = @smstime
				and k.smstime <> 0
		WHERE sm.CheckDate = @date
			and exists(select * from stu_mc_day sm1 where sm1.kid = sm.kid and sm1.CheckDate = sm.CheckDate and sm1.Status = 0)  
			and ISNULL(k.smstime,0) = @smstime
	
	select distinct kid, CAST(null as varchar(6))term into #kid from #stu_mc_day
	END
	BEGIN--处理健康档案的病症计数		
	update #kid set term = Healthapp.dbo.getTerm_New(kid, @date)		
	update ec 
		set lbtcount = ISNULL(ec.lbtcount,0) +		case when (zz like '%,4,%') then 1 else 0 end,
				hlfycount = ISNULL(ec.hlfycount,0) +	case when (zz like '%,3,%') then 1 else 0 end,
				kscount = ISNULL(ec.kscount,0) +			case when (zz like '%,2,%') then 1 else 0 end,
				fscount = ISNULL(ec.fscount,0) +			case when (zz like '%,1,%') then 1 else 0 end,
				hycount = ISNULL(ec.hycount,0) +			case when (zz like '%,7,%') then 1 else 0 end,
				szkcount = ISNULL(ec.szkcount,0) +		case when (zz like '%,8,%') then 1 else 0 end,
				fxcount = ISNULL(ec.fxcount,0) +			case when (zz like '%,6,%') then 1 else 0 end,
				pccount = ISNULL(ec.pccount,0) +			case when (zz like '%,5,%') then 1 else 0 end,
				jzjcount = ISNULL(ec.jzjcount,0) +		case when (zz like '%,9,%') then 1 else 0 end,
				fytxcount = ISNULL(ec.fytxcount,0) +	case when (zz like '%,10,%') then 1 else 0 end,
				gocount = ISNULL(ec.gocount,0) +			case when (zz like '%,11,%') then 1 else 0 end,
				recentupdate = CONVERT(VARCHAR(10),@date,120)
		from HealthApp.DBO.ExceptionCount ec 	
			inner join #kid k on ec.kid = k.kid			
			inner join HealthApp.DBO.BaseInfo bi 
				on ec.bid = bi.id
				and k.term = bi.term 
			inner join #stu_mc_day sm
				on bi.uid = sm.stuid
				and ec.kid = sm.kid
				and sm.zz <> ',,'
		where ec.recentupdate < @date				
	END	

	BEGIN--汇总生成班级信息
	select sm.kid,sm.cid, sm.cname,   --班级名称
	    sm.gid, sm.gorderby, 
			cc.Totalcnt totalcount, --班级总人数
			COUNT(1) AS realcount, --实检人数
			cc.Totalcnt - COUNT(1) AS absentcount,--缺勤人数
			sum(case when (zz like '%,1,%') then 1 else 0 end) fs,  --发烧人数
			sum(case when (zz like '%,2,%') then 1 else 0 end) ks,  --咳嗽人数
			sum(case when (zz like '%,3,%') then 1 else 0 end) hlfy,--喉咙发炎人数  
			sum(case when (zz like '%,4,%') then 1 else 0 end) lbt, --流鼻涕人数  
			sum(case when (zz like '%,5,%') then 1 else 0 end) pz,  --皮疹人数  
			sum(case when (zz like '%,6,%') then 1 else 0 end) fx,  --腹泻人数   
			sum(case when (zz like '%,7,%') then 1 else 0 end) hy,  --红眼病人数 
			sum(case when (zz like '%,8,%') then 1 else 0 end) szk, --重点观察病人数   
			sum(case when (zz like '%,9,%') then 1 else 0 end) jzj, --剪指甲人数   
			sum(case when (zz like '%,10,%') then 1 else 0 end) fytx, --服药提醒人数   
			sum(case when (zz like '%,11,%') then 1 else 0 end) parentstake, --家长带回人数   
			Commonfun.dbo.sp_GetSumStr(DISTINCT case when (zz like '%,7,%') then '，' + cname else '' end) hyClass,  --红眼病班级
			CAST('' as nvarchar(2000)) as content  			  
	into #sum_cid   
		from #stu_mc_day sm 
			join BasicData..ChildCnt_ForCid cc 
				on sm.kid = cc.kid 
				and sm.cid = cc.cid	
		group by sm.kid, cc.Totalcnt,sm.cid,sm.cname,sm.gid, sm.gorderby
	END	

	IF @flag = 1--/*晚上处理病症计数器*/
	BEGIN	
		;WITH s_total as
		(
		 select c.kid,uc.userid 
			from BasicData..user_class uc 
				inner join BasicData..[user] u   
					on uc.userid = u.userid
				inner join BasicData..class c 
					on uc.cid = c.cid 
				inner join #kid k 
					on k.kid = c.kid   
			where u.deletetag = 1   
				and u.usertype = 0   
		)
		select st.userid stuid, st.kid,
					case when (sm.zz like '%,1,%') then 1 else 0 end fs,  --发烧
					case when (sm.zz like '%,2,%') then 1 else 0 end ks,  --咳嗽
					case when (sm.zz like '%,3,%') then 1 else 0 end hlfy,--喉咙发炎  
					case when (sm.zz like '%,5,%') then 1 else 0 end pz,  --皮疹  
					case when (sm.zz like '%,6,%') then 1 else 0 end fx,  --腹泻   
					case when (sm.zz like '%,7,%') then 1 else 0 end hy  --红眼病
			into #zz_counter 
				from s_total st 
					left join #stu_mc_day sm 
						on st.kid = sm.kid 
						and st.userid = sm.stuid

		update zz_counter 
			set fs = CASE WHEN ISNULL(zc2.fs,0) > 0 THEN ISNULL(zc1.fs,0) + 1 ELSE 0 END,
					ks = CASE WHEN ISNULL(zc2.ks,0) > 0 THEN ISNULL(zc1.ks,0) + 1 ELSE 0 END,
					hlfy = CASE WHEN ISNULL(zc2.hlfy,0) > 0 THEN ISNULL(zc1.hlfy,0) + 1 ELSE 0 END,
					pz = CASE WHEN ISNULL(zc2.pz,0) > 0 THEN ISNULL(zc1.pz,0) + 1 ELSE 0 END,
					fx = CASE WHEN ISNULL(zc2.fx,0) > 0 THEN ISNULL(zc1.fx,0) + 1 ELSE 0 END,
					hy = CASE WHEN ISNULL(zc2.hy,0) > 0 THEN ISNULL(zc1.hy,0) + 1 ELSE 0 END,
					recentupdate = CONVERT(varchar(10),@date,120)
		from zz_counter zc1 
			inner join #zz_counter zc2
				on zc2.stuid = zc1.userid
				and zc2.kid = zc1.kid
		WHERE zc1.recentupdate < CONVERT(varchar(10),@date,120)
				
		INSERT INTO zz_counter(userid, kid, fs, ks, hlfy, pz, fx, hy,recentupdate)
			select stuid, kid, fs, ks, hlfy, pz, fx, hy,CONVERT(varchar(10),@date,120) 
				from #zz_counter
	END

	BEGIN--汇总成幼儿园信息
		select kid,
				CAST(0 AS INT) AS totalcount, --全园人数
				sum(realcount) AS realcount, --实检人数
				CAST(0 AS INT) AS absentcount,
				sum(fs) AS fs,  --发烧人数
				sum(ks) AS ks,  --咳嗽人数
				sum(hlfy) AS hlfy,--喉咙发炎人数  
				sum(lbt) AS lbt, --流鼻涕人数  
				sum(pz) AS pz,  --皮疹人数  
				sum(fx) AS fx,  --腹泻人数   
				sum(hy) AS hy,  --红眼病人数 
				sum(szk) AS szk, --重点观察病人数   
				sum(jzj) AS jzj, --剪指甲人数   
				sum(fytx) AS fytx, --服药提醒人数   
				sum(parentstake) AS parentstake, --家长带回人数    
				Commonfun.dbo.sp_GetSumStr(DISTINCT hyClass) AS hyClass  --红眼病班级   
		into #sum_kid   
			from #sum_cid
			group by kid
				
		UPDATE 	sk 
				SET totalcount = ck.Totalcnt,
						absentcount = ck.Totalcnt - sk.realcount 
			from #sum_kid sk 
				inner join BasicData..ChildCnt_ForKid ck 
				on sk.kid = ck.kid
	END	
			
	set ansi_warnings off
	SET ARITHABORT off
	SET ARITHIGNORE on
	
	BEGIN--幼儿园整体情况描述，处理三日内趋势
	select	sk.kid, @date cdate,
					sk.totalcount, sk.realcount, sk.absentcount, fs, ks, hlfy, 
					lbt, pz, fx, hy, szk, jzj, fytx, parentstake, 
					hyremark = 
								CASE WHEN hy > 0 and LEN(hyClass) > 0  then '本园有<span class="red">'+CAST(hy AS varchar(10)) 
							+ '例疑似红眼病</span>例出现，分别出现在<span class="red">'+ STUFF(hyClass,1,1,'')+ '</span>。' else '' end,
					normalremark = 				
								'实际出勤<span class="red">'+CAST(sk.realcount AS varchar(10)) 
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


	--处理某些或语句	
	update #T1 
		set muchremark = '<span class="red">' + stuff(muchremark,LEN(muchremark),1,'') + '</span>人数偏多。'
		where muchremark <> ''	
		
	update #T1 
		set riseremark = '<span class="red">' + riseremark + '近期持续上升，需预防传染病在园内流行。'
		where riseremark <> ''	
	END	
	
	BEGIN--重点关注班级，处理三日内趋势
	select	kid,cid,cname, CAST(convert(varchar(10),@date ,120) AS DATETIME) cdate, gid, gorderby,
					totalcount, realcount, absentcount, fs, ks, hlfy, lbt, pz, fx, hy, szk, jzj, fytx, parentstake,				
					absentremark = 
								'实际出勤<span class="red">' + CAST(sk.realcount AS varchar(10)) 
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
	END
	
	set ansi_warnings on
	SET ARITHABORT on	
	
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
from record_mc_kid_day rm 
	inner join #T1 t2 
		on rm.kid = t2.kid
		and rm.cdate = t2.cdate 	

--插入列表表明今天该幼儿园有进行晨检
INSERT INTO mc_kid_date_list(kid, cdate)
select distinct kid, CONVERT(varchar(10),cdate,120) 
	from #T1
	where 1.0 * realcount / totalcount >= 0.2	

--插入短信列表
IF @flag = 0 AND CONVERT(VARCHAR(10),@date,120) = CONVERT(VARCHAR(10),GETDATE(),120)
BEGIN
insert into [sms_mc](
       smstype, [recuserid], [recmobile], [sender], [content], [status], [sendtime], [writetime], [kid])
select 1, u.userid,u.mobile,0, 
CASE	WHEN 1.0 * T1.realcount/t1.totalcount < 0.3 then '尊敬的园长，您好，今日晨检出勤率少于30%，请您确认幼儿园网络是否正常，并已上传所有晨检枪上的晨检数据！'
			ELSE 
			REPLACE(REPLACE(CAST(month(@date) AS varchar(10))+ '月'
				 + CAST(day(@date) AS varchar(10))+'日晨检报告：' + normalremark 
				 + hyremark + muchremark + riseremark ,'<span class="red">',''),'</span>','') END,
		0,GETDATE(),GETDATE(),t1.kid
	from #T1 t1
		inner join [BasicData].[dbo].[user] u 
			ON t1.kid = u.kid				
		INNER JOIN sms_man_kid sm --只发送该表内的用户
			on sm.userid = u.userid and sm.roletype = 1
	WHERE commonfun.dbo.fn_cellphone(u.mobile) = 1 --只发送手机号码合法的用户
	
END
		    
DROP TABLE #T1,#T2,#stu_mc_day,#sum_cid,#sum_kid

END

GO
