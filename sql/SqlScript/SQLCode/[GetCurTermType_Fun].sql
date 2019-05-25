/*      
-- Author: xie      
-- Create date:  2014-04-12     
-- Description:  根据userid获取该小朋友的当前学期     
-- Memo:     
   [GetCurTermType_Fun] 295765    
*/    
  
  
create FUNCTION [dbo].[GetCurTermType_Fun]  
(  
 @userid int  
)  
RETURNS  int  
AS  
BEGIN   
    
declare @nowterm int,@gtype int,@termstr varchar(100),@curTermType int      
     
 select @termstr=healthapp.dbo.getTerm_New(isnull(kid,0),getdate())     
  from basicdata..[user]     
   where userid=@userid    
     
set @termstr=right(@termstr,1)      

select @gtype=(case when gtype>0       
  then gtype else       
  CASE CommonFun.dbo.fn_age(u.birthday)       
  WHEN 2 THEN 1 WHEN 3 THEN 1 WHEN 4 THEN 2 ELSE 3 END       
   end)      
  from  basicdata..[user] u       
  inner join basicdata..grade g on g.gid=
  ISNULL((Select top 1  grade from basicdata..class c  
			inner join basicdata..user_class uc 
			on uc.cid=c.cid and uc.userid=u.userid
				and c.deletetag=1),
		(Select top 1  grade from basicdata..class c  
			inner join basicdata..leave_user_class luc 
			on luc.cid=c.cid and luc.userid=u.userid
				and c.deletetag=1)
			)      
 where u.userid=@userid and u.usertype=0
 
        
      
if(@gtype=4)      
 set @gtype=1      
 --@gtype 1小班；2中班；3大班      
 --@termstr 1:上学期；0：下学期      
 if(@termstr=1)      
 begin      
  if(@gtype=1)set @nowterm=1      
  if(@gtype=2)set @nowterm=3      
  if(@gtype=3)set @nowterm=5      
 end      
 else if(@termstr=0)      
 begin      
  if(@gtype=1)set @nowterm=2      
  if(@gtype=2)set @nowterm=4      
  if(@gtype=3)set @nowterm=6     
 end     
     
 return  @nowterm   
 end