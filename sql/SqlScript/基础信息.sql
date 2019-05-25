SELECT SERVERPROPERTY('productversion') as '产品版本', SERVERPROPERTY ('productlevel') as '产品级别'  , SERVERPROPERTY ('edition') as '版本'

--userbaseinfo
select * from gbapp..moduleset where kid=4246;
select * from BasicData..child where userid = 328052
select * from BasicData..class where cid = 15186;
select * from BasicData..[user_class] where userid = 328052
select * from BasicData..user_baseinfo where userid = 328052
select * from PayApp..user_pay_account where userid = 328052
select * from basicdata..grade where gid = 36
select * from basicdata..kindergarten where kid =4246;
select * from gbapp..GrowthBook where userid = 328052 
--gbid = 22614  (用gbid = 105279)

--表之间的关系
select  u.userid,u.name,k.kid,k.kname,cls.cid,cls.cname,g.gid,g.gname,isnull(p.re_beancount,0) beancount,c.vipstatus,m.gbmodule,m.term,gb.gbid
	from BasicData..user_baseinfo u
	inner join BasicData..user_class uc on uc.userid =u.userid
	inner join BasicData..class cls on cls.cid =uc.cid
	inner join BasicData..kindergarten k on k.kid=cls.kid
	inner join GBApp..HomeBook hb on hb.kid =k.kid and hb.classid=cls.cid 
	inner join GBApp..GrowthBook gb on gb.hbid = hb.hbid and gb.userid = u.userid 
	inner join BasicData..grade g on g.gid = cls.grade
	inner join BasicData..child c on c.userid=u.userid
	left join PayApp..user_pay_account p on p.userid=u.userid
	inner join gbapp..moduleset m on m.kid = k.kid and m.term=gb.term 
	where u.userid=328052

--select * from ossapp..users;


--管理员、园长、老师、小朋友信息
select * from BasicData..[user] u  
--where u.usertype in (97,98)  --园长97、管理员98
--where u.usertype not in (97,98)  --园长、管理员
where u.usertype =0 --学生、家长
--where u.usertype =1 --教师

select * from ossapp..users --代理、中幼员工

select * from basicdata..area
select * from ossapp..agentarea --代理管辖区域



