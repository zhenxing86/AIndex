USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_UpGradeClassGetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  oo        
-- Project:         
-- Create date: 2014-07-17        
-- Description: 获取导资料升班 列表  dataimport_UpGradeClassGetList 23115,'2014-07-21 18:24:28.857'     
-- =============================================        
CREATE proc [dbo].[dataimport_UpGradeClassGetList]      
@kid int,    
@intimestr datetime='1900-01-01'    
as      
begin   
if(@intimestr=Convert(datetime,'1900-01-01'))   
begin  
 select @intimestr=max(intime) from excel_upgrade_class  
end    
select u.ID,u.name,e.cname,e.newcname,e.newgrade,e.nopass,e.onepass,  
(case when g.gid is null  then '年级不存在,' else '' end)    
+(case when c.cid is null  then '原班级'+e.cname+'不存在,' else '' end)   
 +(case when ex.id>1 or ec.id>0  then '班级名称重复,' else '' end)  
+(case when ee.id>1  then '原班级有多条重复记录,' else '' end)  
  result,  
  (case when g.gid is null  then '1,' else '' end)    
+(case when c.cid is null  then '2,' else '' end)  
  +(case when ex.id>1 or ec.id>0   then '3,' else '' end)  
    +(case when ee.id>1  then '2,' else '' end)  
  resultno,e.id  
 from dbo.excel_upgrade_class e   
  outer apply   
 (select COUNT(1) id from excel_upgrade_class ex where ex.kid=@kid  and ex.intime=@intimestr  and e.newcname=ex.newcname and e.deletetag=1)  
 ex   
  outer apply   
 (select COUNT(1) id from excel_upgrade_class ee where ee.kid=@kid  and ee.intime=@intimestr  and e.newcname=ee.cname and e.deletetag=1)  
 ee   
 left join basicdata..grade g on e.newgrade=g.gname and e.deletetag=1  
left join basicdata..class c on e.cname=c.cname  and c.kid=@kid and c.deletetag=1 and c.iscurrent=1  
 outer apply   
 (select COUNT(1) id from basicdata..class ec where  ec.cname=e.newcname and kid=@kid and ec.iscurrent=1 and ec.deletetag=1 and e.onepass<>1 )  
 ec   
left join basicdata..class cnew on e.newcname=cnew.cname  and cnew.kid=@kid and cnew.deletetag=1   
left join ossapp..[users] u on e.inuserid= u.ID and u.deletetag=1    
 where e.kid=@kid and e.deletetag=1   and e.intime=@intimestr order by onepass asc    
   
end 
GO
