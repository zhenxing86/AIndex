use CommonFun
go
/*------------------------------------  
-- Author:      xie  
-- Create date: 2014-07-02   
-- Description: 设置所有幼儿园的当前学期  
-- Paradef:    
  
-- Memo:   
    declare @date datetime = getdate()
    exec commonfun.dbo.[SetCurTerm] 11061,@date 
  
  select  * from BasicData.dbo.kid_term where kid=11061
  select  * from BasicData.dbo.class_all where kid=11061 and term='2014-1'  --28
   select uca.* from basicdata..user_class_all uca
     inner join basicdata..[user] u on uca.userid=u.userid 
      where kid= 11061 and term='2014-1'   --1466
  delete from BasicData.dbo.kid_term where kid=11061 and term='2014-1'
 
 select * from BasicData.dbo.kid_term where kid=12511 and term='2014-1' 
 select  * from  basicdata..class_all where term='2014-1'
 
 SetCurTerm_Batch 0
------------------------------------*/  
alter PROCEDURE [dbo].[SetCurTerm_Batch]  
@hasTimeLimit int=1 --0：没有时间限制，1：有时间限制。
,@del_leave int =1  --0：不删除user_class_all表中离园的用户，1：删除user_class_all表中离园的用户
 AS   
  
begin   
    
Begin tran         
 
   
  
 DECLARE @type int,@term nvarchar(10)='1',@next_term nvarchar(10)='1',@date datetime =getdate(),   
 @t_date datetime,@result int=0,@canset int=0,@bgndate datetime,@enddate datetime 
 
 if( 
	  (CONVERT(varchar(10), @date,120) <> CONVERT(varchar(4), @date,120) +' 02-01') 
	  and (CONVERT(varchar(10), @date,120) <> CONVERT(varchar(4), @date,120) +' 09-01')
	  and @hasTimeLimit=1
  )
 begin
	return -1
 end
 
 set @t_date = dateadd(mm,2,@date)  
 select @next_term = CommonFun.dbo.fn_getCurrentTerm(0,@t_date,0)    
 exec Calkidterm 0, @next_term, @bgndate output, @enddate output    
 
 select distinct kid,@next_term term
  into #kin
  from BasicData..kindergarten k
   where deletetag=1 --and  actiondate>='2014-07-01'
   
 update kt set iscurrent=0     
  from BasicData..kid_term kt 
   inner join #kin k on k.kid=kt.kid and kt.iscurrent =1
   where  kt.term<>@next_term    
   
 ;Merge BasicData..kid_term kt 
 Using #kin b On kt.kid = b.kid and kt.term=b.term 
 When Matched Then  
  Update Set iscurrent=1,douserid=0,dotime=getdate()
 When not Matched Then  
  Insert (kid,term,bgndate,enddate,iscurrent,douserid,dotime)  
   Values (b.kid,b.term,@bgndate,@enddate,1,0,GETDATE())
 
 -- 将上一学期的成长档案设置，复制到新学期
  ;with cet as(
   SELECT kid, term,hbmodlist,gbmodlist,monadvset,celltype,cellset,
    ROW_NUMBER()over(partition by kid order by convert(datetime,left(term,4)+'-1'+right(term,1)+'-01') desc)rowno     
    FROM [NGBApp].[dbo].[ModuleSet] 
  )
  insert into [NGBApp].[dbo].[ModuleSet](kid, term,hbmodlist,gbmodlist,monadvset,celltype,cellset) 
   select kid, @next_term,hbmodlist,gbmodlist,case when isnull(monadvset,'')<>'' and right(@term,1)=1 then '9,10,11,12' 
	    when isnull(monadvset,'')<>'' and right(@term,1)=0 then '3,4,5,6' else '' end monadvset,celltype,
	   case when celltype=4 then 
	    case when right(@term,1)=1 then '9,10,11,12' else '3,4,5,6' end 
	   else cellset end  cellset  
    from cet  
     where rowno=1 and not exists(
      select * from [NGBApp].[dbo].[ModuleSet] ms
       where ms.kid=cet.kid and ms.term=@next_term
     )  
        
  --将class表数据copy到class_all  
  ;With Data as (  
	select k.term,c.cid, c.kid, c.cname, c.grade, c.[order], c.sname,c.actiondate,c.iscurrent,c.subno
	 from #kin k
	  inner join BasicData..Class c 
	   on k.kid=c.kid and c.deletetag=1
	)  
	Merge BasicData..class_all ca 
	Using Data b On ca.cid = b.cid and ca.term=b.term 
	When Matched Then  
	Update Set deletetag=1,cname = b.cname, grade = b.grade, [order] = b.[order]
	When not Matched Then  
	Insert (cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate) 
	 Values(b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,b.term,0); 
		   
  --将user_class表数据copy到user_class_all  
  --select * into #user_class
  --from (
  --  select cid,userid from basicdata..user_class uc 
  --   union
  --  select cid,userid from basicdata..leave_user_class luc 
  --  ) t
    
  -- insert into basicdata..user_class_all(cid,userid,term,actiondate,deletetag)  
  --  select uc.cid,userid,@next_term,GETDATE(),1  
  --   from #user_class uc
  --    inner join basicdata..class c 
  --     on uc.cid=c.cid 
  --    inner join #kin k on c.kid = k.kid
  --    where not exists(  
  --     select 1 from BasicData..user_class_all uca  
  --      where uc.cid=uca.cid and uc.userid =uca.userid 
  --      and term = @next_term and uca.deletetag=1
  --    )  
  insert into basicdata..user_class_all(cid,userid,term,actiondate,deletetag)  
    select uc.cid,userid,@next_term,GETDATE(),1  
     from basicdata..user_class uc
      inner join basicdata..class c 
       on uc.cid=c.cid 
      inner join #kin k on c.kid = k.kid
      where not exists(  
       select 1 from BasicData..user_class_all uca  
        where uc.cid=uca.cid and uc.userid =uca.userid 
        and term = @next_term and uca.deletetag=1
      )  
   
   --删除user_class_all表中离园的用户
   if @del_leave=1
   begin
	   delete uca
		from basicdata..user_class_all uca
		 inner join basicdata..class c 
		  on uca.cid=c.cid 
		 inner join #kin k on c.kid = k.kid
		where uca.term = @next_term and uca.deletetag=1 and not exists(    
		 select 1 from basicdata..user_class uc 
			where uc.cid=uca.cid and uc.userid =uca.userid 
		) 
   end
   
   drop table #kin--,#user_class
   set @result = 1      
 Commit tran                                    
           
 
 RETURN @result   
end  
  