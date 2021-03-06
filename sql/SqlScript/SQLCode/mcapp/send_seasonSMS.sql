USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[send_seasonSMS]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-13
-- Description:	过程用于发送季节更替的关怀短信
-- Memo: EXEC send_seasonSMS '春夏'
-- paradef ： '冬春','春夏','夏秋','秋冬'
*/  
CREATE PROCEDURE [dbo].[send_seasonSMS] 
	@season varchar(50)
as
BEGIN
	SET NOCOUNT ON
	
	DECLARE @describe NVARCHAR(2000),@ID int
	
	SELECT TOP(1)@describe = describe, @ID = ID 
		from zz_season_dict 
		WHERE season = @season
			and IsLastSend = 0
		order by NEWID()
	
	UPDATE zz_season_dict 
		SET IsLastSend = CASE WHEN ID = @ID then 1 else 0 end 	

	insert into sms_mc
					(smstype, recuserid, recmobile, sender, content, status, sendtime, writetime, kid)       
		select 11, u.userid,u.mobile,0, @describe, 0,getdate(),getdate(),k.kid
			from  mcapp.dbo.kindergarten k
				inner join BasicData.dbo.[user] u 
					ON k.kid = u.kid	
					and u.deletetag = 1	
					and u.usertype = 0		
			WHERE commonfun.dbo.fn_cellphone(u.mobile) = 1 --只发送手机号码合法的用户   
END

GO
