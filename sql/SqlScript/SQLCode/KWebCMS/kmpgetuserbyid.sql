USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmpgetuserbyid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-4-19
-- Description:	获取用户信息
-- =============================================
CREATE PROCEDURE [dbo].[kmpgetuserbyid] 
@userid int
AS
SELECT s.userid,LoginName,NickName,Mobile
FROM kmp..Sms_userMobile s
INNER JOIN kmp..T_Users u ON s.userid=u.ID
WHERE s.userid=@userid


GO
