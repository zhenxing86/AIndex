USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_upgrade_class]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- =============================================  
-- Author:    
-- Project:   
-- Create date: 2014-07-17  
-- Description: 导资料升班  
*/--dataimport_upgrade_class 23115,'2014-07-22 14:36:55.440'  
CREATE PROCEDURE [dbo].[dataimport_upgrade_class]  
@kid int,  
@intime datetime='1900-1-1'  
AS  
BEGIN  
 Begin tran     
 BEGIN TRY    
 SET NOCOUNT ON  
   
 CREATE TABLE #T(cid int, cname nvarchar(50), grade int)  
 CREATE TABLE #grade(Newgid int, Oldgid int)  
  
 update e set e.onepass=1,e.nopass=0 from excel_upgrade_class e         
  left join basicdata..[class] c        
   on e.cname=c.cname and c.kid=@kid and c.deletetag=1             
  left join basicdata..[grade] g on g.gname=e.newgrade    
  where e.kid=@kid        
   and c.cid is not null  
   and intime = @intime        
   and c.cid is not null        
   and e.cname=c.cname  
   and g.gid is not null  
   and e.deletetag=1  
           
--如果导入的资料就有重复        
update excel_upgrade_class set onepass=0,nopass=1        
where cname in         
(select cname        
 from excel_upgrade_class e        
where kid=@kid and intime=@intime and  deletetag=1        
group by newcname,cname,newgrade having COUNT(1)>1)        
        
--修正        
update e set e.nopass=1 from excel_upgrade_class e         
  where e.kid=@kid        
   and intime = @intime        
   and e.onepass=0   
   and e.deletetag=1  
  
 insert into #T  
 select c.cid,e.newcname,g.gid from excel_upgrade_class e left join basicdata..grade g  
 on e.newgrade=g.gname  
 left join basicdata..class c on e.cname=c.cname and c.kid=@kid and c.deletetag=1  
  where e.kid=@kid and e.deletetag=1 and e.intime=@intime and e.onepass=1  
      
 IF EXISTS(select cname from #T GROUP BY cname having COUNT(1)> 1)    
 BEGIN  
  SELECT -1 result  
  goto ERRORReturn  
 END   
 IF EXISTS  
  (  
   select *   
    from #T t   
     inner join BasicData.dbo.class c   
      on c.kid = @kid   
      and c.cname = t.cname   
      AND c.deletetag = 1   
      and c.iscurrent=1  
      and not exists(select * from #T where cid = c.cid)    
  )  
 BEGIN  
  SELECT -1 result  
  goto ERRORReturn  
 END  
   
  UPDATE c   
   set cname = t.cname,  
     grade = t.grade,  
     [order] = NULL,  
     sname = ''  
   output inserted.grade,deleted.grade  
   into #grade(Newgid, Oldgid)    
   from BasicData.dbo.class c   
    inner join #T t   
     on c.cid = t.cid   
     and c.kid = @kid  
  ;WITH CET AS  
  (  
   SELECT *, ROW_NUMBER()OVER(PARTITION BY c.grade order by case when c.[order] is not null then 0 else 1 end,c.[order],c.cname)rowno   
    FROM BasicData.dbo.class c  
    where exists(select * from #grade where Newgid = c.grade or Oldgid = c.cid)  
     AND c.kid = @kid  
  ) update CET set [order] = rowno   
  
 --记录日志  
      insert into basicdata..class_all(cid,kid,cname,grade,[order],deletetag,sname,actiondate,iscurrent,subno,term,isgraduate)  
      select t.cid,c.kid,c.cname,c.grade,c.[order],1,c.sname,GETDATE(),c.iscurrent,c.subno,CommonFun.dbo.fn_getCurrentTerm(@kid,getdate(),1),   
      case when g.gname='毕业班' then 1 else 0 end from #T t   
      inner join basicdata..class c  on t.cid=c.cid   
      inner join basicdata..grade g on c.grade=g.gid  
      where c.cid is not null  
        
    
         
  Commit tran                                
 End Try        
 Begin Catch        
  Rollback tran    
  SELECT -1 result   
  goto ERRORReturn          
 end Catch   
 SELECT 1 result    
      --升学期  
  declare @curdatetime datetime =getdate(),@cansetterm int  
    
  select @cansetterm=CommonFun.dbo.fn_CanSetCurTerm(@kid,@curdatetime)  
  if(@cansetterm=1)  
  begin  
   exec CommonFun..SetCurTerm @kid,@curdatetime  
  end   
      
 IF 1 = 0  
 begin  
 ERRORReturn:  
 insert into basicdata..yeyErrorLog(DBName ,ProcName ,para ,Memo)  
  select 'BasicData','dataimport_upgrade_class',CAST(@kid AS VARCHAR(50))+';' + CONVERT(varchar(100), @intime, 21),'升班失败'  
      return  
 end   
   
   
 drop table  #T  
END  
GO
