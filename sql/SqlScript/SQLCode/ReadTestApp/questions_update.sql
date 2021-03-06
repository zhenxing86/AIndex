USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[questions_update]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
--exec questions_update 7,'你的孩子在提醒下能自然坐直吗？', 1,'22,愿意,4$23,,0$24,,0$','有时,3$不愿意,2$'    
CREATE  proc [dbo].[questions_update]        
@id int,        
@title nvarchar(200),        
     
@categoryid int,    
@toSubAnswers varchar(500),    
@toSubNewAnswers varchar(500)    
as        
begin       
--更新现有答案选项    
update a set a.score=b.col3,a.content=b.col2  from options a   join(      
select col1,col2,col3 from  CommonFun.dbo.fn_MutiSplitTSQL(@toSubAnswers,'$','#') ) b on a.id=b.col1 where col1>0    
--新增答案选项  
if(len(@toSubNewAnswers)>0)
begin  
insert into options(content,score,questionid)      
 select col1,col2,@id from  CommonFun.dbo.fn_MutiSplitTSQL(@toSubNewAnswers,'$','#')  where col1 is not null    
end      
update   Questions set title=@title , categoryid=@categoryid where id=@id        
if(@@ERROR<>0)        
 return -1        
 else        
 return 1        
end     
GO
