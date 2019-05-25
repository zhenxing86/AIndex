	
	
	--[Init_GrowthBook] 90580,'2014-0'  10850671 
	
	--declare @cid int=90580,@term nvarchar(20)='2014-0'
	declare @gbid table(gbid int)
	declare @diaryid table(diaryid bigint, pagetplid int)
	
	insert into @gbid
	SELECT g.gbid    
  FROM growthbook g
  left join diary d  
  on g.gbid=d.gbid and pagetplid in (11,12,13)
  where d.gbid is null
	--insert into @gbid values(10849148)
	;WITH CET AS
	(
		SELECT 11 AS pagetplid
		UNION ALL
		SELECT 12
		UNION ALL
		SELECT 13
	)				
			INSERT INTO diary(gbid,pagetplid)
				output inserted.diaryid, inserted.pagetplid
				into @diaryid(diaryid, pagetplid)
				SELECT g.gbid, c.pagetplid 
					from CET c cross join @gbid g
								
			INSERT INTO page_public(diaryid,ckey,cvalue,ctype)
				SELECT d.diaryid, ckey, cvalue, ctype 
					FROM page_public_tpl pp
						inner join @diaryid d
							on pp.pagetplid = d.pagetplid
							
	
		--HomeBook where cid = 90580 and term='2014-0'
		
		--select * into page_public_bak from page_public
		
		--select * from diary where gbid=10858004
		
		--select * from page_public where gbid=10858004
		
		--select * from growthbook where gbid=465407
		

--单独生成一个小朋友的成长档案
select *From basicdata..[user] where name='石承轩'

select *From basicdata..[user_child] where userid= 536959
select *From basicdata..grade where gid = 37

select *From basicdata..kindergarten where kid= 14919
select *From GBApp..archives_apply where userid= 536959
select *From nGBApp..growthbook where userid= 536959


insert into GBApp..archives_apply(gbid,gid,gname,cid,cname,kid,kname,userid,username,applytime,modules,term,deletetag,telephone,status,ftype)
select t.gbid,37,'大班',57410,'大二班',14919,'济南机车车辆厂幼儿园',536959,'石承轩',GETDATE(),modules,t.term,1,'123',0,1
From GBApp..archives_apply 
cross join (select 3748167 gbid,'2014-0' term
union 
select 13076647,'2014-1'
)t
where archivesapplyid=5
        	