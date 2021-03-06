USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[attto_smstmp]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
exec [attto_smstmp] 13715
exec [Att_Sms_To_SmsTable] 13715
*/
CREATE PROCEDURE [dbo].[attto_smstmp] 
@kid int
AS
BEGIN

INSERT INTO [CardApp].[dbo].[att_sms]
           ([kid]
           ,[userid]
           ,[checktime]
           ,[issendsms])
select distinct kid, userid,checktime,0 from attendance 
where kid=@kid and issendsms=0 and usertype=0 and checktime>=cast(convert(varchar(10),getdate(),120)+' 00:00:00.001' as datetime)

update attendance set issendsms=1 where kid=@kid and issendsms=0

end


GO
