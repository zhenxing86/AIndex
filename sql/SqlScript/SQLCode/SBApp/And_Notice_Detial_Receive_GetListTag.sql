USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[And_Notice_Detial_Receive_GetListTag]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:  xie  
-- Create date: 2014-09-22  
-- Description: 获取推送的通知明细列表  
  
demo:  sms
And_Notice_Detial_Receive_GetListTag2 862892,1,5,0
  
select *from and_notice_detial where recuserid=801368  
select *from and_notice_batch where taskid=11  
  
update and_notice_detial set status=0 where recuserid=801368  
*/    
CREATE proc [dbo].[And_Notice_Detial_Receive_GetListTag]  
@userid int  
,@page int  
,@size int
,@type int =0 
as  
BEGIN  
   
DECLARE @fromstring NVARCHAR(2000)='' 
DECLARE @filterstring NVARCHAR(2000)=''    
declare @taskid table( pcount int,smsid bigint,title nvarchar(50),smscontent varchar(500))   
Declare @ss table (pcount int,sendtime datetime,name nvarchar(50),title nvarchar(50),smscontent varchar(500))   
      
SET @fromstring = ' and_notice_batch b   
 inner join and_notice_detial a   
  on b.taskid= a.taskid   
   where a.recuserid = @D1 '   

if @type=1 set @fromstring = @fromstring + ' and a.writetime>=''' + convert(varchar(10),getdate(),120)+''''
                
 --分页查询   
 insert into @taskid            
 exec sp_MutiGridViewByPager            
  @fromstring = @fromstring,      --数据集            
  @selectstring =             
  ' a.smsid,b.smstitle,b.smscontent',      --查询字段            
  @returnstring =             
  ' smsid,smstitle,smscontent',      --返回字段            
  @pageSize = @Size,                 --每页记录数            
  @pageNo = @page,                     --当前页            
  @orderString = 'b.writetime desc, b.taskid desc ',          --排序条件            
  @IsRecordTotal = 1,             --是否输出总记录条数            
  @IsRowNo = 0,  
  @D1 = @userid    
  
  update a Set [status] = 1, readtime = getdate()   
   output t.pcount,deleted.writetime sendtime,u.name,t.title,replace(replace(t.smscontent, '%stuname%', u.name), '%teaname%', u.name) smscontent  
    into @ss  
   from sms.dbo.and_notice_detial a  
    inner join @taskid t   
     on a.smsid = t.smsid  
    inner join basicdata.dbo.[user] u  
     on a.recuserid=@userid and a.recuserid = u.userid  
    
  select pcount,sendtime,name,title ,smscontent from @ss order by sendtime desc   
    
END  


--select cast(convert(varchar(10),getdate(),120) as datetime)

--and_notice_batch where writetime>='2014-11-23'

--and_notice_detial where writetime>='2014-11-23' and taskid=180
GO
