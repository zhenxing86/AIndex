USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_notebook_week_Report_List_Article]    Script Date: 05/14/2013 14:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[rep_notebook_week_Report_List_Article]
@chapterid int,
@douserid int=0
AS
select chapterid,chaptertitle,chaptercontent,c.createdate,t.userid,s.[name],subject,grade,c.exquisite from EBook..TNB_Chapter c
left join EBook..Tnb_teachingNoteBook t  on t.teachingnotebookid=c.teachingnotebookid
inner join BasicData..user_baseinfo s on s.userid=t.userid where c.chapterid=@chapterid and c.deletetag=1

if(@douserid=0 or exists(select top 1 @douserid,@chapterid,GETDATE() from rep_read_article 
		where articleid=@chapterid and userid=@douserid))
begin
return  @chapterid
end
else
begin
insert into rep_read_article(userid,articleid,intime)
select @douserid,@chapterid,GETDATE() 
return @chapterid
end



GO

--[rep_notebook_week_Report_List_Article] 71263,1
--select * from dbo.rep_read_article 


