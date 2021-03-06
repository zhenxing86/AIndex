USE [GameApp]
GO
/****** Object:  StoredProcedure [dbo].[GetTermsInfo]    Script Date: 2014/11/24 23:07:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
author: xzx         
datetime: 2014-03-14        
des: 根据userid获取乐奇分数及购买权限        

select *
   from ossapp..addservice a where a.deletetag=1 and a.[uid]=731255 and a.describe='开通'  and a.vippaystate=1  
    and a.ftime<=GETDATE() And a.ltime>=GETDATE() and a5>0 
        
memo： GetTermsInfo 731255        
buy 类型      
0 我们的用户+未购买+允许购买+JS：showBuy      
1 全部类型的用户+已购买      
2 家长学校用户+未购买+VIP标记+不允许购买+JS:showTip      
3 家长学校用户+学期为当前学期+未购买+VIP标记+允许以套餐方式购买+JS：showCDBuy      
      
blogapp..permissionsetting.ptype      
湖南创典家长学校  81      
开通家长网上缴费 89      
*/        
CREATE PROCEDURE [dbo].[GetTermsInfo]          
@userid int         
as        
 declare @curTermType int=0,@a81_a89 int =0,@ptype int=0,@usertype int =0,@kid int=0    
      
 select @kid=u.kid,@usertype = u.usertype,@ptype=ISNULL(p.ptype,0)    
  from BasicData..[user] u    
   left join blogapp..permissionsetting p     
    on p.kid =u.kid and p.ptype =33    
   where userid=@userid    
       
 --老师并且勾选老师可看乐奇家园。    
if @usertype>0 and @ptype>0 --老师可以看乐奇家园    
begin    
 select 1,1,1,1,1,1    
end    
else    
begin    
     set @curTermType =ossapp.dbo.GetCurTermType_fun(@userid)      
     select @a81_a89 = case count(distinct p.ptype) when 2 then 1 else 0 end      
      from blogapp..permissionsetting p       
   where p.kid =@kid and p.ptype in (81,89)    
    
  if exists( select 1  
   from ossapp..addservice a where a.deletetag=1 and a.[uid]=@userid and a.describe='开通'  --and a.vippaystate=1  
    and a.ftime<=GETDATE() And a.ltime>=GETDATE() and a5>0 )  
  begin  
 select 1,1,1,1,1,1   
  end  
  else  
  begin      
   select         
    case when CommonFun.dbo.fn_RoleGet(lqRight,1)=1 then 1 when @a81_a89=1 and @curTermType=1 then 3 when @a81_a89=1 and @curTermType<>1 then 2 else 0 end,        
    case when CommonFun.dbo.fn_RoleGet(lqRight,2)=1 then 1 when @a81_a89=1 and @curTermType=2 then 3 when @a81_a89=1 and @curTermType<>2 then 2 else 0 end,       
    case when CommonFun.dbo.fn_RoleGet(lqRight,3)=1 then 1 when @a81_a89=1 and @curTermType=3 then 3 when @a81_a89=1 and @curTermType<>3 then 2 else 0 end,       
    case when CommonFun.dbo.fn_RoleGet(lqRight,4)=1 then 1 when @a81_a89=1 and @curTermType=4 then 3 when @a81_a89=1 and @curTermType<>4 then 2 else 0 end,       
    case when CommonFun.dbo.fn_RoleGet(lqRight,5)=1 then 1 when @a81_a89=1 and @curTermType=5 then 3 when @a81_a89=1 and @curTermType<>5 then 2 else 0 end,       
    case when CommonFun.dbo.fn_RoleGet(lqRight,6)=1 then 1 when @a81_a89=1 and @curTermType=6 then 3 when @a81_a89=1 and @curTermType<>6 then 2 else 0 end      
    from BasicData..[user]        
  where userid=@userid    
  end  
end    
  
select userid,termtype,s1,s2,s3,s4,s5,s6,s7,s8,s9         
 from gameapp..lq_game_mark        
 where userid=@userid and deletetag=1     
GO
