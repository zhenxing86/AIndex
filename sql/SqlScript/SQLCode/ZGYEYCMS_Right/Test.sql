USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[Test]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-9
-- Description:	测试存储过程
-- =============================================
CREATE PROCEDURE [dbo].[Test]

AS
SELECT right_id,site_id,site_instance_id,up_right_id,right_name,right_code
FROM sac_right
GO
