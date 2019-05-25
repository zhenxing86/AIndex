USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[answer_Add]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--添加答案    
-- truncate table answer    
-- exec answer_Add 810375,18$40
CREATE proc [dbo].[answer_Add]    
 @userid int,    
 @ids varchar(500) ,
 @guid varchar(50)  
as    
begin    
declare @tb table(questionid int,optionid int)    
 
 insert into answer(questionid,optionsid,userid,answercode)    
 select col1,col2 ,@userid ,@guid               
    from CommonFun.dbo.fn_MutiSplitTSQL(@ids,',','$')     
 if(@@ERROR<>0)    
 return -1    
else    
 return 1
end
GO
