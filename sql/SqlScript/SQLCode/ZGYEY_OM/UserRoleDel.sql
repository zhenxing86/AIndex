USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[UserRoleDel]    Script Date: 2014/11/24 23:34:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UserRoleDel] 
@userid int
AS
DELETE FROM sac_user_role WHERE [user_id]=@userid



GO
