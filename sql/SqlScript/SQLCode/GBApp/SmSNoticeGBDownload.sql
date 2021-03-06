USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[SmSNoticeGBDownload]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SmSNoticeGBDownload]

 AS 	
update gbapp..archives_apply set status=2 where
status=1  and kid in(12511,15407,14979,14932,14931,14928,14923,14919,14917,14913,14912,14909,14869,14910,14918,14916,14926,15137,14933,14938)


insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
select t1.telephone,0,'尊敬的'+t2.name+'家长：您好，小朋友的成长档案已经制作完成，请及时登录网站下载.(幼儿园)',getdate(),t1.kid,88,getdate(),0,t1.userid
			from gbapp..archives_apply t1 
            left join basicdata..[user] t2 on t1.userid=t2.userid                     
            where 
			DateAdd(d,+1.5, applytime) <=getdate() and
			 status=1  and t1.kid not in(15407,14979,14932,14931,14928,14923,14919,14917,14913,14912,14909,14869,14910,14918,14916,14926,15137,14933,14938)

update gbapp..archives_apply set status=2 where
DateAdd(d,+1.5, applytime) <=getdate() and 
status=1  and kid not in(15407,14979,14932,14931,14928,14923,14919,14917,14913,14912,14909,14869,14910,14918,14916,14926,15137,14933,14938)

GO
