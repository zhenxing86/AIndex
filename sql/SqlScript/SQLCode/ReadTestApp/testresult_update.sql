USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testresult_update]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
--exec [testresult_update] 7,'14#良好#0#4#44$15#优秀#0#0#dffdf$','有待提高#0#4#每个孩子的成长有快有慢，请家长耐心等待，细心观察，特别是科学，它的奥妙在于探究和体验，多带孩子去接触大自然，激发其好奇心与探究欲望，多方面支持和鼓励孩子的探索行为。$'      
CREATE  proc [dbo].[testresult_update]   
               
@subid int,           
@toSubAnswers text,      
@toSubNewAnswers text    
as          
begin         
--更新现有     
update a set a.result=b.col2,a.startrange=b.col3,a.endrange=b.col4, a.resultcontent=b.col5  from TestResult a   join(        
select col1,col2,col3,col4,col5 from  CommonFun.dbo.fn_MutiSplitTSQL(@toSubAnswers,'$','#') ) b on a.id=b.col1 where col1 is not null    
--新增   
insert into TestResult(result,startrange,endrange,resultcontent,subid)        
 select col1,col2,col3,col4,@subid from  CommonFun.dbo.fn_MutiSplitTSQL(@toSubNewAnswers,'$','#')  where col1 is not null      
        
if(@@ERROR<>0)          
 return -1          
 else          
 return 1          
end  
GO
