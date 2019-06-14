USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[SmSNoticeGBDownload]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [SmSNoticeGBDownload]

CREATE PROCEDURE [dbo].[SmSNoticeGBDownload]

 AS 	

insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
select t1.recmobile,0,'尊敬的'+t2.name+'家长：您好，您提交的成长档案下载申请已经制作完成，请及时登录网站下载.(幼儿园)',getdate(),t1.kid,88,getdate(),0,t1.userid
			from ebook..gbdownloadlist t1 
            left join basicdata..[user] t2 on t1.userid=t2.userid                    
            where DateAdd(d,+2.8, applydate) <=getdate() and
			 status=3	

update [EBook].[dbo].[GBDownloadList] set status=2 where
DateAdd(d,+2.8, applydate) <=getdate() and 
status=3


GO
