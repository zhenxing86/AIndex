USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[GetSmsByType]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSmsByType]
@typeId int
AS
  select content,tid from SMS..sms_mobile_template where typeId =@typeId

GO
