USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetClassTeacherInfo]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[GetClassTeacherInfo] 142

CREATE PROCEDURE [dbo].[GetClassTeacherInfo]
@hbid int
 AS
	create table #tempList
(
teacher varchar(50),
rownum int
)

if(exists(select 1 from hidemobilehbid where hbid=@hbid))
begin
	insert into #templist
	select top 4 t2.name+','+','+t4.title,ROW_NUMBER() over(order by t4.orderno, t4.title desc ) as rows  
	from basicdata..user_class t1 
	left join basicdata..[user] t2 on t1.userid=t2.userid 
	left join basicdata..teacher t4 on t2.userid=t4.userid
	left join homebook t5 on t1.cid=t5.classid
	where t2.usertype=1 and t5.hbid=@hbid 
	and t4.title <>'园长' and t4.title <>'管理员'--t1.cid=@cid
	order by t4.orderno asc,t4.title desc
end
else
begin
	insert into #templist
	select top 4 t2.name+','+t2.mobile+','+t4.title,ROW_NUMBER() over(order by t4.orderno, t4.title desc ) as rows  
	from basicdata..user_class t1 
	left join basicdata..[user] t2 on t1.userid=t2.userid 
	left join basicdata..teacher t4 on t2.userid=t4.userid
	left join homebook t5 on t1.cid=t5.classid
	where t2.usertype=1 and t5.hbid=@hbid 
	and t4.title <>'园长' and t4.title <>'管理员'--t1.cid=@cid
	order by t4.orderno asc,t4.title desc
end
--select * from #templist

declare @t1 varchar(50),@t2 varchar(50),@t3 varchar(50),@t4 varchar(50)
declare @class_teacher nvarchar(100)
set @t1=',,'
set @t2=',,'
set @t3=',,'
set @t4=',,'


select @t1=teacher from #templist where rownum=1
select @t2=teacher from #templist where rownum=2
select @t3=teacher from #templist where rownum=3
select @t4=teacher from #templist where rownum=4


set @class_teacher=@t1+'|'+@t2 + '|'+@t3+'|'+@t4
update classinfo set class_teacher=@class_teacher  where hbid=@hbid
select @class_teacher 


drop table #tempList

GO
