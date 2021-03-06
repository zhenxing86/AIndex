USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[docapp_init_documentcount]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[docapp_init_documentcount]

AS

create table #temp(
k int
,cid int
,cont int
)

-----------------------------共享给幼儿园------------------------------------------------
insert into #temp
select kid,kindoccategoryid,count(docid) from thelp_documents where kindisplay=1
group by kindoccategoryid,kid

--UPDATE kin_doc_category SET documentcount=0
UPDATE kin_doc_category SET documentcount=cont from #temp where k=kid and cid=kincategoryid

delete #temp

insert into #temp
select kid,parentid,sum(documentcount) from kin_doc_category 
where parentid>0 group by parentid,kid

UPDATE kin_doc_category SET documentcount=documentcount+cont from #temp where k=kid and cid=kincategoryid

--select kincategoryid,kid,documentcount from kin_doc_category
-----------------------------共享给幼儿园--------------------------------------------------



-----------------------------个人文档初始化------------------------------------------------

delete #temp
insert into #temp
select kid,categoryid,count(docid) from thelp_documents where deletetag=1
group by categoryid,kid 



UPDATE thelp_categories SET documentcount=cont from #temp where  cid=categoryid

delete #temp


insert into #temp
select 0,parentid,sum(documentcount) from thelp_categories 
where parentid>0 group by parentid

UPDATE thelp_categories SET documentcount=documentcount+cont from #temp where cid=categoryid


-----------------------------个人文档初始化------------------------------------------------

drop table #temp



GO
