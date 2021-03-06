USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_istimesend]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--定时发送代理
CREATE PROCEDURE [dbo].[sms_istimesend]
AS
declare @Now varchar(50)  --当前时间
declare @Zero varchar(50) --当天零点

SET @Now = getdate()+0.0005
SET @Zero = str(year(@Now),4) + '-' + str(month(@Now),2) + '-' + str(day(@Now),2) + ' 00:00:00.000'

SET NOCOUNT ON

begin try

INSERT INTO sms..[sms_message](Guid,RecMobile,Content,Sender,Status,RecUserID,SendTime,WriteTime,Kid,Cid,Code)
SELECT t1.Guid,t1.RecMobile,t1.Content,t1.Sender,t1.Status,t1.RecUserID,t1.SendTime,t1.WriteTime,t1.Kid,t1.Cid,t1.Taskid FROM sms..sms_message_temp t1
WHERE t1.[SendTime] <= @Now AND t1.[SendTime] > @Zero AND t1.[Status] = 0 ORDER BY t1.[SendTime] ASC--AND t2.city<>240  


INSERT INTO sms..sms_message_yx(Guid,RecMobile,Content,Sender,Status,RecUserID,SendTime,WriteTime,Kid,Cid,Code)
SELECT t1.Guid,t1.RecMobile,t1.Content,t1.Sender,10,t1.RecUserID,t1.SendTime,t1.WriteTime,t1.Kid,t1.Cid,t1.Taskid FROM sms..sms_message_temp t1
WHERE t1.[SendTime] <= @Now AND t1.[SendTime] > @Zero AND t1.[Status] = 8  ORDER BY t1.[SendTime] ASC--AND t2.city<>240 

end try
begin catch
  DECLARE @ErrorMessage NVARCHAR(4000);
  DECLARE @ErrorSeverity INT;
  DECLARE @ErrorState INT;

  SELECT @ErrorMessage = ERROR_MESSAGE(),
          @ErrorSeverity = ERROR_SEVERITY(),
          @ErrorState = ERROR_STATE();

  Print @ErrorMessage Print @ErrorSeverity Print @ErrorState
  RAISERROR (@ErrorMessage,  @ErrorSeverity, @ErrorState);

  insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)  
    values('15915892144',0,'注意：sms_istimesend执行出错('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)

  return
end catch


UPDATE sms..sms_message_temp SET [Status]=1 WHERE [SendTime] <= @Now AND [SendTime] > @Zero AND [Status] = 0 
UPDATE sms..sms_message_temp SET [Status]=9 WHERE [SendTime] <= @Now AND [SendTime] > @Zero AND [Status] = 8 

Delete sms..sms_message_temp
  Output Deleted.smsid, Deleted.guid, Deleted.smstype, Deleted.recuserid, Deleted.recmobile, Deleted.sender, Deleted.content,
         Deleted.status, Deleted.sendtime, Deleted.writetime, Deleted.kid, Deleted.cid, Deleted.taskid, Getdate()
  Into sms..sms_message_temp_history(smsid, guid, smstype, recuserid, recmobile, sender, content,
                                     status, sendtime, writetime, kid, cid, taskid, dealdate)
  Where [SendTime] <= @Now AND [SendTime] > @Zero AND [Status] In (1, 9)


IF @@ERROR <> 0 
BEGIN
   RETURN(-1)
END
ELSE
BEGIN
   RETURN(1)
END








GO
