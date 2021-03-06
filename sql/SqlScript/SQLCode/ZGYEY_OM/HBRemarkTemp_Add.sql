USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[HBRemarkTemp_Add]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加一条记录 
--项目名称：storybook
--说明：
--时间：2011/11/20 21:20:08
------------------------------------
CREATE PROCEDURE [dbo].[HBRemarkTemp_Add]
@tmptype nvarchar(50),
@tmpcontent nvarchar(500),
@catid int,
@status int

 AS 
	INSERT INTO hb_remark_temp(
	[tmptype],[tmpcontent],[catid],[status],[lastUpdatetime]
	)VALUES(
	@tmptype,@tmpcontent,@catid,@status,GETDATE()
	)
	
IF @@ERROR <> 0	
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END

GO
