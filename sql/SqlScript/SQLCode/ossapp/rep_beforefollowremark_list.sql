USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_beforefollowremark_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_beforefollowremark_list]  
@uid int=-1  
,@dept varchar(10)=''  
,@remindtype varchar(100)  
,@bgntime datetime  
,@endtime datetime  
,@page int   
,@size int  
  
 AS   
 --跟踪信息 提醒时间 类型 跟踪人 跟踪时间 状态  
   
   
select bk.remark  
 ,(case when year(bk.remindtime) in ('1900','2900') then '' else convert(varchar(10),bk.remindtime,120) end) remindtime  
 ,bk.remindtype,u.name,bk.intime,b.kid,b.kname   
 into #T  
 from [beforefollowremark] bk  
  inner join users u on u.ID=bk.[uid]  
  inner join dbo.[role] r on r.ID=u.roleid  
  left join beforefollow b on b.ID=bk.bf_Id
 where  u.bid=0  
 and   
  (r.duty=@dept or @dept='')  
 and   
  (bk.[uid]=@uid or @uid=-1)  
 and   
  (@remindtype='' or remindtype=@remindtype)  
  and bk.intime between @bgntime and @endtime  
  
  
      
   exec sp_GridViewByPager      
    @viewName = '#T',             --表名      
    @fieldName = 'remark,remindtime,remindtype,name,intime,kid,kname',      --查询字段      
    @keyName = 'intime',       --索引字段      
    @pageSize = @size,                 --每页记录数      
    @pageNo = @page,                     --当前页      
    @orderString = ' intime desc  ',          --排序条件      
    @whereString = ' 1 = 1  ' ,  --WHERE条件      
    @IsRecordTotal = 1,             --是否输出总记录条数      
    @IsRowNo = 0    
  
drop table #T  
  

GO
