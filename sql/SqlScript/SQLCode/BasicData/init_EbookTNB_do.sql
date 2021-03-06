USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[init_EbookTNB_do]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--2、教案（tnb_teachingnotebook,tnb_chapter)教案的数据初始化以指定某个老师的数据导到另一个老师上去。不指定幼儿园
CREATE PROCEDURE [dbo].[init_EbookTNB_do]  
@fromuserid int,  
@touserid int  
as  
  
create table #ulist  
(  
 oid int,  
 nid int,  
 xid int,  
 btit varchar(30)  
)   
  
  
delete ebook..tnb_teachingnotebook where userid=@touserid  
insert into ebook..tnb_teachingnotebook(booktitle, createdate, userid, username, bookthemeswf, coverswf, backcoverswf, kid, term, kindergartenname, theme)
select [booktitle],[createdate],@touserid,[username],[bookthemeswf],[coverswf],[backcoverswf],[kid],[term],[kindergartenname],[theme]+10 from ebook..tnb_teachingnotebook where userid=@fromuserid  

insert into #ulist(oid,nid,btit)  
select teachingnotebookid,userid,booktitle from ebook..tnb_teachingnotebook where [theme]>5  
  
update #ulist set xid=teachingnotebookid from ebook..tnb_teachingnotebook where userid=@fromuserid and booktitle=btit  
  
  
UPdate c Set deletetag = 0 from ebook..tnb_chapter c where not exists (select top 1 1 from ebook..tnb_teachingnotebook b where b.teachingnotebookid=c.teachingnotebookid)   
  
insert into ebook..tnb_chapter  
select (select oid from #ulist where xid=[teachingnotebookid]),[chaptertitle],[contentsplit],[subject],[grade],[createdate],[chaptercontent],[ordernum],[textpagecount]   
from ebook..tnb_chapter where teachingnotebookid in (select xid from #ulist)  
  
update ebook..tnb_teachingnotebook set [theme]=[theme]-10 where [theme]>5  
  
  
drop table #ulist  

GO
