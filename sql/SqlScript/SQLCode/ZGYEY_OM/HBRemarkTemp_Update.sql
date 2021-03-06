USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[HBRemarkTemp_Update]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改一条记录 
--项目名称：storybook
--说明：
--时间：2011/11/20 21:20:08
------------------------------------
CREATE PROCEDURE [dbo].[HBRemarkTemp_Update]
@tempid int,
@tmptype nvarchar(50),
@tmpcontent nvarchar(500),
@catid int,
@status int
 AS 
	UPDATE hb_remark_temp SET 
	[tmptype] = @tmptype,[tmpcontent] = @tmpcontent,[catid] = @catid,[status] = @status,lastUpdatetime=GETDATE()
	WHERE id=@tempid 



IF @@ERROR <> 0	
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END

GO
