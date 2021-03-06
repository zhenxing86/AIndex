USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[km_sendPhoneCode]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  蔡杰
-- Create date: <Create Date,,>  
-- Description: 发送手机验证码
CREATE PROCEDURE [dbo].[km_sendPhoneCode]
@phone varchar(100)
as
Set nocount on 

declare @identify_code Varchar(10)
Select @identify_code = LEFT(ABS(CHECKSUM(NEWID())), 4)

if commonfun.dbo.fn_cellphone(@phone) = 1
  Insert Into sms.dbo.sms_message_yx([Guid], recMObile, Status, content, Kid, WriteTime, sender, recuserid)  
    Values(replace(newid(), '-', ''), @phone, 10, '【' + @identify_code + '】这是你本次操作的验证码，请在10分钟内使用。', 0, Getdate(), 0, 0)
else begin
  Select -1, '手机号不正确'
  Return
end

if @@rowcount > 0 
  Select 0, '验证码已发送，请留意接收'
else 
  Select -1, '验证码发送失败，请重新发送'

Select @identify_code phonecode


GO
