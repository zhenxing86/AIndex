USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SMS_AddSmsMessageEmay]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--作者：along
--更新日期：2006-03-30
--功能：新增短信待发送表

CREATE PROCEDURE [dbo].[SMS_AddSmsMessageEmay] 
	
	@Mobile varchar(200),
	@Content varchar(500),
	@Kid int,
	@Cid int

AS

declare @SendTime1 varchar(50)
declare @SendTime2 varchar(50)
declare @SendTime3 varchar(50)

declare @Guid varchar(50)

declare @content1 varchar(500)
declare @content2 varchar(500)
declare @content3 varchar(500)

set @SendTime1=getdate()
set @SendTime2=getdate()
set @SendTime3=getdate()
set @content1 = @Content
set @Guid = replace(newid(), '-', '')


--print @content3
insert into T_SmsMessage_XW (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime)values(@Guid, @mobile,0,@content1,@SendTime1,@kid,@Cid,@SendTime1)







GO
