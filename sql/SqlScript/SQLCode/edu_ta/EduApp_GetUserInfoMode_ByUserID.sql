USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[EduApp_GetUserInfoMode_ByUserID]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		lx
-- Create date: 2011-06-28
-- Description: 获取用户基本信息
--exec ClassApp_GetUserInfoMode_ByUserID 84557
-- =============================================
CREATE PROCEDURE [dbo].[EduApp_GetUserInfoMode_ByUserID] 
@userid int
AS
BEGIN
     
select userid,username,areaid,depid,did,smscount,parentid,headicon from group_user u


where userid=@userid


END



GO
