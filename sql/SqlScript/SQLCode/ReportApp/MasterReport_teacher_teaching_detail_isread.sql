USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_teacher_teaching_detail_isread]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[MasterReport_teacher_teaching_detail_isread] 
@chapterid int,
@douserid int=0
AS

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
