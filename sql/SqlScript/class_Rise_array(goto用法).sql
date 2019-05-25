                      
/*                            
-- Author:      Master谭                            
-- Create date: 2013-07-04                            
-- Description: 过程用于批量升班                            
-- Memo:                            
      basicdata                      
select * from class where kid=17611 ORDER BY GRADE, [ORDER]                            
 EXEC class_Rise_array 23115,   '98574,aa,36 '                           
select * from class where kid=17611 ORDER BY GRADE, [ORDER]                            
                            
*/                            
CREATE PROCEDURE [dbo].[class_Rise_array]                            
 @kid int,                            
 @str varchar(8000)--【cid,new_cname,new_gradeid$cid,new_cname,new_gradeid】                           
 ,@douserid int=0                           
AS                            
BEGIN                            
 SET NOCOUNT ON                            
                             
 CREATE TABLE #T(cid int, cname nvarchar(50), grade int)                            
 CREATE TABLE #grade(Newgid int, Oldgid int)                            
                            
 insert into #T                            
 select col1,col2,col3                            
    from CommonFun.dbo.fn_MutiSplitTSQL(@str,'$',',')                               
                                
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
                             
 Begin tran                               
 BEGIN TRY                             
                           
 --升学期                           
 DECLARE @term nvarchar(10)='1',@next_term nvarchar(10)='1',                            
 @t_date datetime,@date datetime =getdate()                          
                             
 set @t_date = dateadd(mm,2,@date)                                          
 select @term = CommonFun.dbo.fn_getCurrentTerm(@kid,@date,0),@next_term = CommonFun.dbo.fn_getCurrentTerm(@kid,@t_date,0)                            
      
 --确保BasicData.dbo.kid_term当前学期有一条记录                          
 declare  @bgndate datetime ,@enddate datetime                          
 exec commonfun.dbo.Calkidterm @kid, @next_term, @bgndate output, @enddate output                       

          
 update kt set iscurrent=0                   
  from BasicData.dbo.kid_term kt                  
   where kt.kid = @kid and kt.iscurrent =1 and kt.term<>@next_term                  
                      
 ;With Data as (                
  select @kid kid,@next_term term              
 )                
 Merge BasicData.dbo.kid_term kt               
 Using Data b On kt.kid = b.kid and kt.term=b.term              
 When Matched Then                
  Update Set iscurrent=1,douserid=@douserid,dotime=getdate(),hasriseterm=1              
 When not Matched Then                
  Insert (kid,term,bgndate,enddate,iscurrent,douserid,dotime,hasriseterm)                   
   Values (b.kid,b.term,@bgndate,@enddate,1,@douserid,GETDATE(),1);              
             
  -- 将上一学期的成长档案设置，复制到新学期            
 ;with cet as(            
   SELECT kid, term,hbmodlist,gbmodlist,monadvset,celltype,cellset,            
    ROW_NUMBER()over(partition by kid order by convert(datetime,left(term,4)+'-1'+right(term,1)+'-01') desc)rowno      
    FROM [NGBApp].[dbo].[ModuleSet]            
     where kid = @kid             
  )            
  insert into [NGBApp].[dbo].[ModuleSet](kid, term,hbmodlist,gbmodlist,monadvset,celltype,cellset)          
   select kid, @next_term,hbmodlist,gbmodlist,case when isnull(monadvset,'')<>'' and right(@next_term,1)=1 then '9,10,11,12'           
     when isnull(monadvset,'')<>'' and right(@next_term,1)=0 then '3,4,5,6' else '' end monadvset,celltype,          
    case when celltype=4 then           
     case when right(@next_term,1)=1 then '9,10,11,12' else '3,4,5,6' end           
    else cellset end  cellset               
    from cet              
     where rowno=1 and not exists(            
      select * from [NGBApp].[dbo].[ModuleSet] ms            
       where ms.kid= @kid and ms.kid=cet.kid and ms.term=@next_term            
     )             
     --    --修改教学计划的名称      
   declare @curyear varchar(50),@cur_term varchar(50)      
   set @curyear= DateName(year,GETDATE())      
    select @cur_term=col2                        
    from CommonFun.dbo.fn_MutiSplitTSQL(@next_term,'$','-')         
          
    update b set classname=t.cname from #T  t join  EBook..PB_PlanBook b on t.cid=b.classid  and [year]= @curyear and b.term=@cur_term                              
     
 --老师user_class要同步                      
 --insert into user_class_all(cid,userid,term,actiondate,deletetag)                      
 -- select uc.cid,uc.userid,@next_term,getdate(),1                       
 --  from #T t                      
 --  inner join user_class uc on t.cid=uc.cid                      
 --  inner join [user] u on uc.userid = u.userid                      
 --   and u.deletetag=1 and u.usertype >0                      
 --  and not exists(                      
 --   select * from  user_class_all uca where uca.userid=uc.userid and uca.cid=uc.cid                       
 --    and uca.term=@next_term and uca.deletetag=1                      
 --  )      
     
  --user_class_all同步(班级不升的，all表也要新增一条记录)    
  insert into user_class_all(cid,userid,term,actiondate,deletetag)                      
  select uc.cid,uc.userid,@next_term,getdate(),1                       
   from user_class uc                  
   inner join [user] u on uc.userid = u.userid                      
    and u.deletetag=1 and u.kid= @kid                   
   and not exists(                      
    select * from  user_class_all uca where uca.userid=uc.userid and uca.cid=uc.cid                       
     and uca.term=@next_term and uca.deletetag=1                      
   )       
                       
                            
      --记录升班操作日志                        
 insert into class_changehistory(cid,cname,douserid,oldcname,newgrade,oldgrade,kid,term)                        
 select t.cid,t.cname,@douserid,c.cname, t.grade,c.grade,@kid,@next_term from #T  t join BasicData..class  c on t.cid=c.cid and kid=@kid                        
            
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
                            
  Commit tran                                                          
 End Try                                
 Begin Catch                   
  Rollback tran                              
  SELECT -1 result                             
  goto ERRORReturn                                    
 end Catch                             
 SELECT 1 result                             
                            
 IF 1 = 0                            
 begin                            
 ERRORReturn:                            
 insert into yeyErrorLog(DBName ,ProcName ,para ,Memo)                            
  select 'BasicData','class_Rise_array',CAST(@kid AS VARCHAR(50))+';' + @str,'升班失败'                            
      return                            
 end                             
                            
                             
 drop table  #T                            
END 