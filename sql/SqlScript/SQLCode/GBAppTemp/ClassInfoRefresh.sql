USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ClassInfoRefresh]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClassInfoRefresh]
@cid int
 AS

create table #tempList
(
teacher varchar(50),
hbid int ,
rownum int
)

insert into #templist
select top 4 t2.name+','+t2.mobile+','+t4.title,t5.hbid ,ROW_NUMBER() over(order by t2.userid) as rows  
from basicdata..user_class t1 
left join basicdata..[user] t2 on t1.userid=t2.userid 
left join basicdata..teacher t4 on t2.userid=t4.userid
left join homebook t5 on t1.cid=t5.classid
where t2.usertype=1 and t5.term='2013-1' and t1.cid=@cid
	
declare @t1 varchar(50),@t2 varchar(50),@t3 varchar(50),@t4 varchar(50)
declare @class_teacher nvarchar(100)
declare @hbid varchar(10)
set @t1=',,'
set @t2=',,'
set @t3=',,'
set @t4=',,'


select @t1=teacher,@hbid=hbid from #templist where rownum=1
select @t2=teacher from #templist where rownum=2
select @t3=teacher from #templist where rownum=3
select @t4=teacher from #templist where rownum=4


set @class_teacher=@t1+'|'+@t2 + '|'+@t3+'|'+@t4

update classinfo set class_teacher=@class_teacher  where hbid=@hbid


drop table #tempList



	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END


GO
