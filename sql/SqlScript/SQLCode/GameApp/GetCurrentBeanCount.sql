USE [GameApp]
GO
/****** Object:  StoredProcedure [dbo].[GetCurrentBeanCount]    Script Date: 2014/11/24 23:07:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[GetCurrentBeanCount]
@userid int
 AS 


select re_beancount from PayApp..user_pay_account where userid=@userid



GO
