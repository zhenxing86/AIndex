USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RightGetModel]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		麦
-- Create date: 
-- Description:	获得全权实体
-- =============================================
create PROCEDURE [dbo].[RightGetModel]
@right_id int
AS
BEGIN    
	SELECT [right_id],[site_id],[site_instance_id],up_right_id,right_name,right_code
    FROM sac_right
    WHERE [right_id]=@right_id
END
GO
