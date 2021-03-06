USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[OrgAdd]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加组织
--项目名称：Right
--建立人:麦
--说明：
--时间：2010-5-5
------------------------------------
CREATE PROCEDURE [dbo].[OrgAdd]
@org_name nvarchar(30),
@up_org_id int
 AS
BEGIN
    DECLARE @org_id int
    DECLARE @result int
    SELECT @result=COUNT(*) FROM sac_org WHERE org_id=@up_org_id
    IF @up_org_id=0 OR @result>0
        BEGIN
	     INSERT INTO [sac_org](
	     [org_name],[create_datetime],[up_org_id]
	     )VALUES(
	     @org_name,getdate(),@up_org_id
	     )
	     SET @org_id = @@IDENTITY
         RETURN @org_id
        END
    ELSE
       RETURN -1--上级组织不存在
  END



GO
