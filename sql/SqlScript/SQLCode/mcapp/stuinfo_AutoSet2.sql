USE mcapp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-20
-- Description:	
-- Memo:		
*/
ALTER PROCEDURE stuinfo_AutoSet
	@kid int,
	@type int = 0,-- 0 按幼儿园 ， 1 按班级 ， 2 按小朋友
	@str varchar(8000)= '',
	@flag int = 1 -- 1 开一张卡， 2， 开两张卡  
as  
BEGIN 
	SET NOCOUNT ON
  CREATE TABLE #ID(col int)
  IF @type <> 0
		INSERT INTO #ID
  		select distinct col 	--将输入字符串转换为列表
				from BasicData.dbo.f_split(@str,',')

	create table #temp
	(
		xid int IDENTITY,
		tuid int,
		name nvarchar(100),
		sex nvarchar(10),
		tcard varchar(20),
		tcard2 varchar(20),
		birthday varchar(20),
		cname varchar(20)
	)
IF @type = 0
	insert into #temp(tuid,name,sex,birthday,cname)
		SELECT	uc.userid,convert(varchar(10),ub.name),replace(replace(ub.gender,'2','女'),'3','男'),
						case when ub.birthday is null then '1900-01-01' else convert(varchar(10),ub.birthday,120) end, c.cname 
		FROM BasicData..class c
			inner join BasicData..user_class uc 
				on c.cid = uc.cid
			inner join BasicData..[user] u 
				on u.userid = uc.userid
			inner join BasicData..user_baseinfo ub 
				on ub.userid = uc.userid
			left join [stuinfo] s 
				on uc.userid = s.stuid
		where c.kid=@kid 
			and u.usertype=0 
			and u.deletetag=1 
			and s.card1 is null
			and s.card2 is null
			and s.card3 is null
			and s.card4 is null
		order by uc.cid
else if @type = 1
	insert into #temp(tuid,name,sex,birthday,cname)
		SELECT	uc.userid,convert(varchar(10),ub.name),replace(replace(ub.gender,'2','女'),'3','男'),
						case when ub.birthday is null then '1900-01-01' else convert(varchar(10),ub.birthday,120) end, c.cname 
		FROM BasicData..class c
			inner join #ID i on c.cid = i.col
			inner join BasicData..user_class uc 
				on c.cid = uc.cid
			inner join BasicData..[user] u 
				on u.userid = uc.userid
			inner join BasicData..user_baseinfo ub 
				on ub.userid = uc.userid
			left join [stuinfo] s 
				on uc.userid = s.stuid
		where c.kid=@kid 
			and u.usertype=0 
			and u.deletetag=1 
			and s.card1 is null
			and s.card2 is null
			and s.card3 is null
			and s.card4 is null
		order by uc.cid
else if @type = 2
	insert into #temp(tuid,name,sex,birthday,cname)
		SELECT	uc.userid,convert(varchar(10),ub.name),replace(replace(ub.gender,'2','女'),'3','男'),
						case when ub.birthday is null then '1900-01-01' else convert(varchar(10),ub.birthday,120) end, c.cname 
		FROM BasicData..class c
			inner join BasicData..user_class uc 
				on c.cid = uc.cid
			inner join BasicData..[user] u 
				on u.userid = uc.userid
			inner join #ID i on u.userid = i.col
			inner join BasicData..user_baseinfo ub 
				on ub.userid = uc.userid			
			left join [stuinfo] s 
				on uc.userid = s.stuid
		where c.kid=@kid 
			and u.usertype=0 
			and u.deletetag=1 
			and s.card1 is null
			and s.card2 is null
			and s.card3 is null
			and s.card4 is null
		order by uc.cid
if @flag = 2
begin		
	;with 
		cetc as 
		(
			select card,
			(ROW_NUMBER()over(order by [card])+1)/2 row1 
				from cardinfo 
					where kid=@kid 
					and usest = 0  
		) ,
		cetc1 as
		(
			select row1, MIN(card)Tcard, max(card) Tcard1 
				from cetc a 
					group by row1
		) 
		
		update #temp set Tcard = c.Tcard, Tcard2 = c.Tcard1
			from #temp t 
			inner join cetc1 c 
				on t.xid = c.row1
end
else if  @flag = 1
BEGIN
	;with tp as
	(
		select ROW_NUMBER() over (order by [card]) as rownum,[card]
		from cardinfo where usest=0 and kid=@kid 
	)
	update #temp set tcard=[card] from tp where rownum=xid
END 

	insert into stuinfo(stuid, name, sex, [card1], [card2], cname, birth, syntag, kid, exemk)
		select tuid, t.name, t.sex, tcard, tcard2, t.cname, birthday, 1, @kid, 1 
			from #temp t
				left join stuinfo s 
					on tuid = stuid
				where ISNULL(tcard,'') <> ''
					and stuid is null

	update cardinfo set usest = 1,udate = GETDATE() 
	from #temp  where tcard = [card] 
	
		update cardinfo set usest = 1,udate = GETDATE() 
	from #temp  where tcard2 = [card]

	delete stuid_tmp 
		where oid in 
			(select tuid 
				from #temp 
				WHERE ISNULL(tcard,'') <> ''
					and ISNULL(Tcard2,'') <> ''
			)

	drop table #temp

	delete [stuinfo] 
		where isnull([card1],'') = '' 
			and isnull([card2],'') = '' 
			and isnull([card3],'') = '' 
			and isnull([card4],'') = ''
END
GO
