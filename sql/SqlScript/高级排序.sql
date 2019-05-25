create table #temp
(
kid int,
kc int,
kname varchar(10)
)

insert into #temp
values(1,2,'a1')
insert into #temp
values(2,6,'a2')
insert into #temp
values(5,1,'a3')
insert into #temp
values(3,3,'a4')

insert into #temp
values(0,13,'heji')

select * from #temp

select kid,kname,kc from #temp 
order by (case when kid>0 then 0 else 1 end ) asc ,kc desc

drop  table #temp


 ;MERGE mcapp..stu_mc_day AS sm
			USING (select * from #T
			) t
			ON (sm.CheckDate = CONVERT(VARCHAR(10),t.cdate,120) and t.stuid = sm.stuid)
			WHEN MATCHED AND ISNULL(sm.ftype,0) = 0 and sm.cdate < t.cdate THEN -- ISNULL(sm.ftype,0) = 0 只更新未发家长短信的
			UPDATE SET 
				sm.tw = t.tw,
				sm.zz = t.zz,
				sm.card = t.card,
				sm.cdate = t.cdate,
				sm.adate = t.adate,
				sm.devid = t.devid,
				sm.gunid = t.gunid
			WHEN NOT MATCHED and ISNULL(t.stuid,'') <> '' THEN
			INSERT (CheckDate, kid, stuid, card, cdate, tw, zz, adate, devid, gunid)
			VALUES (t.cdate, t.kid, t.stuid, t.card, t.cdate, t.tw, t.zz, t.adate, t.devid, t.gunid);


;WITH CET AS
	(
		select *, ROW_NUMBER()OVER(PARTITION BY stuid,CONVERT(VARCHAR(10),cdate,120) 
																ORDER BY cdate desc) rowno 
			from #stu_mc_day_raw sm 
			where ISNUMERIC(tw) = 1
				and usertype_3EF5E8E0 = 0
	)

		select ID, stuid, card, cdate, tw,  
						zz, adate, devid, gunid, kid, Status
			into #T
			from CET 
			WHERE rowno = 1
