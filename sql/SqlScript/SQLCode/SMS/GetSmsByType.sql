USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[GetSmsByType]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSmsByType]
@typeId int
AS
  select content,tid from SMS..sms_mobile_template where typeId =@typeId
GO
   