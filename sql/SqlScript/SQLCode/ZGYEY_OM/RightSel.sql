USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RightSel]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		麦
-- Create date: 
-- Description:	获得上下级权限
-- =============================================
create PROCEDURE [dbo].[RightSel]
@right_id int
AS
BEGIN    
	SELECT a.[right_id],a.up_right_id,b.down_right_id
    FROM sac_right a left join 
    (select right_id as down_right_id,up_right_id as id from sac_right where up_right_id=@right_id) b
    on a.right_id=b.id
    WHERE a.[right_id]=@right_id
END








GO
