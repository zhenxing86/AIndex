USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_enlistcount_Get]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --在线报名人数是否超过了在线报名限制人数   
CREATE  proc [dbo].[enlistonline_enlistcount_Get]    
@siteid int    
as    
  
declare @enlistcount int,@count int ,@begintime datetime,@endtime datetime ,@enliston int,@openenlistset int    
select @enlistcount=isnull(enlistcount,0),@begintime=isnull(bgntime,'1900-1-1'),@endtime=isnull(endtime,'1900-1-1'),  
@enliston=isnull(enliston,0),@openenlistset=isnull(openenlistset,0)   from site_config where siteid=@siteid   
     
   if(@openenlistset!=1)--没有开启在线报名设置    
 begin    
 return 1    
 end      
  
if(@enliston=0)--没有开启在线报名设置  
begin  
 return 1  
end  
  
if(@begintime='1900-1-1' and @endtime='1900-1-1')--没有设置时间，则不受人数限制  
begin  
 return 1  
end  
else if(@begintime='1900-1-1' and @endtime<>'1900-1-1')--没有设置开始时间  
begin  
return 1  
end  
else if(@begintime<>'1900-1-1' and @endtime='1900-1-1')--没有设置结束时间  
begin  
return 1  
end  
else  
begin  
select @count=COUNT(1) from enlistonline a left join site_config b on a.siteid=b.siteid where a.siteid=@siteid and createdatetime>=@begintime  
and  createdatetime<=@endtime  
end  
if(@enlistcount=0)  
begin  
 return 1  
end  
else   
begin  
 if(@enlistcount<=@count)  
 begin  
  return 0  
 end  
 else  
 begin  
  return 1  
 end  
end  
  
  
  
GO
