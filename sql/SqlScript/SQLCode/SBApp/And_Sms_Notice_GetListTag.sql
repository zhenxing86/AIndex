USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[And_Sms_Notice_GetListTag]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:  xie
-- Create date: 2014-09-22
-- Description: 获取发送的消息/通知列表

demo:
And_Sms_Notice_GetListTag 567195,1,100

select *from sms..sms_batch where sender=567195

*/  
create proc [dbo].[And_Sms_Notice_GetListTag]
@userid int
,@page int
,@size int
as
BEGIN

  select taskid,sender,smscontent,kid,sendtime,noreadcnt,isnotice,smstype,smstitle
   into #Msg
   from (
	  select anb.taskid,anb.sender,anb.smscontent,anb.kid,anb.sendtime,an.noreadcnt,1 isnotice,smstype,smstitle
	   from and_notice_batch anb
	   outer apply( select count(1) noreadcnt 
		from and_notice_detial d 
		 where anb.taskid=d.taskid and d.[status]=0
	   ) an
	   where anb.sender = @userid
	  union all
	  select ab.taskid,ab.sender,ab.smscontent,ab.kid,ab.sendtime,ab.sendusercount,0 isnotice,smstype,''
	   from sms_batch ab
	   where sender = @userid
	)t
   
 DECLARE @fromstring NVARCHAR(2000)          
 SET @fromstring = ' #Msg'          
  --IF @bgncard <> '' SET @fromstring = @fromstring + ' AND g.[cardno] like @S1 + ''%'''      
  --IF @usest <> -3 SET @fromstring = @fromstring + ' AND g.usest = @D2'                           
 --分页查询          
 exec sp_MutiGridViewByPager          
  @fromstring = @fromstring,      --数据集          
  @selectstring =           
  ' taskid,sender,smscontent content,kid,sendtime,noreadcnt,isnotice,smstype,smstitle',      --查询字段          
  @returnstring =           
  ' taskid,sender,content,kid,sendtime,noreadcnt,isnotice,smstype,smstitle',      --返回字段          
  @pageSize = @Size,                 --每页记录数          
  @pageNo = @page,                     --当前页          
  @orderString = ' sendtime desc,isnotice desc ',          --排序条件          
  @IsRecordTotal = 1,             --是否输出总记录条数          
  @IsRowNo = 0     
 
 drop table #Msg
END

GO
