  
  
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================   
/*
declare @date datetime=getdate()
  exec [hc_mc_GetModel] 567139,@date
*/ 
alter PROCEDURE [dbo].[hc_mc_GetModel]   
 @userid int,    
 @checktime datetime    
AS    
    
SET NOCOUNT ON;    
  
Declare @intime DateTime, @outtime DateTime, @kid Int, @degree Int, @content varchar(5000)  
Select @intime = intime, @outtime = outtime From mcapp.dbo.stu_in_out_time Where adddate > '2014-06-03'  
Select @kid = kid From BasicData.dbo.[user] Where userid = @userid  
  
Create Table #Temp(uname varchar(50), cname varchar(50), healthcnt int, sickcnt int, uncheckcnt Int,   
                   detail varchar(5000), isweak bit, degree int, content varchar(5000),   
                   headpicupdate datetime, headpic NVARCHAR(400))  
  
Insert Into #Temp(uname, cname, healthcnt, sickcnt, uncheckcnt, detail, isweak, degree, content, headpicupdate, headpic)  
  EXEC mcapp.dbo.rep_mc_child_checked_detail_GetModel @kid, @userid, @checktime  
  
Select @degree = degree, @content = content From #Temp  
  
Drop Table #Temp  
  
Select Top(1) temperature tw, Case WHen Isnull(result, '') = '' Then '正常' Else STUFF(  
       case when ','+result like '%,1,%' then ',发烧' else '' end +  
       case when (','+result like '%,2,%') then ',咳嗽' else '' end +  
       case when (','+result like '%,3,%') then ',喉咙发炎' else '' end +      
       case when (','+result like '%,4,%') then ',流鼻涕' else '' end +  
       case when (','+result like '%,5,%') then ',皮疹' else '' end +  
       case when (','+result like '%,6,%') then ',腹泻' else '' end +  
       case when (','+result like '%,7,%') then ',红眼病' else '' end +  
       case when (','+result like '%,8,%') then ',重点观察' else '' end +  
       case when (','+result like '%,9,%') then ',剪指甲' else '' end +  
       case when (','+result like '%,10,%') then ',服药提醒' else '' end +  
       case when (','+result like '%,11,%') then ',家长带回' else '' end, 1, 1, '') End [state],  
       @intime intime, @outtime outtime, @degree [index], @content [indexDesc],  
       0 zznew, 0 testnew, 0 grownew, 0 vaccinenew,
       case when a.ftime<=GETDATE() And a.ltime>=GETDATE() then a.a9 else 0 end a9   
  From mcapp.dbo.rep_mc_child_checked_detail d  
   left join ossapp..addservice a on a.deletetag=1 and d.userid=a.[uid] and a.describe='开通'  
  Where d.userid = @userid and CONVERT(varchar(10), checktime, 120) = CONVERT(varchar(10), @checktime, 120)  
  
  