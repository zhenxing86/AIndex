USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_test_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[hc_test_GetList] 
@userid int,
@testids varchar(1000)
AS  

SET NOCOUNT ON;      
--这是测评标题      
Select resultid, testid, score,adddate, ROW_NUMBER() Over(Partition by userid, testid Order by adddate Desc) Row
  Into #result
  From hc_test_result
  Where userid = @userid and deletetag = 1
  

Select a.testid, a.version, a.testcontent, a.instruction, a.weight, Isnull(b.score, 0) score,b.adddate
  From hc_test a Left Join #result b On b.Row = 1 and a.testid = b.testid
  where deletetag = 1 and (a.testid In (Select col From CommonFun.dbo.f_split(@testids, ','))  or @testids='-1')    
  order by b.adddate     
     
--这是问题      
Select testid, questionid, title, instruction, choosetype, convert(int,weight) weight        
  From hc_test_questions    
  Where deletetag = 1 and (testid In (Select col From CommonFun.dbo.f_split(@testids, ','))  or @testids='-1')    
  order by adddate      
     
--这里是答案    
Select choiceid, questionid, choice, titile, [content], result, convert(int,weight) weight    
  From hc_test_questions_choices    
  Where deletetag = 1    
     
--这是结果模版      
Select testid, moduleid, lowerscore, upperscore, instruction,adddate    
  From hc_test_result_module    
  Where deletetag = 1 and (testid In (Select col From CommonFun.dbo.f_split(@testids, ','))  or @testids='-1')    

--测评结果
Select a.testid, b.questionid, b.choiceid,a.adddate
  From #result a, hc_test_result_detail b
  Where a.resultid = b.resultid and b.deletetag = 1 and a.Row = 1
  
GO
