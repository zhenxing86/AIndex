USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SMS_DealSmsTask]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--作者：along
--更新日期：2006-03-30
--功能：处理已发送成功的短信记录

CREATE PROCEDURE [dbo].[SMS_DealSmsTask]
	@ID int
AS
	update t_smsmessage_Emay set status = 1, writetime = getdate() where id = @ID and status = 0

GO
