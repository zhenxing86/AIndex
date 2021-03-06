USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[OrgUpdate]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改站点实例 
--项目名称：Right
--说明：
--时间：2010-5-5
------------------------------------
CREATE PROCEDURE [dbo].[OrgUpdate]
@org_id int,
@org_name nvarchar(30),
@up_org_id int
AS
BEGIN
    DECLARE @result int
    SELECT @result=COUNT(*) FROM sac_org WHERE up_org_id=@up_org_id
    IF @result<=0
        RETURN -2--上级组织不存在
    ELSE
    BEGIN
	UPDATE [sac_org] SET 
	[org_name] = @org_name,[create_datetime] = getdate(),[up_org_id] = @up_org_id
	WHERE org_id=@org_id 
    IF(@@ERROR<>0)
    BEGIN
	   RETURN (-1)
    END
    ELSE
    BEGIN
	   RETURN (1)
    END
   END
END
GO
