USE [SMS]਍ഀ
GO਍ഀ
/****** Object:  StoredProcedure [dbo].[sms_batch_GetListTag]    Script Date: 2014/11/24 23:27:51 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
/*          ਍ഀ
-- Author:      xie        ਍ഀ
-- Create date: 2014-01-03          ਍ഀ
-- Description:           ਍ഀ
-- Memo:            ਍ഀ
exec [sms_batch_GetListTag] 15723,1,10,'','2012-12-12','2014-1-7',-1, '', ''    ਍ഀ
*/          ਍ഀ
CREATE proc [dbo].[sms_batch_GetListTag]        ਍ഀ
@kid int,        ਍ഀ
@Page int,        ਍ഀ
@Size int,        ਍ഀ
@content nvarchar(50),        ਍ഀ
@bgndate datetime,        ਍ഀ
@enddate datetime,        ਍ഀ
@smstype int,     ਍ഀ
@name varchar(50) = '',     ਍ഀ
@mobile varchar(20) = ''    ਍ഀ
as        ਍ഀ
begin    ਍ഀ
  Create Table #taskid(taskid bigint)    ਍ഀ
  if @mobile <> ''    ਍ഀ
    insert Into #taskid    ਍ഀ
      Select taskid    ਍ഀ
        From sms.dbo.sms_message    ਍ഀ
        Where recmobile = @mobile and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
      Union all    ਍ഀ
      Select taskid    ਍ഀ
        From sms.dbo.sms_message_yx    ਍ഀ
        Where recmobile = @mobile and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
      Union all    ਍ഀ
      Select taskid    ਍ഀ
        From sms.dbo.sms_message_yx_temp  ਍ഀ
        Where recmobile = @mobile and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
      Union all    ਍ഀ
      Select taskid    ਍ഀ
        From sms.dbo.sms_message_curmonth    ਍ഀ
        Where recmobile = @mobile and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
      Union all    ਍ഀ
      Select taskid    ਍ഀ
        From SMS_History.dbo.sms_message    ਍ഀ
        Where recmobile = @mobile and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
  else if @name <> ''    ਍ഀ
  begin    ਍ഀ
    Select userid Into #userid From BasicData.dbo.[user] Where name = @name and kid = @kid    ਍ഀ
      ਍ഀ
    insert Into #taskid    ਍ഀ
      Select taskid    ਍ഀ
        From sms.dbo.sms_message    ਍ഀ
        Where recuserid In (Select userid From #userid)    ਍ഀ
          and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
      Union all    ਍ഀ
      Select taskid    ਍ഀ
        From sms.dbo.sms_message_yx    ਍ഀ
        Where recuserid In (Select userid From #userid)    ਍ഀ
          and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
      Union all    ਍ഀ
      Select taskid    ਍ഀ
        From sms.dbo.sms_message_yx_temp    ਍ഀ
        Where recuserid In (Select userid From #userid)    ਍ഀ
          and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
      Union all    ਍ഀ
      Select taskid    ਍ഀ
        From sms.dbo.sms_message_curmonth    ਍ഀ
        Where recuserid In (Select userid From #userid)    ਍ഀ
          and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
      Union all    ਍ഀ
      Select taskid    ਍ഀ
        From SMS_History.dbo.sms_message    ਍ഀ
        Where recuserid In (Select userid From #userid)    ਍ഀ
          and taskid > 0 and sendtime >= @bgndate and sendtime <= @enddate    ਍ഀ
          ਍ഀ
    Drop Table #userid    ਍ഀ
  end    ਍ഀ
      ਍ഀ
  select taskid,sender,smscontent,sendusercount,        ਍ഀ
         sendsmscount,sendtime,kid,sendtype,recobjid, sendmode,    ਍ഀ
         xuanwu,yimei,xian,writetime,smstype        ਍ഀ
    Into #batch        ਍ഀ
    from sms_batch         ਍ഀ
    where kid=@kid and sendtime>=@bgndate and sendtime<=@enddate and taskid>0        ਍ഀ
    ਍ഀ
  if Exists (Select * From #taskid)    ਍ഀ
    Delete #batch Where taskid not In (Select taskid From #taskid)    ਍ഀ
      ਍ഀ
  Drop Table #taskid    ਍ഀ
      ਍ഀ
  ;with cet as(        ਍ഀ
  select MAX(taskid)taskid,sender,smscontent,SUM(sendusercount)sendusercount,        ਍ഀ
  SUM(sendsmscount)sendsmscount,sendtime,kid,sendtype,recobjid, sendmode,    ਍ഀ
  SUM(xuanwu)xuanwu,SUM(yimei)yimei,SUM(xian)xian,max(writetime)writetime,smstype        ਍ഀ
  from #batch         ਍ഀ
  where kid=@kid and sendtime>=@bgndate and sendtime<=@enddate and taskid>0        ਍ഀ
  group by sender,smscontent, sendtime,kid,sendtype,recobjid,        ਍ഀ
   sendmode,smstype        ਍ഀ
  )        ਍ഀ
  select taskid,sender,ISNULL(u.name,u1.name) username,smscontent,sendusercount,        ਍ഀ
  sendsmscount,sendtime,c.kid,sendtype,recobjid, sendmode,    ਍ഀ
  xuanwu,yimei,xian,writetime,isnull(smstype,1)smstype    ਍ഀ
  into #t        ਍ഀ
  from cet c        ਍ഀ
   LEFT JOIN basicdata..[user] u         ਍ഀ
    on c.sender = u.userid          ਍ഀ
   LEFT JOIN ossapp..[users] u1         ਍ഀ
    on c.sender = u1.ID          ਍ഀ
      ਍ഀ
  Drop Table #batch    ਍ഀ
      ਍ഀ
  DECLARE @fromstring NVARCHAR(2000)              ਍ഀ
  SET @fromstring =               ਍ഀ
  ' #t where 1=1'           ਍ഀ
            ਍ഀ
  IF @content <> '' SET @fromstring = @fromstring + ' AND smscontent like ''%'' + @S1 + ''%'''                 ਍ഀ
  IF @smstype >0 SET @fromstring = @fromstring + ' AND smstype = @D1'    ਍ഀ
    ਍ഀ
 --分页查询              ਍ഀ
 exec sp_MutiGridViewByPager              ਍ഀ
  @fromstring = @fromstring,      --数据集              ਍ഀ
  @selectstring =               ਍ഀ
  ' taskid,sender,username,smscontent,sendusercount,        ਍ഀ
  sendsmscount,sendtime,kid,sendtype,recobjid,        ਍ഀ
  sendmode,xuanwu,yimei,xian,writetime,isnull(smstype,1)smstype',      --查询字段              ਍ഀ
  @returnstring =               ਍ഀ
  ' taskid,sender,username,smscontent,sendusercount,        ਍ഀ
  sendsmscount,sendtime,kid,sendtype,recobjid,        ਍ഀ
  sendmode,xuanwu,yimei,xian,writetime,smstype',      --返回字段              ਍ഀ
  @pageSize = @Size,                 --每页记录数              ਍ഀ
  @pageNo = @page,                     --当前页              ਍ഀ
  @orderString = ' sendtime desc ',          --排序条件              ਍ഀ
  @IsRecordTotal = 1,             --是否输出总记录条数              ਍ഀ
  @IsRowNo = 0,           --是否输出行号              ਍ഀ
  @D1 = @smstype,              ਍ഀ
  @S1 = @content,    ਍ഀ
  @S2 = @name,    ਍ഀ
  @S3 = @mobile    ਍ഀ
          ਍ഀ
  drop table #t          ਍ഀ
end ਍ഀ
GO਍ഀ
