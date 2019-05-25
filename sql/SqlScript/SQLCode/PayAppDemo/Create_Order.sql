USE [PayAppDemo]
GO
/****** Object:  StoredProcedure [dbo].[Create_Order]    Script Date: 2014/11/24 23:24:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Create_Order]
@userid int,
@plusamount int,
@plus_bean int,
@orderno nvarchar(50),
@status int

 AS
INSERT INTO order_record(
	[userid],[plus_amount],[plus_bean],[actiondatetime],[orderno],[status]
	)VALUES(
	@userid,@plusamount,@plus_bean,getdate(),@orderno,@status
	)

insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('18028633611',5,'^_^有用户创建订单成功!金额'+Convert(nvarchar(20),@plusamount),getdate(),18,88,getdate(),0,0);

  IF @@ERROR<>0
  BEGIN  
    RETURN 0
  END
  ELSE
  BEGIN  
  Return @@IDENTITY
  END




GO
