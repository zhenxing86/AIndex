USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[test_report]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
-- exec test_report 'D9DFD64D-0504-4D33-9C16-E204A4314146'    
CREATE proc [dbo].[test_report]    
@answercode varchar(50)    
as    
begin    
 
declare @testid int
select top 1 @testid=q.testid from answer a join Questions q on a.questionid=q.id  and q.deletetag=1
where a.answercode=@answercode

declare @tb table(categoryid int,categorytitle nvarchar(100),subtit nvarchar(100),scores int,subid int)

insert into @tb(categoryid,scores)
select  q.categoryid,SUM(o.score) scores from  answer a left join options o on a.optionsid=o.id
left join Questions q on o.questionid=q.id
where a.answercode=@answercode  group by q.categoryid 
 
update t set subtit=s.subtit ,subid=s.subid  from @tb t   join  SubCategory s on t.categoryid=s.categoryid and s.testid=@testid and s.deletetag=1
update t set categorytitle=c.categorytitle   from @tb t   join  Category c on t.categoryid=c.id and  c.deletetag=1 and c.deletetag=1
 
select t.categoryid,t.categorytitle,t.scores,t.subtit,isnull(r.result,'') result,isnull(r.resultcontent,'') resultcontent ,r.startrange,r.endrange  from @tb t left join TestResult r 
 on t.subid=r.subid and t.scores>=r.startrange and t.scores<r.endrange 
end    
    
    
    
   
GO
