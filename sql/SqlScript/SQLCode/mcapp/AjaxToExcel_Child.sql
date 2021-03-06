USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[AjaxToExcel_Child]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      Master谭      
-- Create date:       
-- Description:       
-- Memo:        
--1、幼儿IC卡绑定资料导出格式（如果有多张卡，列出多张IC卡号排在一起，按班级，姓名排序）：        
--    班级，姓名，IC卡号        
-- exec stuinfo_GetList 1,1000,'',-1,12511,''        
-- exec AjaxToExcel_Child 21935,'2014-01-22 00:00:00','2014-04-23 23:59:59',1       
*/        
CREATE PROCEDURE [dbo].[AjaxToExcel_Child]      
 @kid int,      
 @bgndate datetime =null,      
 @enddate datetime =null,      
 @flag int=0         
as        
BEGIN        
      
if @flag=1      
begin      
 select uc.name,uc.sex,uc.cname,ci.cardno,ci.udate,ci.openCardDate      
  from mcapp..cardinfo ci      
   inner join BasicData..User_Child uc       
    on ci.userid=uc.userid      
  where ci.kid = @kid and ci.udate>=@bgndate and ci.udate<=@enddate --and ci.openCardDate is not null      
  order by cardno      
end      
else      
begin      
 ;with cet as      
 (      
  select uc.userid,uc.name,uc.sex,uc.cname,c.cardno,      
   ROW_NUMBER()over(partition by uc.userid order by c.cardno)rowno      
   from BasicData..user_Child uc        
   left join cardinfo c         
   on uc.userid=c.userid        
   where uc.kid = @kid       
   --and uc.grade<>38        
 )      
 select userid,name, sex, cname, ISNULL([1],'') as card1,      
     ISNULL([2],'') card2,ISNULL([3],'') card3,ISNULL([4],'') card4      
  INTO #TA         
  from cet       
   pivot(max(cardno) for rowno in([1],[2],[3],[4])) as p      
      
 SELECT name,sex,cname,card1,card2,card3,card4      
 INTO #TB      
 FROM #TA      
 UNION      
 SELECT '合计' name,cast(COUNT(1) as varchar(10)),'','','','',''      
 FROM #TA      
 UNION      
 SELECT '一张' name,cast(COUNT(1) as varchar(10)),'','','','',''      
 FROM #TA where CommonFun.dbo.fn_CalCnt(card1,card2,card3,card4) = 1      
 UNION      
 SELECT '零张' name,cast(COUNT(1) as varchar(10)),'','','','',''      
 FROM #TA where CommonFun.dbo.fn_CalCnt(card1,card2,card3,card4) = 0      
 UNION      
 SELECT '两张' name,cast(COUNT(1) as varchar(10)),'','','','',''      
 FROM #TA where CommonFun.dbo.fn_CalCnt(card1,card2,card3,card4) = 2      
 UNION      
 SELECT '三张' name,cast(COUNT(1) as varchar(10)),'','','','',''      
 FROM #TA where CommonFun.dbo.fn_CalCnt(card1,card2,card3,card4) = 3      
 UNION      
 SELECT '四张' name,cast(COUNT(1) as varchar(10)),'','','','',''      
 FROM #TA where CommonFun.dbo.fn_CalCnt(card1,card2,card3,card4) = 4      
       
 select *       
  from #TB      
  order by case name       
   when '合计' then 1       
   WHEN '一张' THEN 2        
   WHEN '两张' THEN 3        
   WHEN '三张' THEN 4        
   WHEN '四张' THEN 5       
   WHEN '零张' THEN 6       
   ELSE 0 end,cname,name      
end      
END      
    
    
    
GO
