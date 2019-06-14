USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_DBList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[cms_content_DBList]
@catid int,
@page int,
@size int

as 



create table #temp
(
a1 varchar(100)
,a2 varchar(100)
,a3 varchar(100)
,a4 varchar(1000)
,a5 datetime
,a6 varchar(100)
,a7 varchar(100)
,a8 varchar(100)
,a9 varchar(100)
)

declare @pcount int

SET ROWCOUNT @size
if(@catid=1)
begin
SELECT @pcount=count(*) from dbo.kindergarten_condition where isgood=1

select @pcount,kid,@catid,kname,intime,kurl from dbo.kindergarten_condition where isgood=1


end
else if(@catid=2)--教学教案
begin

SELECT @pcount=count(*) FROM Kwebcms..mh_doc_content_relation 
WHERE categorycode='MHJXJA' and status=1

insert into #temp
exec Kwebcms..[mh_portaldoccontent_GetListByPage] 'MHJXJA',@page,@size

select @pcount,a1 ID,@catid,a4 title,a5 intime,'http://blog.zgyey.com/'+a2+'/thelp/thelpdocview_'+a9+'_M1.html' from #temp
end
else if(@catid=3)-- 教学计划
begin

SELECT @pcount=count(*) FROM Kwebcms..mh_doc_content_relation 
WHERE categorycode='MHJHZJ' and status=1

insert into #temp
exec Kwebcms..[mh_portaldoccontent_GetListByPage] 'MHJHZJ',@page,@size

select @pcount,a1 ID,@catid,a4 title,a5 intime,'http://blog.zgyey.com/'+a2+'/thelp/thelpdocview_'+a9+'_M1.html' from #temp
end



drop table #temp











GO
