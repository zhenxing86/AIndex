USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[YX_SMS_Test]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-08-02
-- Description:	
-- Paradef: select convert(varchar(20),getdate(),120)
-- Memo:	EXEC sqlagentdb..[YX_SMS_Test]
*/
CREATE PROCEDURE [dbo].[YX_SMS_Test] 
AS
BEGIN
	SET NOCOUNT ON

insert into sms.dbo.sms_message_yx(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid,code)
values('18028633611',10,'登记整点发送短信,悦信('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0,1)		
		
insert into sms.dbo.sms_message_yx(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid,code)
values('13682238844',10,'登记整点发送短信,悦信('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0,1)		
		
insert into sms.dbo.sms_message_yx(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid,code)
values('13808828988',10,'登记整点发送短信,悦信('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0,1)
		
insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('18028633611',0,'登记整点发送短信,玄武('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)
	
insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('13682238844',0,'登记整点发送短信,玄武('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)
		
				
insert into sms.dbo.sms_message_yx(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid,code)
values('18922209598',10,'登记整点发送短信,悦信('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0,1)		
		
				
insert into sms.dbo.sms_message_yx(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid,code)
values('13828463423',10,'登记整点发送短信,悦信('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0,1)		
	
insert into sms.dbo.sms_message_yx(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid,code)
values('13076761763',10,'登记整点发送短信,悦信('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0,1)		

insert into sms.dbo.sms_message_yx(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid,code)
values('18664733403',10,'登记整点发送短信,悦信('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0,1)		
	
	
insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('18122131135',0,'登记整点发送短信,玄武('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)
	
insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('15802027155',0,'登记整点发送短信,玄武('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)

insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('13318899399',0,'登记整点发送短信,玄武('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)
	
insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('15820288285',0,'登记整点发送短信,玄武('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)

insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('13076761763',0,'登记整点发送短信,玄武('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)
insert into sms.dbo.sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)
values('18664733403',0,'登记整点发送短信,玄武('+convert(varchar(20),getdate(),120)+')',getdate(),18,88,getdate(),0,0)


END	


GO
