USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_sendattendancesms]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_sendattendancesms]

 AS 


insert into T_SmsMessage_XW (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid)
select replace(newid(), '-', ''), t2.mobile,0,t2.name+'于 '+convert(nvarchar(20),t1.checktime,120)+'在幼儿园打卡成功',getdate(),58,t2.classid,getdate(),0,t1.userid
From attendance t1 left join t_child t2 on t1.userid=t2.userid where kid=58 and issendsms=0 and len(t2.mobile)=11

--select * from t_smsmessage_xw where status=7 order by id desc
--delete from t_smsmessage_xw where status=2 
GO
