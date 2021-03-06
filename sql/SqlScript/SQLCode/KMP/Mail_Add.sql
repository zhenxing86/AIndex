USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[Mail_Add]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--作者：along
--更新日期：2006-03-30
--功能：新增邮件和发件箱

CREATE PROCEDURE [dbo].[Mail_Add] 
	
	@Sender varchar(50),
	@Title varchar(500),
	@Recever varchar(50),
	@Body text

AS
declare @receverName varchar(50)
declare @senderName varchar(50)

select @receverName = Name from t_staffer where UserID = @Recever
if (@receverName is null)
begin
select @receverName = Name from t_child where UserID = @Recever
end

select @senderName = Name from t_staffer where UserID = @Sender
if (@senderName is null)
begin
select @senderName = Name from t_child where UserID = @Sender
end

insert into 
maillist(sender, recever, title, body, sendtime, readflag, typeflag, receverNames, sendername)
values(@sender, @Recever, @title, @Body, getdate(), 0, 'InBox', @receverName, @senderName)

insert into
sendboxlist (sender, title, recevernames, status, sendtime, body, recever)
values(@sender, @Title+'('+convert(varchar(20),getdate(),120)+')', @receverName, 1, getdate(), @Body, @Recever)

--select * from maillist

--exec mail_add 236, '短信', 238, '短信测试'

--select * from sendboxlist


GO
